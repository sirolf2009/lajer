package com.sirolf2009.lajer.ide.model

import com.sirolf2009.lajer.core.Node
import java.util.Optional
import org.eclipse.swt.SWT
import org.eclipse.swt.dnd.DND
import org.eclipse.swt.dnd.DragSource
import org.eclipse.swt.graphics.Image
import org.eclipse.swt.layout.FillLayout
import org.eclipse.swt.layout.RowData
import org.eclipse.swt.layout.RowLayout
import org.eclipse.swt.widgets.Canvas
import org.eclipse.swt.widgets.Composite

class RenderedNode extends Composite {

	val Node node
	val Optional<Image> icon

	new(Composite parent, Node node, Optional<Image> icon) {
		super(parent, SWT.BORDER)
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
		
		new DragSource(this, DND.DROP_MOVE)
		addDragDetectListener[
			println("dragging")
		]
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

	}

}
