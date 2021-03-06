package com.sirolf2009.lajer.plugin.figure

import com.sirolf2009.lajer.core.model.NodeModel
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import java.util.ArrayList
import java.util.List
import org.eclipse.draw2d.BorderLayout
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.Label
import org.eclipse.draw2d.ToolbarLayout

class NodeFigure extends Figure implements INodeFigure {

	val NodeModel node
	val List<InputFigure> inputFigures
	val List<OutputFigure> outputFigures

	new(LajerManager manager, NodeModel node, Label name) {
		this.node = node
		layoutManager = new ToolbarLayout(true) => [
			stretchMinorAxis = true
		]
		opaque = true
		
		inputFigures = new ArrayList()
		add(new Figure() => [
			layoutManager = new ToolbarLayout(false) => [
				minorAlignment = ToolbarLayout.ALIGN_CENTER
			]
			node.inputPorts.forEach [ port |
				add(new Figure() => [
					layoutManager = new ToolbarLayout(true) => [
						minorAlignment = ToolbarLayout.ALIGN_CENTER
					]
					add(new InputFigure(this, port, manager) => [
						inputFigures.add(it)
					])
				])
			]
		])
		add(new BoxFigure() => [
			add(name, BorderLayout.CENTER)
		])
		outputFigures = new ArrayList()
		add(new Figure() => [
			layoutManager = new ToolbarLayout(false) => [
				minorAlignment = ToolbarLayout.ALIGN_CENTER
			]
			node.outputPorts.forEach [ port |
				add(new Figure() => [
					layoutManager = new ToolbarLayout(true) => [
						minorAlignment = ToolbarLayout.ALIGN_CENTER
					]
					add(new OutputFigure(this, port, manager) => [
						outputFigures.add(it)
					])
				])
			]
		])
	}

	override getNode() {
		return node
	}

	override getInputFigures() {
		return inputFigures
	}

	override getOutputFigures() {
		return outputFigures
	}

}
