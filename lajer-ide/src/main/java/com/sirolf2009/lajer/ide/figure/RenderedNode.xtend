package com.sirolf2009.lajer.ide.figure

import com.sirolf2009.lajer.core.Node
import java.util.Optional
import org.eclipse.swt.SWT
import org.eclipse.swt.graphics.Image
import org.eclipse.swt.layout.FillLayout
import org.eclipse.swt.layout.RowData
import org.eclipse.swt.layout.RowLayout
import org.eclipse.swt.widgets.Canvas
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.graphics.Point
import org.eclipse.swt.widgets.Listener
import org.eclipse.swt.widgets.Event
import org.eclipse.swt.events.MouseListener
import org.eclipse.swt.events.MouseEvent

class RenderedNode extends Composite implements Listener {

	val Node node
	val Optional<Image> icon

	new(Composite parent, Node node, Optional<Image> icon) {
		super(parent, SWT.NONE)
		this.node = node
		this.icon = icon
		layout = new RowLayout(SWT.HORIZONTAL) => [
			spacing = 0
		]
		new Composite(this, SWT.NONE) => [
			layout = new FillLayout(SWT.VERTICAL) => [
				spacing = 0
			]
			node.inputPorts.forEach [ port |
				new Square(it, 6, 6)
			]
			layoutData = new RowData(6, 50)
		]
		new Square(this, 50, 50) => [
			layoutData = new RowData(50, 50)
		]
		new Composite(this, SWT.NONE) => [
			layout = new FillLayout(SWT.VERTICAL) => [
				spacing = 0
			]
			node.outputPorts.forEach [ port |
				new Square(it, 6, 6)
			]
			layoutData = new RowData(6, 50)
		]
		setSize(6+50+6, 50)
		addListener(SWT.MouseDown, this)
		addMouseListener(new MouseListener() {
			
			override mouseDoubleClick(MouseEvent e) {
				throw new UnsupportedOperationException("TODO: auto-generated method stub")
			}
			
			override mouseDown(MouseEvent e) {
				throw new UnsupportedOperationException("TODO: auto-generated method stub")
			}
			
			override mouseUp(MouseEvent e) {
				throw new UnsupportedOperationException("TODO: auto-generated method stub")
			}
			
		})
	}
	
	override handleEvent(Event event) {
		println(event)
	}

	override computeSize(int wHint, int hHint, boolean changed) {
		return new Point(6+50+6+8, 50+8)
	}

	private static class Square extends Canvas {

		val int width
		val int height

		new(Composite composite, int width, int height) {
			super(composite, SWT.NONE)
			this.width = width
			this.height = height
			addPaintListener [
				gc.drawRectangle(0, 0, width - 1, height - 1)
			]
		}
		
		override computeSize(int wHint, int hHint, boolean changed) {
			return new Point(width, height)
		}
		
	}

}
