package com.sirolf2009.lajer.core

import com.sirolf2009.lajer.core.model.NodeModel
import com.sirolf2009.lajer.core.model.OperationModel

class LajerCompiler {

	def static compile(extension OperationModel operation) {
		val ctx = new SerializationContext()
		val name = operation.getFullyQualifiedName()
		val names = name.split("\\.")
		return '''
			package «names.subList(0, names.size()-1).join(".")»;
			
			import java.util.Arrays;
			import java.util.List;
			import com.sirolf2009.lajer.core.operation.model.Connection;
			import com.sirolf2009.lajer.core.annotation.Operation;
			import com.sirolf2009.lajer.core.Node;
			import com.sirolf2009.lajer.core.Port;
			
			«components.map[importStatement(ctx, it)].toSet().join("\n")»
			
			@Operation
			public class «getName()» extends com.sirolf2009.lajer.core.operation.model.Operation {
				
				public «getName()»(String fullyQualifiedName, List<Node> components, List<Port> inputPorts, List<Port> outputPorts) {
					super(fullyQualifiedName, components, inputPorts, outputPorts);
				}
				
				public static «getName()» getOperation() {
					«components.map[declaration(ctx, it)].sort.join("\n")»
					
					«connections(ctx, operation)»
					
					return new «getName()»("«operation.getFullyQualifiedName()»", Arrays.asList(«operation.components.map['''(Node) «ctx.getVariableName(it)»'''].join(", ")»), «inputNodes(ctx, operation)», «outputNodes(ctx, operation)»);
				}
				
			}
		'''
	}

	def static inputNodes(SerializationContext ctx, extension OperationModel operation) {
		if(operation.inputPorts.empty) {
			'''new java.util.ArrayList<Port>()'''
		} else {
			'''Arrays.asList(«operation.inputPorts.map[
			val owner = operation.components.findFirst[component| component.inputPorts.contains(it)]
			'''«ctx.getVariableName(owner)».getInputPorts().get(«owner.inputPorts.indexOf(it)»)'''
		].join(", ")»)'''
		}
	}

	def static outputNodes(SerializationContext ctx, extension OperationModel operation) {
		if(operation.outputPorts.empty) {
			'''new java.util.ArrayList<Port>()'''
		} else {
			'''Arrays.asList(«operation.outputPorts.map[
			val owner = operation.components.findFirst[component| component.outputPorts.contains(it)]
			'''«ctx.getVariableName(owner)».getOutputPorts().get(«owner.outputPorts.indexOf(it)»)'''
		].join(", ")»)'''
		}
	}

	def static connections(SerializationContext ctx, extension OperationModel operation) {
		val connections = operation.connections.map [
			val fromCompiled = '''«ctx.getVariableName(from.component)».getOutputPorts().get(«from.component.outputPorts.indexOf(from)»)'''
			val toCompiled = '''«ctx.getVariableName(to.component).toFirstLower()».getInputPorts().get(«to.component.inputPorts.indexOf(to)»)'''
			'''Connection.connectTo(«fromCompiled», «toCompiled»);'''
		]
		return connections.sort.join("\n")
	}

	def static declaration(SerializationContext ctx, extension NodeModel node) {
		if(node instanceof OperationModel) {
			return '''final «getName().toFirstUpper()» «ctx.getVariableName(node)» = «getName().toFirstUpper()».getOperation();'''
		} else {
			return '''final «getName().toFirstUpper()» «ctx.getVariableName(node)» = new «getName().toFirstUpper()»();'''
		}
	}

	def static importStatement(SerializationContext ctx, extension NodeModel node) {
		return '''import «node.getFullyQualifiedName()»;'''
	}

}
