package com.sirolf2009.lajer.ide.figure

import com.sirolf2009.lajer.core.Node
import java.util.List

interface INodeFigure {
	
	def Node getNode()
	def List<InputFigure> getInputFigures()
	def List<OutputFigure> getOutputFigures()
	
}