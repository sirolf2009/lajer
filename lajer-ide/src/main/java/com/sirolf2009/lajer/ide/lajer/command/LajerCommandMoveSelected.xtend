package com.sirolf2009.lajer.ide.lajer.command

import com.sirolf2009.lajer.ide.lajer.LajerManager
import org.eclipse.draw2d.geometry.Point
import org.eclipse.xtend.lib.annotations.Data
import org.eclipse.draw2d.geometry.Rectangle

@Data abstract class LajerCommandMoveSelected extends LajerCommand {

	val Point translation

	override accept(extension LajerManager manager) {
		if(focused !== null && focused.parent !== null) {
			val rect = layout.getConstraint(focused.parent) as Rectangle
			layout.setConstraint(focused.parent, rect.translate(translation))
			layout.layout(focused.parent.parent)
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
