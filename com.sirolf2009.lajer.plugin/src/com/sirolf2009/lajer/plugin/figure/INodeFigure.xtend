package com.sirolf2009.lajer.plugin.figure

import com.sirolf2009.lajer.core.model.NodeModel
import java.util.List
import org.eclipse.draw2d.IFigure

interface INodeFigure extends IFigure {
	
	def NodeModel getNode()
	def List<InputFigure> getInputFigures()
	def List<OutputFigure> getOutputFigures()
	
}