package com.sirolf2009.lajer.ide.figure

import org.eclipse.draw2d.ChopboxAnchor
import org.eclipse.draw2d.PolygonDecoration
import org.eclipse.draw2d.PolylineConnection
import org.eclipse.draw2d.geometry.PointList
import org.eclipse.xtend.lib.annotations.Data

@Data class ConnectionFigure extends PolylineConnection {

	val PortFigure input
	val PortFigure output

	new(PortFigure input, PortFigure output) {
		this.input = input
		this.output = output

		sourceAnchor = new ChopboxAnchor(output)
		targetAnchor = new ChopboxAnchor(input)

		targetDecoration = new PolygonDecoration() => [
			template = new PointList() => [
				addPoint(-2, -2)
				addPoint(-2, 2)
				addPoint(0, 0)
			]
		]
	}

}
