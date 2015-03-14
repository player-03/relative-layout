package com.player03.relativelayout.instruction;

import com.player03.relativelayout.area.IRectangle;
import com.player03.relativelayout.Scale;
import openfl.display.DisplayObject;

/**
 * @author Joseph Cloutier
 */
interface LayoutInstruction {
	var mask:Int;
	function apply(target:DisplayObject, area:IRectangle, scale:Scale):Void;
}

class InstructionMask {
	public static var AFFECTS_X:Int = 0x1;
	public static var AFFECTS_Y:Int = 0x2;
	public static var AFFECTS_WIDTH:Int = 0x4;
	public static var AFFECTS_HEIGHT:Int = 0x8;
	
	public static inline function hasConflict(maskA:Int, maskB:Int):Bool {
		return (maskA & maskB) != 0;
	}
}
