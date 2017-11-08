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
		import com.sirolf2009.lajer.core.operation.model.Connection;
		import com.sirolf2009.lajer.core.annotation.Operation;
		
		«components.map[importStatement(ctx, it)].toSet().join("\n")»
		
		@Operation
		public class «getName()» {
			
			public static com.sirolf2009.lajer.core.operation.model.Operation getOperation() {
				«components.map[declaration(ctx, it)].sort.join("\n")»
				
				«connections(ctx, operation)»
				
				return new com.sirolf2009.lajer.core.operation.model.Operation("«operation.getFullyQualifiedName()»", Arrays.asList(«operation.components.map[ctx.getVariableName(it)].join(", ")»), «inputNodes(ctx, operation)», «outputNodes(ctx, operation)»);
			}
			
		}
		'''
	}
	
	def static inputNodes(SerializationContext ctx, extension OperationModel operation) {
		'''Arrays.asList(«operation.inputPorts.map[
			val owner = operation.components.findFirst[component| component.inputPorts.contains(it)]
			'''«ctx.getVariableName(owner)».getInputPorts().get(«owner.inputPorts.indexOf(it)»)'''
		].join(", ")»)'''
	}
	
	def static outputNodes(SerializationContext ctx, extension OperationModel operation) {
		'''Arrays.asList(«operation.outputPorts.map[
			val owner = operation.components.findFirst[component| component.outputPorts.contains(it)]
			'''«ctx.getVariableName(owner)».getOutputPorts().get(«owner.outputPorts.indexOf(it)»)'''
		].join(", ")»)'''
	}
	
	def static connections(SerializationContext ctx, extension OperationModel operation) {
		val connections = operation.connections.map[
			val fromCompiled = '''«ctx.getVariableName(from.component)».getOutputPorts().get(«from.component.outputPorts.indexOf(from)»)'''
			val toCompiled = '''«ctx.getVariableName(to.component).toFirstLower()».getInputPorts().get(«to.component.inputPorts.indexOf(to)»)'''
			'''Connection.connectTo(«fromCompiled», «toCompiled»);'''
		]
		return connections.sort.join("\n")
	}
	
	def static declaration(SerializationContext ctx, extension NodeModel node) {
		return '''final «getName().toFirstUpper()» «ctx.getVariableName(node)» = new «getName().toFirstUpper()»();'''
	}
	
	def static importStatement(SerializationContext ctx, extension NodeModel node) {
		return '''import «node.getFullyQualifiedName()»;'''
	}
	
}