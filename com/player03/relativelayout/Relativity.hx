package com.player03.relativelayout;

import com.player03.relativelayout.instruction.Align;
import com.player03.relativelayout.instruction.Size;
import flash.display.DisplayObject;

/**
 * A bunch of convenience functions. Name chosen to sound cool.
 * @author Joseph Cloutier
 */
class Relativity {
	/**
	 * The Layout object that will be used if you don't specify one. You
	 * may update this at any time.
	 */
	@:isVar public static var defaultLayout(get, set):Layout;
	private static function get_defaultLayout():Layout {
		if(defaultLayout == null) {
			defaultLayout = Layout.stageLayout;
		}
		return defaultLayout;
	}
	private static inline function set_defaultLayout(value:Layout):Layout {
		return defaultLayout = value;
	}
	
	private static inline function check(layout:Layout):Layout {
		if(layout == null) {
			return Relativity.defaultLayout;
		} else {
			return layout;
		}
	}
	
	//Place objects relative to one another:
	
	/**
	 * Places the object left of the target, separated by the given margin.
	*/
	public static inline function leftOf(objectToPlace:DisplayObject, target:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.adjacent(margin, LEFT), target);
	}
	/**
	 * Places the object right of the target, separated by the given margin.
	 */
	public static inline function rightOf(objectToPlace:DisplayObject, target:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.adjacent(margin, RIGHT), target);
	}
	/**
	 * Places the object above the target, separated by the given margin.
	 */
	public static inline function above(objectToPlace:DisplayObject, target:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.adjacent(margin, UP), target);
	}
	/**
	 * Places the object below the target, separated by the given margin.
	 */
	public static inline function below(objectToPlace:DisplayObject, target:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.adjacent(margin, DOWN), target);
	}
	
	/**
	 * Places the object left of the target, centered vertically, and
	 * separated by the given margin.
	 */
	public static inline function leftOfCenter(objectToPlace:DisplayObject, target:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		layout = check(layout);
		layout.add(objectToPlace, Align.adjacent(margin, LEFT), target);
		layout.add(objectToPlace, Align.centerY(), target);
	}
	/**
	 * Places the object right of the target, centered vertically, and
	 * separated by the given margin.
	 */
	public static inline function rightOfCenter(objectToPlace:DisplayObject, target:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		layout = check(layout);
		layout.add(objectToPlace, Align.adjacent(margin, RIGHT), target);
		layout.add(objectToPlace, Align.centerY(), target);
	}
	/**
	 * Places the object above the target, centered horizontally, and
	 * separated by the given margin.
	 */
	public static inline function aboveCenter(objectToPlace:DisplayObject, target:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		layout = check(layout);
		layout.add(objectToPlace, Align.adjacent(margin, UP), target);
		layout.add(objectToPlace, Align.centerX(), target);
	}
	/**
	 * Places the object below the target, centered horizontally, and
	 * separated by the given margin.
	 */
	public static inline function belowCenter(objectToPlace:DisplayObject, target:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		layout = check(layout);
		layout.add(objectToPlace, Align.adjacent(margin, DOWN), target);
		layout.add(objectToPlace, Align.centerX(), target);
	}
	
	/**
	 * Aligns the object with the target along the given edge. For
	 * instance, if you specify DOWN, the object's bottom edge will be
	 * aligned with the target's bottom edge.
	 */
	public static inline function alignWith(objectToPlace:DisplayObject, target:DisplayObject, direction:Direction, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.inside(0, direction), target);
	}
	/**
	 * Centers the object horizontally on the target.
	 */
	public static inline function centerXOn(objectToPlace:DisplayObject, target:DisplayObject, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.centerX(), target);
	}
	/**
	 * Centers the object vertically on the target.
	 */
	public static inline function centerYOn(objectToPlace:DisplayObject, target:DisplayObject, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.centerY(), target);
	}
	
	//Place objects onstage:
	
	/**
	 * Sets the object's x coordinate to this value times Scale.scaleX.
	 */
	public static inline function setX(objectToPlace:DisplayObject, x:Float, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.inside(x, LEFT));
	}
	/**
	 * Sets the object's y coordinate to this value times Scale.scaleY.
	 */
	public static inline function setY(objectToPlace:DisplayObject, y:Float, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.inside(y, UP));
	}
	
	/**
	 * Centers the object horizontally onscreen.
	 */
	public static inline function centerX(objectToPlace:DisplayObject, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.centerX());
	}
	/**
	 * Centers the object vertically onscreen.
	 */
	public static inline function centerY(objectToPlace:DisplayObject, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.centerY());
	}
	
	/**
	 * Aligns the object to the left edge of the screen.
	 */
	public static inline function alignLeft(objectToPlace:DisplayObject, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.edge(LEFT));
	}
	/**
	 * Aligns the object to the right edge of the screen.
	 */
	public static inline function alignRight(objectToPlace:DisplayObject, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.edge(RIGHT));
	}
	/**
	 * Aligns the object to the top edge of the screen.
	 */
	public static inline function alignTop(objectToPlace:DisplayObject, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.edge(UP));
	}
	/**
	 * Aligns the object to the bottom edge of the screen.
	 */
	public static inline function alignBottom(objectToPlace:DisplayObject, ?layout:Layout):Void {
		check(layout).add(objectToPlace, Align.edge(DOWN));
	}
	
	//Scale objects relative to one another:
	
	/**
	 * Sets the object's width to match the target's width, minus the
	 * given margin times two. Call centerXOn() after this to ensure that
	 * the same margin appears on both sides of the object.
	 */
	public static inline function matchWidth(objectToScale:DisplayObject, target:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		check(layout).add(objectToScale, Size.widthMinus(margin * 2), target);
	}
	/**
	 * Sets the object's height to match the target's height, minus the
	 * given margin times two. Call centerYOn() after this to ensure that
	 * the same margin appears both above and below the object.
	 */
	public static inline function matchHeight(objectToScale:DisplayObject, target:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		check(layout).add(objectToScale, Size.heightMinus(margin * 2), target);
	}
	
	//Scale objects relative to the stage:
	
	/**
	 * Sets the object's width to this value times Scale.scaleX.
	 */
	public static inline function setWidth(objectToScale:DisplayObject, width:Float, ?layout:Layout):Void {
		check(layout).add(objectToScale, Size.absoluteWidth(width));
	}
	/**
	 * Sets the object's height to this value times Scale.scaleY.
	 */
	public static inline function setHeight(objectToScale:DisplayObject, height:Float, ?layout:Layout):Void {
		check(layout).add(objectToScale, Size.absoluteHeight(height));
	}
	
	/**
	 * Sets the object's width to fill the stage horizintally, minus the
	 * given margin times two. Call centerX() after this to ensure that
	 * the same margin appears on both sides of the object.
	 */
	public static inline function fillWidth(objectToScale:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		check(layout).add(objectToScale, Size.widthMinus(margin * 2));
	}
	/**
	 * Sets the object's height to fill the stage vertically, minus the
	 * given margin times two. Call centerY() after this to ensure that
	 * the same margin appears both above and below the object.
	 */
	public static inline function fillHeight(objectToScale:DisplayObject, ?margin:Float = 0, ?layout:Layout):Void {
		check(layout).add(objectToScale, Size.heightMinus(margin * 2));
	}
	
	/**
	 * Scales the object to take up this much of the stage horizintally.
	 * Caution: despite the name, "percent" should be a value between 0
	 * and 1.
	 */
	public static inline function fillPercentWidth(objectToScale:DisplayObject, percent:Float, ?layout:Layout):Void {
		check(layout).add(objectToScale, Size.relativeWidth(percent));
	}
	/**
	 * Scales the object to take up this much of the stage vertically.
	 * Caution: despite the name, "percent" should be a value between 0
	 * and 1.
	 */
	public static inline function fillPercentHeight(objectToScale:DisplayObject, percent:Float, ?layout:Layout):Void {
		check(layout).add(objectToScale, Size.relativeHeight(percent));
	}
}
