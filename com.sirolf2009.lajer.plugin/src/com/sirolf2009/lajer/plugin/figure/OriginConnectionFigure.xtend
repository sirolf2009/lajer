package com.sirolf2009.lajer.plugin.figure

import org.eclipse.draw2d.ChopboxAnchor
import org.eclipse.draw2d.PolygonDecoration
import org.eclipse.draw2d.PolylineConnection
import org.eclipse.draw2d.geometry.PointList

class OriginConnectionFigure extends PolylineConnection {

	val OperationInputFigure from
	val PortFigure to
	
	new(OperationInputFigure from, PortFigure to) {
		this.from = from
		this.to = to

		sourceAnchor = new ChopboxAnchor(from)
		targetAnchor = new ChopboxAnchor(to)

		targetDecoration = new PolygonDecoration() => [
			template = new PointList() => [
				addPoint(-2, -2)
				addPoint(-2, 2)
				addPoint(0, 0)
			]
		]
	}
	
	def getFrom() {
		return from
	}
	
	def getTo() {
		return to
	}

}
