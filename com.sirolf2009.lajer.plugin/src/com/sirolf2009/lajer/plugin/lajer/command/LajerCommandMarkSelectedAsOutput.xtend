package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.plugin.figure.OutputFigure
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import com.sirolf2009.lajer.plugin.figure.CallbackConnectionFigure
import org.eclipse.draw2d.geometry.Rectangle

class LajerCommandMarkSelectedAsOutput extends LajerCommand {

	override accept(extension LajerManager manager) {
		if(focused !== null && focused.isOutput) {
			if(outputPorts.contains(focused)) {
				outputPorts.remove(focused)
				val toBeRemoved = root.children.filter[it instanceof CallbackConnectionFigure].map[it as CallbackConnectionFigure].filter [
					it.from == focused
				].toSet()
				toBeRemoved.forEach[
					root.remove(it)
					root.remove(to)
				]
			} else {
				val connection = markAsOutput(focused as OutputFigure)
				layout.setConstraint(connection.to, new Rectangle(focused.bounds.center.x + 80, focused.bounds.center.y - 10, -1, -1))
			}
		}
	}
	
}
