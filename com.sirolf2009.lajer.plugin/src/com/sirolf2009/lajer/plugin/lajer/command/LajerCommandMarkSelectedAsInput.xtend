package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.plugin.figure.OperationInputFigure
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import org.eclipse.draw2d.geometry.Rectangle
import com.sirolf2009.lajer.plugin.figure.OriginConnectionFigure

class LajerCommandMarkSelectedAsInput extends LajerCommand {

	override accept(extension LajerManager manager) {
		if(focused !== null && focused.isInput) {
			val operationInputFigure = new OperationInputFigure()
			val rectOrigin = getConstraint(focused.node)
			root.add(operationInputFigure, new Rectangle(rectOrigin.center.x - 80, rectOrigin.center.y, -1, -1))
			val connection = new OriginConnectionFigure(operationInputFigure, focused)
			root.add(connection)
			manager.inputPorts.add(focused)
			focused.node.addFigureListener [
				val rect = getConstraint(focused.node)
				layout.setConstraint(operationInputFigure, new Rectangle(rect.center.x - 80, rect.center.y, -1, -1))
			]
		}
	}
	
}
