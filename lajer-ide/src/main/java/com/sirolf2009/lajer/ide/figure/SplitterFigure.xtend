package com.sirolf2009.lajer.ide.figure

import com.sirolf2009.lajer.core.splitter.Splitter
import com.sirolf2009.lajer.ide.lajer.LajerManager
import org.eclipse.draw2d.BorderLayout
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.Label
import org.eclipse.draw2d.ToolbarLayout
import org.eclipse.xtend.lib.annotations.Data

@Data class SplitterFigure extends Figure implements INodeFigure {

	val Splitter splitter
	val InputFigure inputFigure
	val OutputFigure trueFigure
	val OutputFigure falseFigure

	new(LajerManager manager, Splitter splitter, Label name) {
		this.splitter = splitter
		layoutManager = new ToolbarLayout() => [
			minorAlignment = ToolbarLayout.ALIGN_TOPLEFT
			horizontal = true
		]
		opaque = true

		inputFigure = new InputFigure(this, splitter.inputPorts.get(0), manager)
		add(inputFigure)
		
		add(new BoxFigure() => [
			add(name, BorderLayout.CENTER)
		])
		
		trueFigure = new OutputFigure(this, splitter.truePort, manager)
		falseFigure = new OutputFigure(this, splitter.falsePort, manager)
		add(new Figure() => [
			layoutManager = new ToolbarLayout()
			add(trueFigure)
			add(falseFigure)
		])
	}
	
	override getNode() {
		return splitter
	}
	
	override getInputFigures() {
		return #[inputFigure]
	}
	
	override getOutputFigures() {
		return #[trueFigure, falseFigure]
	}

}
