package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.plugin.figure.CallbackConnectionFigure
import com.sirolf2009.lajer.plugin.figure.OperationOutputFigure
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import org.eclipse.draw2d.geometry.Rectangle

class LajerCommandMarkSelectedAsOutput extends LajerCommand {

	override accept(extension LajerManager manager) {
		if(focused !== null && focused.isOutput) {
			val operationOutputFigure = new OperationOutputFigure()
			val rectOrigin = getConstraint(focused.node)
			root.add(operationOutputFigure, new Rectangle(rectOrigin.center.x + 80, rectOrigin.center.y, -1, -1))
			val connection = new CallbackConnectionFigure(focused, operationOutputFigure)
			root.add(connection)
			manager.outputPorts.add(focused)
			focused.node.addFigureListener [
				val rect = getConstraint(focused.node)
				layout.setConstraint(operationOutputFigure, new Rectangle(rect.center.x + 80, rect.center.y, -1, -1))
			]
		}
	}
	
}
