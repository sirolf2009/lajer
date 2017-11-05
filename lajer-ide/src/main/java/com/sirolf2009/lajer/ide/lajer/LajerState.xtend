package com.sirolf2009.lajer.ide.lajer

import com.esotericsoftware.kryo.Kryo
import com.esotericsoftware.kryo.Serializer
import com.esotericsoftware.kryo.io.Input
import com.esotericsoftware.kryo.io.Output
import com.sirolf2009.lajer.ide.figure.INodeFigure
import com.sirolf2009.lajer.ide.figure.PortFigure
import java.util.List
import java.util.Set
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.XYLayout
import org.eclipse.xtend.lib.annotations.Data

@Data class LajerState {
	
	val XYLayout layout
	val Figure root
	val List<INodeFigure> nodes
	val Set<PortFigure> selected
	val Set<PortFigure> inputPorts
	val Set<PortFigure> outputPorts
	
	public static class LajerStateSerializer extends Serializer<LajerState> {
		
		override read(Kryo kryo, Input input, Class<LajerState> type) {
			val layout = kryo.readObject(input, XYLayout)
			val root = kryo.readObject(input, Figure)
			val nodes = kryo.readObject(input, List) as List<INodeFigure>
			val selected = kryo.readObject(input, Set) as Set<PortFigure>
			val inputPorts = kryo.readObject(input, Set) as Set<PortFigure>
			val outputPorts = kryo.readObject(input, Set) as Set<PortFigure>
			return new LajerState(layout, root, nodes, selected, inputPorts, outputPorts)
		}
		
		override write(Kryo kryo, Output output, extension LajerState object) {
			kryo.writeObject(output, layout)
			kryo.writeObject(output, root)
			kryo.writeObject(output, nodes)
			kryo.writeObject(output, selected)
			kryo.writeObject(output, inputPorts)
			kryo.writeObject(output, outputPorts)
		}
		
	}
	
}