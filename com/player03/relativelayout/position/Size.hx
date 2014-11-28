package com.player03.relativelayout.position;

/**
 * Each Size value represents alignment along only one axis. You will
 * have to use two Size values if you want to fully specify an object's
 * size.
 */
enum Size {
	/**
	 * Scale the target relative to the base's width or height. For instance,
	 * RELATIVE(1) will make the target exactly as large as the base. Use
	 * RELATIVE(0.95) with Align.CENTER if you want to leave a small margin
	 * on both sides.
	 */
	RELATIVE(multiplier:Float);
	
	/**
	 * Maintain the original aspect ratio. Only set one dimension to ASPECT,
	 * or the target won't be scaled at all.
	 */
	ASPECT;
}
