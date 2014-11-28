package com.player03.relativelayout;

import com.player03.relativelayout.area.Area;
import com.player03.relativelayout.area.IRectangle;
import com.player03.relativelayout.position.Direction;
import com.player03.relativelayout.position.Align;
import com.player03.relativelayout.position.Size;
import flash.display.DisplayObject;

/**
 * The commands used by the Layout class; these functions are what adjust
 * the position and scale of display objects.
 * 
 * Note: The functions in this class assume that display objects'
 * registration points are in the top left.
 * @author Joseph Cloutier
 */
class LayoutCommands {
	public static function adjacent(target:DisplayObject,
							base:IRectangle, direction:Direction,
							margin:Float = 0, ?alignment:Null<Align>):Void {
		switch(direction) {
			case LEFT:
				target.x = base.x - target.width - margin;
			case RIGHT:
				target.x = base.x + base.width + margin;
			case UP:
				target.y = base.y - target.height - margin;
			case DOWN:
				target.y = base.y + base.height + margin;
		}
		
		if(alignment == null) {
			alignment = CENTER;
		}
		switch(direction) {
			case LEFT, RIGHT:
				align(target, base, null, alignment);
			case UP, DOWN:
				align(target, base, alignment, null);
		}
	}
	
	public static function align(target:DisplayObject, base:IRectangle,
									?horizontal:Null<Align>,
									?vertical:Null<Align>):Void {
		if(horizontal != null) {
			target.x = base.x
				+ AlignUtils.toPercent(horizontal)
				* (base.width - target.width);
		}
		
		if(vertical != null) {
			target.y = base.y
				+ AlignUtils.toPercent(vertical)
				* (base.height - target.height);
		}
	}
	
	public static function size(target:DisplayObject, base:IRectangle,
							?horizontal:Null<Size>, ?vertical:Null<Size>) {
		if(horizontal != null) {
			switch(horizontal) {
				case RELATIVE(multiplier):
					target.width = base.width * multiplier;
				case ASPECT:
					//Special case: Handle this later.
			}
		}
		
		if(vertical != null) {
			switch(vertical) {
				case RELATIVE(multiplier):
					target.height = base.height * multiplier;
				case ASPECT:
					target.scaleY = target.scaleX;
			}
		}
		
		if(horizontal == ASPECT) {
			target.scaleX = target.scaleY;
		}
	}
}
