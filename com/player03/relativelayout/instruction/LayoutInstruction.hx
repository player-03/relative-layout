package com.player03.relativelayout.instruction;

import com.player03.relativelayout.area.IRectangle;
import com.player03.relativelayout.Scale;
import openfl.display.DisplayObject;

/**
 * @author Joseph Cloutier
 */
interface LayoutInstruction {
	function apply(target:DisplayObject, area:IRectangle, scale:Scale):Void;
}
