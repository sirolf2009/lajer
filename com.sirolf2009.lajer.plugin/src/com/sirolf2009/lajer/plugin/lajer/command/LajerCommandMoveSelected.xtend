package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.plugin.lajer.LajerManager
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.geometry.Point
import org.eclipse.draw2d.geometry.Rectangle

abstract class LajerCommandMoveSelected extends LajerCommand {

	val Point translation
	
	new(Point translation) {
		this.translation = translation
	}

	override accept(extension LajerManager manager) {
		if(focused !== null) {
			val rect = layout.getConstraint(focused.node as Figure) as Rectangle
			layout.setConstraint(focused.node as Figure, rect.translate(translation))
			layout.layout((focused.node as Figure).parent)
		}
	}

	override author() {
		"sirolf2009"
	}

	public static class LajerCommandMoveSelectedUp extends LajerCommandMoveSelected {

		new(int amount) {
			super(new Point(0, -amount))
		}

		override name() {
			"move-selected-up"
		}

	}

	public static class LajerCommandMoveSelectedRight extends LajerCommandMoveSelected {

		new(int amount) {
			super(new Point(amount, 0))
		}

		override name() {
			"move-selected-right"
		}

	}

	public static class LajerCommandMoveSelectedDown extends LajerCommandMoveSelected {

		new(int amount) {
			super(new Point(0, amount))
		}

		override name() {
			"move-selected-down"
		}

	}

	public static class LajerCommandMoveSelectedLeft extends LajerCommandMoveSelected {

		new(int amount) {
			super(new Point(-amount, 0))
		}

		override name() {
			"move-selected-left"
		}

	}

}