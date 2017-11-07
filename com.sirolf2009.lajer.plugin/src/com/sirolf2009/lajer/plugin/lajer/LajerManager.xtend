package com.sirolf2009.lajer.plugin.lajer

import com.sirolf2009.lajer.core.Node
import com.sirolf2009.lajer.core.operation.model.Operation
import com.sirolf2009.lajer.core.splitter.Splitter
import com.sirolf2009.lajer.plugin.LajerEditor
import com.sirolf2009.lajer.plugin.figure.INodeFigure
import com.sirolf2009.lajer.plugin.figure.InputFigure
import com.sirolf2009.lajer.plugin.figure.NodeFigure
import com.sirolf2009.lajer.plugin.figure.OutputFigure
import com.sirolf2009.lajer.plugin.figure.PortFigure
import com.sirolf2009.lajer.plugin.figure.SplitterFigure
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Random
import java.util.Set
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.Label
import org.eclipse.draw2d.XYLayout
import org.eclipse.draw2d.geometry.Rectangle
import org.eclipse.swt.SWT
import org.eclipse.swt.events.KeyEvent
import org.eclipse.swt.events.KeyListener
import org.eclipse.swt.widgets.Canvas
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors class LajerManager implements KeyListener {

	val Canvas canvas
	val XYLayout layout
	val Figure root
	val LajerEditor editor
	val List<INodeFigure> nodes
	val Set<PortFigure> selected
	val Set<PortFigure> inputPorts
	val Set<PortFigure> outputPorts
	var PortFigure focused
	var boolean ctrlPressed = false
	var boolean shiftPressed = false

	new(Canvas canvas, XYLayout layout, Figure root, LajerEditor editor) {
		this.canvas = canvas
		this.layout = layout
		this.root = root
		this.editor = editor
		selected = new HashSet()
		inputPorts = new HashSet()
		outputPorts = new HashSet()
		nodes = new ArrayList()
	}

	def add(Node node) {
		val uml = new NodeFigure(this, node, new Label(node.name()))
		nodes += uml
		layout.setConstraint(uml, new Rectangle(new Random().nextInt(1000), new Random().nextInt(800), -1, -1))
		root.add(uml)
		return uml
	}

	def add(Splitter splitter) {
		val uml = new SplitterFigure(this, splitter, new Label(splitter.name()))
		nodes += uml
		layout.setConstraint(uml, new Rectangle(new Random().nextInt(1000), new Random().nextInt(800), -1, -1))
		root.add(uml)
		return uml
	}

	override keyPressed(KeyEvent e) {
		if(e.keyCode == SWT.CTRL) {
			ctrlPressed = true
		} else if(e.keyCode == SWT.SHIFT) {
			shiftPressed = true
		}
	}
	
	def asOperation() {
		return new Operation(editor.editorInput.name, nodes.map[node].toList(), inputPorts.map[port].toList(), outputPorts.map[port].toList())
	}

	def focusOnFirst() {
		unfocus()
		var i = 0
		while(focused === null && i < nodes.size()) {
			nodes.get(i) => [
				if(!inputFigures.isEmpty()) {
					inputFigures.get(0).focus()
				} else if(!outputFigures.isEmpty()) {
					outputFigures.get(0).focus()
				}
			]
		}
	}

	def unfocus() {
		if(focused !== null) {
			focused.focused = false
			focused.repaint()
			focused = null
		}
	}

	def focus(PortFigure port) {
		unfocus()
		focused = port
		focused.focused = true
		focused.repaint()
	}

	def isInput(PortFigure port) {
		return port instanceof InputFigure
	}

	def isOutput(PortFigure port) {
		return port instanceof OutputFigure
	}

	override keyReleased(KeyEvent e) {
		if(e.keyCode == SWT.CTRL) {
			ctrlPressed = false
		} else if(e.keyCode == SWT.SHIFT) {
			shiftPressed = false
		}
	}

}
