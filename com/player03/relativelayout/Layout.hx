package com.player03.relativelayout;

import com.player03.relativelayout.area.Area;
import com.player03.relativelayout.area.BoundedArea;
import com.player03.relativelayout.area.IRectangle;
import com.player03.relativelayout.area.StageArea;
import com.player03.relativelayout.instruction.Align;
import com.player03.relativelayout.instruction.LayoutInstruction;
import com.player03.relativelayout.instruction.Size;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.Vector;

/**
 * @author Joseph Cloutier
 */
class Layout {
	public var scale(default, null):Scale;
	public var area(default, null):Area;
	
	private var instructions:Vector<BoundLayoutInstruction>;
	
	public function new(scale:Scale, ?area:Area) {
		this.scale = scale;
		
		if(area == null) {
			this.area = StageArea.instance;
		} else {
			this.area = area;
		}
		
		this.area.addEventListener(Event.CHANGE, onAreaChanged);
		
		instructions = new Vector<BoundLayoutInstruction>();
	}
	
	private function onAreaChanged(e:Event):Void {
		apply();
	}
	
	/**
	 * Applies this layout, updating the position, size, etc. of each
	 * tracked object.
	 * Currently, commands are applied in the order they were registered.
	 * In the future, sanity-checking may be performed, but for the
	 * moment you should be sure to register everything in order.
	 */
	public function apply():Void {
		for(instruction in instructions) {
			instruction.instruction.apply(instruction.target, instruction.area, scale);
		}
	}
	
	public function dispose():Void {
		area.removeEventListener(Event.CHANGE, onAreaChanged);
		instructions = null;
	}
	
	//Begin partition function(s).
	
	/**
	 * Creates a new layout object within this one that's bounded in the
	 * given directions by the given objects.
	 */
	public function partition(?leftEdge:DisplayObject, ?rightEdge:DisplayObject,
					?topEdge:DisplayObject, ?bottomEdge:DisplayObject):Layout {
		var subArea:BoundedArea = new BoundedArea(area,
							leftEdge, rightEdge, topEdge, bottomEdge);
		//A BoundedArea serves as its own LayoutInstruction.
		add(null, subArea);
		
		return new Layout(scale, subArea);
	}
	
	//Begin layout functions.
	
	/**
	 * Places an object left of, right of, above, or below a "base"
	 * object. Adjusts both axes. If you only want to adjust one, use
	 * Align.adjacent().
	 * @param	target The object to place.
	 * @param	base The target will be placed relative to this object.
	 * @param	direction The target will be placed in this direction
	 * relative to the base.
	 * @param	margin This much space will be left between the two objects.
	 * @param	alignment How the target should be aligned with the base,
	 * along whichever axis was not already set. Example: if direction is
	 * LEFT, that controls the x coordinate, so this will set the
	 * target's y coordinate.
	 * 
	 * If alignment is null, the target will be centered.
	 */
	public function adjacent(target:DisplayObject,
							base:DisplayObject, direction:Direction,
							margin:Float = 0, ?alignment:Align):Void {
		add(target, Align.adjacent(margin, direction), base);
		
		if(alignment == null) {
			alignment = Align.center(direction == UP || direction == DOWN);
		}
		add(target, alignment, base);
	}
	
	/**
	 * Adds a layout instruction, to be run when the stage is resized and
	 * when apply() is called. If no "base" object is specified, the
	 * entire layout area will be used as the base.
	 */
	public inline function add(target:DisplayObject,
						instruction:LayoutInstruction,
						?base:DisplayObject):Void {
		instructions.push(new BoundLayoutInstruction(target,
						base != null ? base : area,
						instruction));
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
}
