package com.sirolf2009.lajer.plugin.figure

import com.sirolf2009.lajer.core.model.SplitterModel
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import org.eclipse.draw2d.BorderLayout
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.Label
import org.eclipse.draw2d.ToolbarLayout

class SplitterFigure extends Figure implements INodeFigure {

	val SplitterModel splitter
	val InputFigure inputFigure
	val OutputFigure trueFigure
	val OutputFigure falseFigure

	new(LajerManager manager, SplitterModel splitter, Label name) {
		this.splitter = splitter
		layoutManager = new ToolbarLayout() => [
			minorAlignment = ToolbarLayout.ALIGN_TOPLEFT
			horizontal = true
		]
		opaque = true

		inputFigure = new InputFigure(this, splitter.splitterPort, manager)
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
	
	def getSplitter() {
		return splitter
	}
	
	def getInputFigure() {
		return inputFigure
	}
	
	def getTrueFigure() {
		return trueFigure
	}
	
	def getFalseFigure() {
		return falseFigure
	}

}
