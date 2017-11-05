package com.sirolf2009.lajer.ide.figure

import com.sirolf2009.lajer.core.Port
import org.eclipse.draw2d.Graphics
import org.eclipse.draw2d.IFigure
import org.eclipse.draw2d.geometry.Insets
import org.eclipse.draw2d.geometry.PointList
import org.eclipse.xtend.lib.annotations.Data
import com.sirolf2009.lajer.ide.lajer.LajerManager

class OutputFigure extends PortFigure {

	new(INodeFigure node, Port port, LajerManager manager) {
		super(node, port, manager)
		setBorder(new OutputFigureBorder(this))
	}

	@Data public static class OutputFigureBorder extends PortFigureBorder {

		override getShape(IFigure figure, Graphics graphics, Insets insets) {
			new PointList() => [ list |
				getPaintRectangle(figure, insets) => [
					list.addPoint(topLeft.getTranslated(1, 3))
					list.addPoint(topRight.getTranslated(-1, 1))
					list.addPoint(bottomRight.getTranslated(-1, -1))
					list.addPoint(bottomLeft.getTranslated(1, -3))
				]
			]
		}

	}

}
