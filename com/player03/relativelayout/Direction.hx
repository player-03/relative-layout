package com.player03.relativelayout;

/**
 * The cardinal directions.
 * @author Joseph Cloutier
 */
enum Direction {
	LEFT;
	RIGHT;
	UP;
	DOWN;
}

class DirectionUtils {
	public static inline function isHorizontal(direction:Direction):Bool {
		return direction == LEFT || direction == RIGHT;
	}
	
	public static inline function isTopLeft(direction:Direction):Bool {
		return direction == LEFT || direction == UP;
	}
}
