package com.sirolf2009.lajer.ide.figure

import com.sirolf2009.lajer.core.Node
import java.util.List
import org.eclipse.draw2d.BorderLayout
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.Label
import org.eclipse.draw2d.ToolbarLayout
import org.eclipse.xtend.lib.annotations.Data
import java.util.ArrayList
import com.sirolf2009.lajer.ide.lajer.LajerManager

@Data class NodeFigure extends Figure {
	
	val Node node
	val List<InputFigure> inputFigures
	val List<OutputFigure> outputFigures

	new(LajerManager manager, Node node, Label name) {
		this.node = node
		layoutManager = new ToolbarLayout() => [
			minorAlignment = ToolbarLayout.ALIGN_TOPLEFT
			horizontal = true
		]
		opaque = true
		
		inputFigures = new ArrayList()
		add(new Figure() => [
			layoutManager = new ToolbarLayout()
			node.inputPorts.forEach[
				add(new InputFigure(this, it, manager) => [
					inputFigures.add(it)
				])
			]
		])
		add(new BoxFigure() => [
			add(name, BorderLayout.CENTER)
		])
		outputFigures = new ArrayList()
		add(new Figure() => [
			layoutManager = new ToolbarLayout()
			node.outputPorts.forEach[
				add(new OutputFigure(this, it, manager) => [
					outputFigures.add(it)
				])
			]
		])
	}

}
