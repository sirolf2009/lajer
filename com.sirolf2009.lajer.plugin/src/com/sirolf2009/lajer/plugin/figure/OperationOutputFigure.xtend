package com.sirolf2009.lajer.plugin.figure

import org.eclipse.draw2d.Ellipse
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.StackLayout
import org.eclipse.draw2d.geometry.Dimension
import org.eclipse.draw2d.geometry.Rectangle
import org.eclipse.swt.graphics.Color

class OperationOutputFigure extends Figure {
	
	new() {
		layoutManager = new StackLayout()
		add(new Ellipse() => [
			size = new Dimension(20, 20)
			backgroundColor = new Color(null, 0, 0, 0)
		])
		add(new Circle(12) => [
			backgroundColor = new Color(null, 255, 255, 255)
		])
		add(new Circle(8) => [
			backgroundColor = new Color(null, 0, 0, 0)
		])
	}
	
	private static class Circle extends Ellipse {
		
		val int size
		
		new(int size) {
			this.size = size
		}
		
		override setBounds(Rectangle rect) {
			super.setBounds(new Rectangle(rect.center.x-size/2, rect.center.y-size/2, size, size))
		}
		
	}
	
}