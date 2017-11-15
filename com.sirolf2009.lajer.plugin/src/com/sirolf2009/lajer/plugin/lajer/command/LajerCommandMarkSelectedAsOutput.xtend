package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.plugin.figure.OutputFigure
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import org.eclipse.draw2d.geometry.Rectangle

class LajerCommandMarkSelectedAsOutput extends LajerCommand {

	override accept(extension LajerManager manager) {
		if(focused !== null && focused.isOutput) {
			if(outputPorts.contains(focused)) {
				unmarkAsOutput(focused as OutputFigure)
			} else {
				val connection = markAsOutput(focused as OutputFigure)
				layout.setConstraint(connection.to, new Rectangle(focused.bounds.center.x + 80, focused.bounds.center.y - 10, -1, -1))
			}
		}
	}
	
}
