package com.player03.relativelayout;

#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
#else
import openfl.display.DisplayObject;
#end

/**
 * A bunch of convenience functions. Name chosen to sound cool.
 * @author Joseph Cloutier
 */
class Relativity {
	#if !macro
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
	#end
	
	#if macro
	private static function check(layout:Expr):Expr {
		if(isNull(layout)) {
			return macro Relativity.defaultLayout;
		} else {
			return layout;
		}
	}
	private static function isFloat(value:Expr):Bool {
		return !isNull(value) && Context.unify(Context.typeof(value), Context.typeof(macro 0.1));
	}
	private static function isNull(value:Expr):Bool {
		switch(value.expr) {
			case EConst(CIdent("null")):
				return true;
			default:
				return false;
		}
	}
	#end
	
	//Place objects relative to one another:
	
	/**
	 * Places the object left of the target, separated by the given margin.
	 */
	public static macro function leftOf(objectToPlace:ExprOf<openfl.display.DisplayObject>, target:Expr, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.adjacent($margin, LEFT), $target);
	}
	/**
	 * Places the object right of the target, separated by the given margin.
	 */
	public static macro function rightOf(objectToPlace:ExprOf<openfl.display.DisplayObject>, target:Expr, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.adjacent($margin, RIGHT), $target);
	}
	/**
	 * Places the object above the target, separated by the given margin.
	 */
	public static macro function above(objectToPlace:ExprOf<openfl.display.DisplayObject>, target:Expr, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.adjacent($margin, UP), $target);
	}
	/**
	 * Places the object below the target, separated by the given margin.
	 */
	public static macro function below(objectToPlace:ExprOf<openfl.display.DisplayObject>, target:Expr, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.adjacent($margin, DOWN), $target);
	}
	
	/**
	 * Places the object left of the target, centered vertically, and
	 * separated by the given margin.
	 */
	public static macro function leftOfCenter(objectToPlace:ExprOf<openfl.display.DisplayObject>, target:Expr, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro {
			$layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.adjacent($margin, LEFT), $target);
			$layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.centerY(), $target);
		};
	}
	/**
	 * Places the object right of the target, centered vertically, and
	 * separated by the given margin.
	 */
	public static macro function rightOfCenter(objectToPlace:ExprOf<openfl.display.DisplayObject>, target:Expr, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro {
			$layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.adjacent($margin, RIGHT), $target);
			$layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.centerY(), $target);
		};
	}
	/**
	 * Places the object above the target, centered horizontally, and
	 * separated by the given margin.
	 */
	public static macro function aboveCenter(objectToPlace:ExprOf<openfl.display.DisplayObject>, target:Expr, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro {
			$layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.adjacent($margin, UP), $target);
			$layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.centerX(), $target);
		};
	}
	/**
	 * Places the object below the target, centered horizontally, and
	 * separated by the given margin.
	 */
	public static macro function belowCenter(objectToPlace:ExprOf<openfl.display.DisplayObject>, target:Expr, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro {
			$layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.adjacent($margin, DOWN), $target);
			$layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.centerX(), $target);
		};
	}
	
	/**
	 * Aligns the object with the target along the given edge. For
	 * instance, if you specify DOWN, the object's bottom edge will be
	 * aligned with the target's bottom edge.
	 */
	public static macro function alignWith(objectToPlace:ExprOf<openfl.display.DisplayObject>, target:Expr, direction:Expr, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.inside(0, $direction), $target);
	}
	/**
	 * Centers the object horizontally on the target.
	 */
	public static macro function centerXOn(objectToPlace:ExprOf<openfl.display.DisplayObject>, target:Expr, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.centerX(), $target);
	}
	/**
	 * Centers the object vertically on the target.
	 */
	public static macro function centerYOn(objectToPlace:ExprOf<openfl.display.DisplayObject>, target:Expr, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.centerY(), $target);
	}
	
	//Place objects onstage:
	
	/**
	 * Sets the object's x coordinate to this value times Scale.scaleX.
	 */
	public static macro function setX(objectToPlace:ExprOf<openfl.display.DisplayObject>, x:Expr, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.inside($x, LEFT));
	}
	/**
	 * Sets the object's y coordinate to this value times Scale.scaleY.
	 */
	public static macro function setY(objectToPlace:ExprOf<openfl.display.DisplayObject>, y:Expr, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.inside($y, UP));
	}
	
	/**
	 * Centers the object horizontally onscreen.
	 */
	public static macro function centerX(objectToPlace:ExprOf<openfl.display.DisplayObject>, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.centerX());
	}
	/**
	 * Centers the object vertically onscreen.
	 */
	public static macro function centerY(objectToPlace:ExprOf<openfl.display.DisplayObject>, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.centerY());
	}
	
	/**
	 * Aligns the object to the left edge of the screen.
	 */
	public static macro function alignLeft(objectToPlace:ExprOf<openfl.display.DisplayObject>, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.edge(LEFT));
	}
	/**
	 * Aligns the object to the right edge of the screen.
	 */
	public static macro function alignRight(objectToPlace:ExprOf<openfl.display.DisplayObject>, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.edge(RIGHT));
	}
	/**
	 * Aligns the object to the top edge of the screen.
	 */
	public static macro function alignTop(objectToPlace:ExprOf<openfl.display.DisplayObject>, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.edge(UP));
	}
	/**
	 * Aligns the object to the bottom edge of the screen.
	 */
	public static macro function alignBottom(objectToPlace:ExprOf<openfl.display.DisplayObject>, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToPlace, com.player03.relativelayout.instruction.Align.edge(DOWN));
	}
	
	//Scale objects relative to one another:
	
	/**
	 * Sets the object's width to match the target's width, minus the
	 * given margin times two. Call centerXOn() after this to ensure that
	 * the same margin appears on both sides of the object.
	 */
	public static macro function matchWidth(objectToScale:ExprOf<openfl.display.DisplayObject>, target:Expr, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro $layout.add($objectToScale, com.player03.relativelayout.instruction.Size.widthMinus($margin * 2), $target);
	}
	/**
	 * Sets the object's height to match the target's height, minus the
	 * given margin times two. Call centerYOn() after this to ensure that
	 * the same margin appears both above and below the object.
	 */
	public static macro function matchHeight(objectToScale:ExprOf<openfl.display.DisplayObject>, target:Expr, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro $layout.add($objectToScale, com.player03.relativelayout.instruction.Size.heightMinus($margin * 2), $target);
	}
	
	//Scale objects relative to the stage:
	
	/**
	 * Sets the object's width to this value times Scale.scaleX.
	 */
	public static macro function setWidth(objectToScale:ExprOf<openfl.display.DisplayObject>, width:Expr, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToScale, com.player03.relativelayout.instruction.Size.absoluteWidth($width));
	}
	/**
	 * Sets the object's height to this value times Scale.scaleY.
	 */
	public static macro function setHeight(objectToScale:ExprOf<openfl.display.DisplayObject>, height:Expr, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToScale, com.player03.relativelayout.instruction.Size.absoluteHeight($height));
	}
	
	/**
	 * Sets the object's width to fill the stage horizintally, minus the
	 * given margin times two. Call centerX() after this to ensure that
	 * the same margin appears on both sides of the object.
	 */
	public static macro function fillWidth(objectToScale:ExprOf<openfl.display.DisplayObject>, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro $layout.add($objectToScale, com.player03.relativelayout.instruction.Size.widthMinus($margin * 2));
	}
	/**
	 * Sets the object's height to fill the stage vertically, minus the
	 * given margin times two. Call centerY() after this to ensure that
	 * the same margin appears both above and below the object.
	 */
	public static macro function fillHeight(objectToScale:ExprOf<openfl.display.DisplayObject>, ?margin:Expr, ?layout:Expr):Expr {
		if(!isFloat(margin)) {
			if(!isNull(margin)) layout = margin;
			margin = macro 0;
		}
		layout = check(layout);
		return macro $layout.add($objectToScale, com.player03.relativelayout.instruction.Size.heightMinus($margin * 2));
	}
	
	/**
	 * Scales the object to take up this much of the stage horizintally.
	 * Caution: despite the name, "percent" should be a value between 0
	 * and 1.
	 */
	public static macro function fillPercentWidth(objectToScale:ExprOf<openfl.display.DisplayObject>, percent:Expr, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToScale, com.player03.relativelayout.instruction.Size.relativeWidth($percent));
	}
	/**
	 * Scales the object to take up this much of the stage vertically.
	 * Caution: despite the name, "percent" should be a value between 0
	 * and 1.
	 */
	public static macro function fillPercentHeight(objectToScale:ExprOf<openfl.display.DisplayObject>, percent:Expr, ?layout:Expr):Expr {
		layout = check(layout);
		return macro $layout.add($objectToScale, com.player03.relativelayout.instruction.Size.relativeHeight($percent));
	}
}
