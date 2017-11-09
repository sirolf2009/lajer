package com.sirolf2009.lajer.plugin.figure

import org.eclipse.draw2d.Ellipse
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.StackLayout
import org.eclipse.draw2d.geometry.Insets
import org.eclipse.swt.graphics.Color
import org.eclipse.draw2d.geometry.Dimension

class OperationInputFigure extends Figure {
	
	new() {
		layoutManager = new StackLayout()
		add(new Ellipse() => [
			backgroundColor = new Color(null, 0, 0, 0)
			size = new Dimension(20, 20)
		])
	}
	
	override getInsets() {
		return new Insets(6)
	}
	
}