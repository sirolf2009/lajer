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
			val rect = layout.getConstraint(focused.node) as Rectangle
			val newPos = rect.translate(translation)
			layout.setConstraint(focused.node as Figure, newPos)
			layout.layout((focused.node as Figure).parent)
			markAsDirty()
		}
	}

	public static class LajerCommandMoveSelectedUp extends LajerCommandMoveSelected {

		new(int amount) {
			super(new Point(0, -amount))
		}

	}

	public static class LajerCommandMoveSelectedRight extends LajerCommandMoveSelected {

		new(int amount) {
			super(new Point(amount, 0))
		}

	}

	public static class LajerCommandMoveSelectedDown extends LajerCommandMoveSelected {

		new(int amount) {
			super(new Point(0, amount))
		}

	}

	public static class LajerCommandMoveSelectedLeft extends LajerCommandMoveSelected {

		new(int amount) {
			super(new Point(-amount, 0))
		}

	}

}