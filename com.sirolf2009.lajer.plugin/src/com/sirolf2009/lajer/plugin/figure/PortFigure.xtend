package com.sirolf2009.lajer.plugin.figure

import com.sirolf2009.lajer.core.Port
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import org.eclipse.draw2d.AbstractBorder
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.FlowLayout
import org.eclipse.draw2d.Graphics
import org.eclipse.draw2d.IFigure
import org.eclipse.draw2d.MouseEvent
import org.eclipse.draw2d.MouseListener
import org.eclipse.draw2d.MouseMotionListener
import org.eclipse.draw2d.geometry.Insets
import org.eclipse.draw2d.geometry.PointList
import org.eclipse.swt.graphics.Color

class PortFigure extends Figure {

	static val classColor = new Color(null, 206, 206, 225)
	val LajerManager manager
	val INodeFigure node
	val Port port
	var boolean focused = false
	var boolean selected = false

	new(INodeFigure node, Port port, LajerManager manager) {
		this.node = node
		this.port = port
		this.manager = manager
		layoutManager = new FlowLayout()
		backgroundColor = classColor
		addMouseListener(new MouseListener() {
			override mouseDoubleClicked(MouseEvent me) {
			}

			override mousePressed(MouseEvent me) {
				selected = !selected
				repaint()
			}

			override mouseReleased(MouseEvent me) {
			}
		})
		addMouseMotionListener(new MouseMotionListener() {

			override mouseDragged(MouseEvent me) {
			}

			override mouseEntered(MouseEvent me) {
				manager.focus(PortFigure.this)
			}

			override mouseExited(MouseEvent me) {
				manager.unfocus()
			}

			override mouseHover(MouseEvent me) {
			}

			override mouseMoved(MouseEvent me) {
			}

		})
	}
	
	def INodeFigure getNode() {
		return node
	}
	
	def Port getPort() {
		return port
	}
	
	def isFocused() {
		return focused
	}
	
	def setFocused(boolean focused) {
		this.focused = focused
	}
	
	def isSelected() {
		return selected
	}
	
	def setSelected(boolean selected) {
		this.selected = selected
	}

	public static abstract class PortFigureBorder extends AbstractBorder {

		val PortFigure port
		
		new(PortFigure port) {
			this.port = port
		}
		
		override getInsets(IFigure figure) {
			return new Insets(6)
		}

		override paint(IFigure figure, Graphics graphics, Insets insets) {
			val shape = getShape(figure, graphics, insets)
			if(port.focused && port.selected) {
				graphics.backgroundColor = new Color(null, 82, 132, 229)
				graphics.fillPolygon(shape)
			} else if(port.selected) {
				graphics.backgroundColor = new Color(null, 52, 32, 199)
				graphics.fillPolygon(shape)
			} else if(port.focused) {
				graphics.backgroundColor = new Color(null, 229, 132, 82)
				graphics.fillPolygon(shape)
			}
			graphics.drawPolygon(shape)
		}

		def abstract PointList getShape(IFigure figure, Graphics graphics, Insets insets)

	}

}
