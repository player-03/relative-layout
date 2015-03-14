package com.player03.relativelayout.instruction;

import com.player03.relativelayout.area.IRectangle;
import com.player03.relativelayout.Direction;
import com.player03.relativelayout.instruction.LayoutInstruction.InstructionMask;
import com.player03.relativelayout.Scale;
import openfl.display.DisplayObject;

using com.player03.relativelayout.Direction.DirectionUtils;

/**
 * Each Align value represents alignment along only one axis. You will
 * have to use two Align values if you want to specify both horizontal
 * AND vertical alignment. It is strongly recommended that you apply
 * alignments after applying sizes.
 */
class Align implements LayoutInstruction {
	public static function edge(edge:Direction):Align {
		switch(edge) {
			case LEFT:
				return new Align(true);
			case RIGHT:
				return new PercentAlign(true, 1);
			case UP:
				return new Align(false);
			case DOWN:
				return new PercentAlign(false, 1);
		}
	}
	
	public static inline function center(horizontal:Bool):Align {
		return new PercentAlign(horizontal, 0.5);
	}
	public static inline function centerX():Align {
		return new PercentAlign(true, 0.5);
	}
	public static inline function centerY():Align {
		return new PercentAlign(false, 0.5);
	}
	
	public static inline function horizontalPercent(percent:Float):Align {
		return new PercentAlign(true, percent);
	}
	public static inline function verticalPercent(percent:Float):Align {
		return new PercentAlign(false, percent);
	}
	
	/**
	 * Places the target next to the area, in the given direction. Affects
	 * only one axis; if you want to adjust both, use Layout.adjacent().
	 */
	public static inline function adjacent(margin:Float, direction:Direction):Align {
		return new OutsideAlign(margin, direction);
	}
	
	/**
	 * Places the target inside the area, next to the given edge. Affects
	 * only one axis; if you want to adjust both, use Layout.adjacent().
	 */
	public static inline function inside(margin:Float, direction:Direction):Align {
		return new InsideAlign(margin, direction);
	}
	
	private var horizontal:Bool;
	public var mask:Int;
	
	public function new(horizontal:Bool) {
		this.horizontal = horizontal;
		mask = horizontal ? InstructionMask.AFFECTS_X : InstructionMask.AFFECTS_Y;
	}
	
	public function apply(target:DisplayObject, area:IRectangle, scale:Scale):Void {
		if(horizontal) {
			target.x = getCoordinate(area.x, area.width, target.width, scale.x);
		} else {
			target.y = getCoordinate(area.y, area.height, target.height, scale.y);
		}
	}
	
	private function getCoordinate(areaMin:Float, areaSize:Float, targetSize:Float, scale:Float):Float {
		return areaMin;
	}
}

/**
 * Define a location within the area as a percent of the distance from
 * the top/left to the bottom/right. For instance, new PercentAlign(0.25)
 * will place the display object towards the top or the left (depending
 * on which access this is used for).
 * 
 * It's possible to define percentages beyond [0, 1], but this is
 * discouraged, as the object will not be placed as far beyond the edge
 * as you might expect.
 */
class PercentAlign extends Align {
	private var percent:Float;
	
	public function new(horizontal:Bool, percent:Float) {
		super(horizontal);
		this.percent = percent;
	}
	
	private override function getCoordinate(areaMin:Float, areaSize:Float, targetSize:Float, scale:Float):Float {
		return percent * (areaSize - targetSize) + areaMin;
	}
}

/**
 * Places the target within the area, a short distance from the given edge.
 */
class InsideAlign extends Align {
	private var margin:Float;
	private var direction:Direction;
	
	public function new(margin:Float, direction:Direction) {
		super(direction.isHorizontal());
		this.margin = margin;
		this.direction = direction;
	}
	
	private override function getCoordinate(areaMin:Float, areaSize:Float, targetSize:Float, scale:Float):Float {
		if(direction.isTopLeft()) {
			return areaMin + margin * scale;
		} else {
			return areaMin + areaSize - margin * scale - targetSize;
		}
	}
}

/**
 * Places the target next to the area, a short distance from the given edge.
 */
class OutsideAlign extends Align {
	private var margin:Float;
	private var direction:Direction;
	
	public function new(margin:Float, direction:Direction) {
		super(direction.isHorizontal());
		this.margin = margin;
		this.direction = direction;
	}
	
	private override function getCoordinate(areaMin:Float, areaSize:Float, targetSize:Float, scale:Float):Float {
		if(direction.isTopLeft()) {
			return areaMin - margin * scale - targetSize;
		} else {
			return areaMin + areaSize + margin * scale;
		}
	}
}
