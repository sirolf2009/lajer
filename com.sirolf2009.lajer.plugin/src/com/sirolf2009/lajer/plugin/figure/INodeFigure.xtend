package com.sirolf2009.lajer.plugin.figure

import com.sirolf2009.lajer.core.model.NodeModel
import java.util.List

interface INodeFigure {
	
	def NodeModel getNode()
	def List<InputFigure> getInputFigures()
	def List<OutputFigure> getOutputFigures()
	
}