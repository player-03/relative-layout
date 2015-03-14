package com.player03.relativelayout;

import com.player03.relativelayout.area.Area;
import com.player03.relativelayout.area.BoundedArea;
import com.player03.relativelayout.area.IRectangle;
import com.player03.relativelayout.area.StageArea;
import com.player03.relativelayout.instruction.Align;
import com.player03.relativelayout.instruction.LayoutInstruction;
import com.player03.relativelayout.instruction.Size;
import com.player03.relativelayout.Layout.BoundLayoutInstruction;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.Vector;

/**
 * @author Joseph Cloutier
 */
class Layout {
	/**
	 * The primary Layout. You may set this to a Layout that you designed,
	 * but once it's set, it can't be changed.
	 */
	public static var stageLayout(get, set):Layout;
	private static var _stageLayout:Layout;
	private static function get_stageLayout():Layout {
		if(_stageLayout == null) {
			_stageLayout = new Layout();
		}
		return _stageLayout;
	}
	private static function set_stageLayout(value:Layout):Layout {
		if(_stageLayout == null) {
			_stageLayout = value;
		}
		return _stageLayout;
	}
	
	public var scale(default, null):Scale;
	public var bounds(default, null):Area;
	
	private var instructions:Vector<BoundLayoutInstruction>;
	
	public function new(?scale:Scale, ?bounds:Area) {
		if(bounds == null) {
			this.bounds = StageArea.instance;
		} else {
			this.bounds = bounds;
		}
		
		if(scale == null) {
			this.scale = new Scale(Std.int(this.bounds.width), Std.int(this.bounds.height));
		} else {
			this.scale = scale;
		}
		
		this.bounds.addEventListener(Event.CHANGE, onBoundsChanged);
		
		instructions = new Vector<BoundLayoutInstruction>();
	}
	
	private function onBoundsChanged(e:Event):Void {
		apply();
	}
	
	/**
	 * Applies this layout, updating the position, size, etc. of each
	 * tracked object. Updates are done in the order they were added, so
	 * be sure to set size before setting position.
	 */
	public function apply():Void {
		for(instruction in instructions) {
			instruction.instruction.apply(instruction.target, instruction.area, scale);
		}
	}
	
	public function dispose():Void {
		bounds.removeEventListener(Event.CHANGE, onBoundsChanged);
		instructions = null;
	}
	
	/**
	 * Creates a new layout object within this one that's bounded in the
	 * given directions by the given objects.
	 */
	public function partition(?leftEdge:DisplayObject, ?rightEdge:DisplayObject,
					?topEdge:DisplayObject, ?bottomEdge:DisplayObject):Layout {
		var subArea:BoundedArea = new BoundedArea(bounds,
							leftEdge, rightEdge, topEdge, bottomEdge);
		//A BoundedArea serves as its own LayoutInstruction.
		add(null, subArea);
		
		return new Layout(scale, subArea);
	}
	
	/**
	 * Adds a layout instruction, to be run when the stage is resized and
	 * when apply() is called. If no "base" object is specified, the
	 * entire layout area will be used as the base.
	 * 
	 * This clears any conflicting instructions.
	 */
	public function add(target:DisplayObject,
						instruction:LayoutInstruction,
						?base:DisplayObject):Void {
		var i:Int = instructions.length - 1;
		while(i >= 0) {
			if(instructions[i].target == target
					&& InstructionMask.hasConflict(
						instructions[i].instruction.mask,
						instruction.mask)) {
				instructions.splice(i, 1);
			}
			i--;
		}
		
		var boundInstruction:BoundLayoutInstruction =
			new BoundLayoutInstruction(target,
						base != null ? base : bounds,
						instruction);
		instructions.push(boundInstruction);
		boundInstruction.instruction.apply(boundInstruction.target, boundInstruction.area, scale);
	}
	
	public inline function addMultiple(target:DisplayObject,
						instructions:Array<LayoutInstruction>,
						?base:DisplayObject) {
		for(instruction in instructions) {
			add(target, instruction, base);
		}
	}
}

/**
 * It's like bind(), except for a class.
 */
class BoundLayoutInstruction {
	public var target:DisplayObject;
	public var area:IRectangle;
	public var instruction:LayoutInstruction;
	
	public function new(target:DisplayObject, area:IRectangle, instruction:LayoutInstruction) {
		this.target = target;
		this.area = area;
		this.instruction = instruction;
	}
	
	public static function sortOrder(a:BoundLayoutInstruction, b:BoundLayoutInstruction):Int {
		//Conveniently, the mask bits are already in order. (Hopefully
		//they'll stay that way...)
		return a.instruction.mask - b.instruction.mask;
	}
}
