package com.player03.relativelayout;

import com.player03.relativelayout.area.Area;
import com.player03.relativelayout.area.BoundedArea;
import com.player03.relativelayout.area.StageArea;
import com.player03.relativelayout.position.Direction;
import com.player03.relativelayout.position.Align;
import com.player03.relativelayout.position.Size;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.Vector;

/**
 * @author Joseph Cloutier
 */
class Layout {
	public var area(default, null):Area;
	
	private var commands:Vector<Void -> Void>;
	
	public function new(?area:Area) {
		if(area == null) {
			this.area = StageArea.instance;
		} else {
			this.area = area;
		}
		
		this.area.addEventListener(Event.CHANGE, onAreaChanged);
		
		commands = new Vector<Void -> Void>();
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
		for(command in commands) {
			command();
		}
	}
	
	public function dispose():Void {
		area.removeEventListener(Event.CHANGE, onAreaChanged);
		commands = null;
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
		commands.push(subArea.refresh);
		
		return new Layout(subArea);
	}
	
	//Begin layout functions.
	
	/**
	 * Places an object left of, right of, above, or below a "base" object.
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
	 * If alignment is null, CENTER will be used instead.
	 */
	public function adjacent(target:DisplayObject,
							base:DisplayObject, direction:Direction,
							margin:Float = 0, ?alignment:Null<Align>):Void {
		commands.push(LayoutCommands.adjacent.bind(target, base, direction, margin, alignment));
	}
	
	/**
	 * Aligns the target's x and/or y coordinate with the base object.
	 * @param	target The object to place.
	 * @param	base The object to align with. If this is null, the target
	 * will be aligned within this layout's full area instead.
	 * @param	horizontal The horizontal alignment. See the Align enum
	 * for details. If this is null, the target's x coordinate will be
	 * unchanged.
	 * @param	vertical The vertical alignment. See the Align enum for
	 * details. If this is null, the target's y coordinate will be
	 * unchanged.
	 */
	public function align(target:DisplayObject, ?base:DisplayObject,
									?horizontal:Null<Align>,
									?vertical:Null<Align>):Void {
		commands.push(LayoutCommands.align.bind(target,
					base != null ? base : area,
					horizontal, vertical));
	}
	
	/**
	 * Sets the target's size.  Make sure you call this BEFORE adjusting
	 * the target's position. If you call it afterwards, it may mess up
	 * the alignment.
	 * @param	target The object to resize.
	 * @param	base The object to base the target's size on. If this is
	 * null, this layout's full area will be used instead.
	 * @param	horizontal Controls the target's width. See the Size enum
	 * for details. If this is null, the target's width will be unchanged.
	 * @param	vertical Controls the target's height. See the Size enum
	 * for details. If this is null, the target's height will be unchanged.
	 */
	public function size(target:DisplayObject, ?base:DisplayObject,
									?horizontal:Null<Size>,
									?vertical:Null<Size>):Void {
		commands.push(LayoutCommands.size.bind(target,
					base != null ? base : area,
					horizontal, vertical));
	}
}
