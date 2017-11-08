package com.sirolf2009.lajer.plugin.lajer

import com.sirolf2009.lajer.core.model.NodeModel
import com.sirolf2009.lajer.core.model.OperationModel
import com.sirolf2009.lajer.core.model.SplitterModel
import com.sirolf2009.lajer.plugin.LajerEditor
import com.sirolf2009.lajer.plugin.figure.INodeFigure
import com.sirolf2009.lajer.plugin.figure.InputFigure
import com.sirolf2009.lajer.plugin.figure.NodeFigure
import com.sirolf2009.lajer.plugin.figure.OutputFigure
import com.sirolf2009.lajer.plugin.figure.PortFigure
import com.sirolf2009.lajer.plugin.figure.SplitterFigure
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandActivateSelected
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandConnectSelected
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandDisconnectSelected
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedDown
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedLeft
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedRight
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedUp
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandNavigate.NavigateDown
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandNavigate.NavigateLeft
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandNavigate.NavigateRight
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandNavigate.NavigateUp
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandSelectFocused
import java.util.ArrayList
import java.util.HashMap
import java.util.HashSet
import java.util.List
import java.util.Map
import java.util.Set
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.Label
import org.eclipse.draw2d.XYLayout
import org.eclipse.draw2d.geometry.Rectangle
import org.eclipse.jdt.core.JavaCore
import org.eclipse.swt.SWT
import org.eclipse.swt.events.KeyEvent
import org.eclipse.swt.events.KeyListener
import org.eclipse.swt.widgets.Canvas

class LajerManager implements KeyListener {

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

	val Canvas canvas
	val XYLayout layout
	val Figure root
	val Map<String, LajerCommand> commands
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
		selected = new HashSet()
		inputPorts = new HashSet()
		outputPorts = new HashSet()
		nodes = new ArrayList()
	}

	def register(LajerCommand command) {
		commands.put(command.name, command)
	}

	def add(NodeModel node, int x, int y) {
		val uml = new NodeFigure(this, node, new Label(node.getName()))
		nodes += uml
		layout.setConstraint(uml, new Rectangle(x, y, -1, -1))
		root.add(uml)
		return uml
	}

	def add(SplitterModel splitter, int x, int y) {
		val uml = new SplitterFigure(this, splitter, new Label(splitter.getName()))
		nodes += uml
		layout.setConstraint(uml, new Rectangle(x, y, -1, -1))
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
		}
	}
	
	def markAsDirty() {
		editor.markAsDirty()
	}

	def asOperation() {
		val file = '''/«editor.editorInput.file.project.name»/«editor.editorInput.file.projectRelativePath»'''
		val folder = JavaCore.create(editor.editorInput.file.project).allPackageFragmentRoots.filter[
			file.startsWith(path.makeAbsolute.toString())
		].get(0)
		val fullyQualifiedName = file.substring(folder.path.makeAbsolute.toString().length+1, file.length - ".lajer".length).replace("/", ".")
		return new OperationModel(fullyQualifiedName, inputPorts.map[port].toList(), outputPorts.map[port].toList(), nodes.map[node].toList())
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

	def getLayout() {
		return layout
	}

	def getRoot() {
		return root
	}

	def getNodes() {
		return nodes
	}

	def getSelected() {
		return selected
	}

	def getFocused() {
		return focused
	}

}
