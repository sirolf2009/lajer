package com.sirolf2009.lajer.ide.model

import com.sirolf2009.lajer.core.Port
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
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.Data
import com.sirolf2009.lajer.ide.lajer.LajerManager

class PortFigure extends Figure {

	static val classColor = new Color(null, 206, 206, 225)
	val LajerManager manager
	@Accessors val NodeFigure node
	@Accessors val Port port
	@Accessors var boolean focused = false
	@Accessors var boolean selected = false

	new(NodeFigure node, Port port, LajerManager manager) {
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

	@Data public static abstract class PortFigureBorder extends AbstractBorder {

		val PortFigure port

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
				graphics.backgroundColor = new Color(null, 20, 20, 20)
				graphics.fillPolygon(shape)
			}
			graphics.drawPolygon(shape)
		}

		def abstract PointList getShape(IFigure figure, Graphics graphics, Insets insets)

	}

}
