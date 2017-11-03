package com.sirolf2009.lajer.ide.lajer

import com.sirolf2009.lajer.core.Node
import com.sirolf2009.lajer.core.operation.model.Operation
import com.sirolf2009.lajer.ide.figure.InputFigure
import com.sirolf2009.lajer.ide.figure.NodeFigure
import com.sirolf2009.lajer.ide.figure.OutputFigure
import com.sirolf2009.lajer.ide.figure.PortFigure
import com.sirolf2009.lajer.ide.lajer.command.LajerCommand
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandActivateSelected
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandConnectSelected
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandDisconnectSelected
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandLoad
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedDown
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedLeft
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedRight
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedUp
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandNavigate.NavigateDown
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandNavigate.NavigateLeft
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandNavigate.NavigateRight
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandNavigate.NavigateUp
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandSave
import com.sirolf2009.lajer.ide.lajer.command.LajerCommandSelectFocused
import java.io.File
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

	public static val COMMAND_NAVIGATE_UP = new NavigateUp(45)
	public static val COMMAND_NAVIGATE_DOWN = new NavigateDown(45)
	public static val COMMAND_NAVIGATE_LEFT = new NavigateLeft(45)
	public static val COMMAND_NAVIGATE_RIGHT = new NavigateRight(45)
	public static val COMMAND_SELECT_FOCUSED = new LajerCommandSelectFocused()
	public static val COMMAND_CONNECT_SELECTED = new LajerCommandConnectSelected()
	public static val COMMAND_DISCONNECT_SELECTED = new LajerCommandDisconnectSelected()
	public static val COMMAND_MOVE_SELECTED_UP = new LajerCommandMoveSelectedUp(10)
	public static val COMMAND_MOVE_SELECTED_DOWN = new LajerCommandMoveSelectedDown(10)
	public static val COMMAND_MOVE_SELECTED_LEFT = new LajerCommandMoveSelectedLeft(10)
	public static val COMMAND_MOVE_SELECTED_RIGHT = new LajerCommandMoveSelectedRight(10)
	public static val COMMAND_MOVE_SELECTED_UP_PRECISE = new LajerCommandMoveSelectedUp(1)
	public static val COMMAND_MOVE_SELECTED_DOWN_PRECISE = new LajerCommandMoveSelectedDown(1)
	public static val COMMAND_MOVE_SELECTED_LEFT_PRECISE = new LajerCommandMoveSelectedLeft(1)
	public static val COMMAND_MOVE_SELECTED_RIGHT_PRECISE = new LajerCommandMoveSelectedRight(1)
	public static val COMMAND_ACTIVATE_SELECTED = new LajerCommandActivateSelected()
	public static val COMMAND_SAVE = new LajerCommandSave()
	public static val COMMAND_LOAD = new LajerCommandLoad()

	val Canvas canvas
	val XYLayout layout
	val Figure root
	val File saveFile
	val Map<String, LajerCommand> commands
	val List<NodeFigure> nodes
	val Set<PortFigure> selected
	val Set<PortFigure> inputPorts
	val Set<PortFigure> outputPorts
	var PortFigure focused
	var boolean ctrlPressed = false
	var boolean shiftPressed = false

	new(Canvas canvas, XYLayout layout, Figure root, File saveFile) {
		this.canvas = canvas
		this.layout = layout
		this.root = root
		this.saveFile = saveFile
		commands = new HashMap()
		COMMAND_NAVIGATE_UP.register()
		COMMAND_NAVIGATE_DOWN.register()
		COMMAND_NAVIGATE_LEFT.register()
		COMMAND_NAVIGATE_RIGHT.register()
		COMMAND_SELECT_FOCUSED.register()
		COMMAND_CONNECT_SELECTED.register()
		COMMAND_DISCONNECT_SELECTED.register()
		COMMAND_MOVE_SELECTED_UP.register()
		COMMAND_MOVE_SELECTED_DOWN.register()
		COMMAND_MOVE_SELECTED_LEFT.register()
		COMMAND_MOVE_SELECTED_RIGHT.register()
		COMMAND_ACTIVATE_SELECTED.register()
		COMMAND_SAVE.register()
		COMMAND_LOAD.register()
		selected = new HashSet()
		inputPorts = new HashSet()
		outputPorts = new HashSet()
		nodes = new ArrayList()
	}

	def register(LajerCommand command) {
		commands.put(command.name, command)
	}

	def add(Node node) {
		val uml = new NodeFigure(this, node, new Label(node.class.simpleName))
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
		if(ctrlPressed && shiftPressed && e.keyCode == SWT.ARROW_UP) {
			COMMAND_MOVE_SELECTED_UP_PRECISE.accept(this)
		} else if(ctrlPressed && shiftPressed && e.keyCode == SWT.ARROW_DOWN) {
			COMMAND_MOVE_SELECTED_DOWN_PRECISE.accept(this)
		} else if(ctrlPressed && shiftPressed && e.keyCode == SWT.ARROW_LEFT) {
			COMMAND_MOVE_SELECTED_LEFT_PRECISE.accept(this)
		} else if(ctrlPressed && shiftPressed && e.keyCode == SWT.ARROW_RIGHT) {
			COMMAND_MOVE_SELECTED_RIGHT_PRECISE.accept(this)
		} else if(shiftPressed && e.keyCode == SWT.ARROW_UP) {
			COMMAND_MOVE_SELECTED_UP.accept(this)
		} else if(shiftPressed && e.keyCode == SWT.ARROW_DOWN) {
			COMMAND_MOVE_SELECTED_DOWN.accept(this)
		} else if(shiftPressed && e.keyCode == SWT.ARROW_LEFT) {
			COMMAND_MOVE_SELECTED_LEFT.accept(this)
		} else if(shiftPressed && e.keyCode == SWT.ARROW_RIGHT) {
			COMMAND_MOVE_SELECTED_RIGHT.accept(this)
		} else if(e.keyCode == SWT.ARROW_LEFT) {
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
		} else if(e.keyCode == 'd'.charAt(0)) {
			COMMAND_DISCONNECT_SELECTED.accept(this)
		} else if(ctrlPressed && e.keyCode == SWT.F11) {
			COMMAND_ACTIVATE_SELECTED.accept(this)
		} else if(ctrlPressed && e.keyCode == 's'.charAt(0)) {
			COMMAND_SAVE.accept(this)
		} else if(ctrlPressed && e.keyCode == 'o'.charAt(0)) {
			COMMAND_LOAD.accept(this)
		}
	}
	
	def asOperation() {
		return new Operation(nodes.map[node].toList(), inputPorts.map[port].toList(), outputPorts.map[port].toList())
	}
	
	def asState() {
		return new LajerState(layout, root, nodes, selected, inputPorts, outputPorts)
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
