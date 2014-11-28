package com.player03.relativelayout.position;

/**
 * Each Align value represents alignment along only one axis. You will
 * have to use two Align values if you want to specify both horizontal
 * AND vertical alignment.
 */
enum Align {
	/**
	 * Align to either the top or the left, depending on context.
	 */
	TOP_LEFT;
	/**
	 * Align to either the bottom or the right, depending on context.
	 */
	BOTTOM_RIGHT;
	/**
	 * Align in the center.
	 */
	CENTER;
	/**
	 * Align somewhere between TOP_LEFT and BOTTOM_RIGHT. A percent of 0
	 * is equivalent to TOP_LEFT, and a percent of 1 is equivalent to
	 * BOTTOM_RIGHT.
	 */
	CUSTOM(percent:Float);
}

class AlignUtils {
	public static inline function toPercent(align:Align):Float {
		return switch(align) {
			case TOP_LEFT:
				0;
			case CENTER:
				0.5;
			case BOTTOM_RIGHT:
				1;
			case CUSTOM(percent):
				percent;
		};
	}
}
