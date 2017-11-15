package com.sirolf2009.lajer.plugin.lajer

import com.sirolf2009.lajer.core.model.NodeModel
import com.sirolf2009.lajer.core.model.OperationModel
import com.sirolf2009.lajer.core.model.SplitterModel
import com.sirolf2009.lajer.plugin.LajerEditor
import com.sirolf2009.lajer.plugin.figure.CallbackConnectionFigure
import com.sirolf2009.lajer.plugin.figure.INodeFigure
import com.sirolf2009.lajer.plugin.figure.InputFigure
import com.sirolf2009.lajer.plugin.figure.NodeFigure
import com.sirolf2009.lajer.plugin.figure.OperationInputFigure
import com.sirolf2009.lajer.plugin.figure.OperationOutputFigure
import com.sirolf2009.lajer.plugin.figure.OriginConnectionFigure
import com.sirolf2009.lajer.plugin.figure.OutputFigure
import com.sirolf2009.lajer.plugin.figure.PortFigure
import com.sirolf2009.lajer.plugin.figure.SplitterFigure
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.IFigure
import org.eclipse.draw2d.Label
import org.eclipse.draw2d.XYLayout
import org.eclipse.draw2d.geometry.Rectangle
import org.eclipse.jdt.core.JavaCore
import org.eclipse.swt.widgets.Canvas

class LajerManager {

	val Canvas canvas
	val XYLayout layout
	val Figure root
	val LajerEditor editor
	val List<INodeFigure> nodes
	val Set<PortFigure> selected
	val Set<InputFigure> inputPorts
	val Set<OutputFigure> outputPorts
	var PortFigure focused

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

	def add(NodeModel node, int x, int y) {
		val figure = if(node instanceof SplitterModel) {
				new SplitterFigure(this, node, new Label(node.getName()))
			} else {
				new NodeFigure(this, node, new Label(node.getName()))
			}
		nodes += figure as INodeFigure
		layout.setConstraint(figure, new Rectangle(x, y, -1, -1))
		root.add(figure)
		return figure
	}

	def markAsDirty() {
		editor.markAsDirty()
	}

	def asOperation() {
		val file = '''/«editor.editorInput.file.project.name»/«editor.editorInput.file.projectRelativePath»'''
		val folder = JavaCore.create(editor.editorInput.file.project).allPackageFragmentRoots.filter [
			file.startsWith(path.makeAbsolute.toString())
		].get(0)
		val fullyQualifiedName = file.substring(folder.path.makeAbsolute.toString().length + 1, file.length - ".lajer".length).replace("/", ".")
		val positions = nodes.map [
			val constraint = layout.getConstraint(it) as Rectangle
			node -> (constraint.topLeft.x -> constraint.topLeft.y)
		].toMap([key], [value])
		return new OperationModel(fullyQualifiedName, inputPorts.map[port].toList(), outputPorts.map[port].toList(), nodes.map[node].toList(), positions)
	}

	def markAsInput(InputFigure input) {
		val operationInputFigure = new OperationInputFigure()
		root.add(operationInputFigure)
		val connection = new OriginConnectionFigure(operationInputFigure, input)
		root.add(connection)
		inputPorts.add(input)
		input.addFigureListener [
			layout.setConstraint(operationInputFigure, new Rectangle(input.bounds.center.x - 80, input.bounds.center.y - 10, -1, -1))
		]
		return connection
	}

	def unmarkAsInput(InputFigure input) {
		if(inputPorts.contains(input)) {
			inputPorts.remove(input)
			val toBeRemoved = root.children.filter[it instanceof OriginConnectionFigure].map[it as OriginConnectionFigure].filter [
				it.to == input
			].toSet()
			toBeRemoved.forEach [
				root.remove(it)
				root.remove(from)
			]
		}
	}

	def markAsOutput(OutputFigure output) {
		val operationOutputFigure = new OperationOutputFigure()
		root.add(operationOutputFigure)
		val connection = new CallbackConnectionFigure(output, operationOutputFigure)
		root.add(connection)
		outputPorts.add(output)
		output.addFigureListener [
			layout.setConstraint(operationOutputFigure, new Rectangle(output.bounds.center.x + 80, output.bounds.center.y - 10, -1, -1))
		]
		return connection
	}
	
	def unmarkAsOutput(OutputFigure output) {
		if(outputPorts.contains(output)) {
				outputPorts.remove(output)
				val toBeRemoved = root.children.filter[it instanceof CallbackConnectionFigure].map[it as CallbackConnectionFigure].filter [
					it.from == output
				].toSet()
				toBeRemoved.forEach[
					root.remove(it)
					root.remove(to)
				]
			}
	}

	def focusOnFirst() {
		unfocus()
		var i = 0
		while(focused === null && i < nodes.size()) {
			val it = nodes.get(i)
			if(!inputFigures.isEmpty()) {
				inputFigures.get(0).focus()
			} else if(!outputFigures.isEmpty()) {
				outputFigures.get(0).focus()
			} else {
				i++
			}
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

	def getConstraint(IFigure figure) {
		return layout.getConstraint(figure) as Rectangle
	}

	def isInput(PortFigure port) {
		return port instanceof InputFigure
	}

	def isOutput(PortFigure port) {
		return port instanceof OutputFigure
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

	def getInputPorts() {
		return inputPorts
	}

	def getOutputPorts() {
		return outputPorts
	}

}
