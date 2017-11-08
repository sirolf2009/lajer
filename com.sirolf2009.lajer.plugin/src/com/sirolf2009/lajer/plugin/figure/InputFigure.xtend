package com.sirolf2009.lajer.plugin.figure

import com.sirolf2009.lajer.core.model.PortModel
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import org.eclipse.draw2d.Graphics
import org.eclipse.draw2d.IFigure
import org.eclipse.draw2d.geometry.Insets
import org.eclipse.draw2d.geometry.PointList

class InputFigure extends PortFigure {

	new(INodeFigure node, PortModel port, LajerManager manager) {
		super(node, port, manager)
		setBorder(new InputFigureBorder(this))
	}

	public static class InputFigureBorder extends PortFigureBorder {
		
		new(PortFigure port) {
			super(port)
		}
		
		override getShape(IFigure figure, Graphics graphics, Insets insets) {
			new PointList() => [ list |
				getPaintRectangle(figure, insets) => [
					list.addPoint(topLeft.getTranslated(1, 1))
					list.addPoint(topRight.getTranslated(-1, 3))
					list.addPoint(bottomRight.getTranslated(-1, -3))
					list.addPoint(bottomLeft.getTranslated(1, -1))
				]
			]
		}

	}

}
