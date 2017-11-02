package com.sirolf2009.lajer.ide.lajer

import com.sirolf2009.lajer.core.Node
import com.sirolf2009.lajer.ide.lajer.command.LajerCommand
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandConnectSelected
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandNavigate.NavigateDown
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandNavigate.NavigateLeft
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandNavigate.NavigateRight
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandNavigate.NavigateUp
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandSelectFocused
import com.sirolf2009.lajer.ide.model.NodeFigure
import com.sirolf2009.lajer.ide.model.PortFigure
import java.util.ArrayList
import java.util.HashMap
import java.util.HashSet
import java.util.List
import java.util.Map
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

	static val COMMAND_NAVIGATE_UP = new NavigateUp(45)
	static val COMMAND_NAVIGATE_DOWN = new NavigateDown(45)
	static val COMMAND_NAVIGATE_LEFT = new NavigateLeft(45)
	static val COMMAND_NAVIGATE_RIGHT = new NavigateRight(45)
	static val COMMAND_SELECT_FOCUSED = new LajerCommandSelectFocused()
	static val COMMAND_CONNECT_SELECTED = new LajerCommandConnectSelected()

	val Canvas canvas
	val XYLayout layout
	val Figure root
	val Map<String, LajerCommand> commands
	val List<NodeFigure> nodes
	val Set<PortFigure> selected
	var PortFigure focused
	var boolean ctrlPressed = false

	new(Canvas canvas, XYLayout layout, Figure root) {
		this.canvas = canvas
		this.layout = layout
		this.root = root
		commands = new HashMap()
		COMMAND_NAVIGATE_UP.register()
		COMMAND_NAVIGATE_DOWN.register()
		COMMAND_NAVIGATE_LEFT.register()
		COMMAND_NAVIGATE_RIGHT.register()
		COMMAND_SELECT_FOCUSED.register()
		COMMAND_CONNECT_SELECTED.register()
		selected = new HashSet()
		nodes = new ArrayList()
	}
	
	def register(LajerCommand command) {
		commands.put(command.name, command)
	}

	def add(Node node) {
		val uml = new NodeFigure(this, node, new Label(node.class.simpleName))
		nodes += uml
		layout.setConstraint(uml, new Rectangle(new Random().nextInt(1000), new Random().nextInt(1000), -1, -1))
		root.add(uml)
	}

	override keyPressed(KeyEvent e) {
		if(e.keyCode == SWT.CTRL) {
			ctrlPressed = true
		}
		if(e.keyCode == SWT.ARROW_LEFT) {
			COMMAND_NAVIGATE_LEFT.accept(this)
		} else if(e.keyCode == SWT.ARROW_RIGHT) {
			COMMAND_NAVIGATE_RIGHT.accept(this)
		} else if(e.keyCode == SWT.ARROW_UP) {
			COMMAND_NAVIGATE_UP.accept(this)
		} else if(e.keyCode == SWT.ARROW_DOWN) {
			COMMAND_NAVIGATE_DOWN.accept(this)
		} else if(e.keyCode == SWT.CR) {
			COMMAND_SELECT_FOCUSED.accept(this)
		} else if(e.keyCode == 'c'.charAt(0)) {
			COMMAND_CONNECT_SELECTED.accept(this)
		}
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
		return port.node.node.inputPorts.contains(port)
	}

	def isOutput(PortFigure port) {
		return port.node.node.outputPorts.contains(port)
	}

	override keyReleased(KeyEvent e) {
		if(e.keyCode == SWT.CTRL) {
			ctrlPressed = false
		}
	}

}
