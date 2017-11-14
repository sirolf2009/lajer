package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.plugin.figure.InputFigure
import com.sirolf2009.lajer.plugin.figure.OriginConnectionFigure
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import org.eclipse.draw2d.geometry.Rectangle

class LajerCommandMarkSelectedAsInput extends LajerCommand {

	override accept(extension LajerManager manager) {
		if(focused !== null && focused.isInput) {
			if(inputPorts.contains(focused)) {
				inputPorts.remove(focused)
				val toBeRemoved = root.children.filter[it instanceof OriginConnectionFigure].map[it as OriginConnectionFigure].filter [
					it.to == focused
				].toSet()
				toBeRemoved.forEach[
					root.remove(it)
					root.remove(from)
				]
			} else {
				val connection = markAsInput(focused as InputFigure)
				layout.setConstraint(connection.from, new Rectangle(focused.bounds.center.x - 80, focused.bounds.center.y - 10, -1, -1))
			}
		}
	}

}
