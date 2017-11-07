package com.sirolf2009.lajer.plugin.figure

import org.eclipse.draw2d.AbstractBorder
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.Graphics
import org.eclipse.draw2d.IFigure
import org.eclipse.draw2d.geometry.Insets
import org.eclipse.draw2d.geometry.PointList
import org.eclipse.swt.graphics.Color
import org.eclipse.draw2d.BorderLayout

class BoxFigure extends Figure {

	static val classColor = new Color(null, 206, 206, 225)

	new() {
		layoutManager = new BorderLayout()
		backgroundColor = classColor
		setBorder(new CompartmentFigureBorder())
	}

	public static class CompartmentFigureBorder extends AbstractBorder {

		override getInsets(IFigure figure) {
			return new Insets(6)
		}

		override paint(IFigure figure, Graphics graphics, Insets insets) {
			getPaintRectangle(figure, insets) => [
				graphics.drawPolygon(new PointList() => [list|
					list.addPoint(topLeft.getTranslated(1, 1))
					list.addPoint(topRight.getTranslated(-1, 1))
					list.addPoint(bottomRight.getTranslated(-1, -1))
					list.addPoint(bottomLeft.getTranslated(1, -1))
				])
			]
		}

	}

}
