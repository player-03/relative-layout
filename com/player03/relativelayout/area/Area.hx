package com.player03.relativelayout.area;

import flash.events.Event;
import flash.events.EventDispatcher;

/**
 * A rectangular region, to place objects within. Note: area boundaries
 * will not always be strictly enforced.
 * 
 * When the area changes for any reaosn, it will dispatch a CHANGE event.
 * @author Joseph Cloutier
 */
class Area extends EventDispatcher {
	#if flash
		public var x(default, set):Float;
		public var y(default, set):Float;
		public var width(default, set):Float;
		public var height(default, set):Float;
	#else
		@:isVar public var x(get, set):Float;
		@:isVar public var y(get, set):Float;
		@:isVar public var width(get, set):Float;
		@:isVar public var height(get, set):Float;
	#end
	
	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		super();
		
		setTo(x, y, width, height);
	}
	
	/**
	 * Sets this rectangle to the given values, only dispatching a single
	 * CHANGE event in the process.
	 */
	public function setTo(x:Float, y:Float, width:Float, height:Float):Void {
		Reflect.setField(this, "x", x);
		Reflect.setField(this, "y", y);
		Reflect.setField(this, "width", width);
		Reflect.setField(this, "height", height);
		
		dispatchEvent(new Event(Event.CHANGE));
	}
	
	#if !flash
		private inline function get_x():Float {
			return x;
		}
		private inline function get_y():Float {
			return y;
		}
		private inline function get_width():Float {
			return width;
		}
		private inline function get_height():Float {
			return height;
		}
	#end
	
	private function set_x(value:Float):Float {
		x = value;
		dispatchEvent(new Event(Event.CHANGE));
		return x;
	}
	private function set_y(value:Float):Float {
		y = value;
		dispatchEvent(new Event(Event.CHANGE));
		return y;
	}
	private function set_width(value:Float):Float {
		width = value;
		dispatchEvent(new Event(Event.CHANGE));
		return width;
	}
	private function set_height(value:Float):Float {
		height = value;
		dispatchEvent(new Event(Event.CHANGE));
		return height;
	}
}
