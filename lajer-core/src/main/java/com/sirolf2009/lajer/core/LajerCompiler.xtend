package com.sirolf2009.lajer.core

import com.sirolf2009.lajer.core.component.Component
import com.sirolf2009.lajer.core.operation.model.Operation
import java.util.HashMap
import java.util.HashSet
import java.util.Map
import java.util.Set
import java.util.stream.Collectors
import java.util.stream.Stream
import org.eclipse.xtend.lib.annotations.Data

class LajerCompiler {
	
	def static compile(String groupID, extension Operation operation) {
		val ctx = new CompilingContext(groupID)
		return '''
		package «groupID».operation;
		
		import java.util.Arrays;
		import com.sirolf2009.lajer.core.operation.model.Connection;
		import com.sirolf2009.lajer.core.operation.model.Operation;
		
		«components.map[importStatement(ctx, it)].join("\n")»
		
		public class «name().toFirstUpper()» {
			
			public static Operation getOperation() {
				«components.map[declaration(ctx, it)].join("\n")»
				
				«connections(ctx, operation)»
				
				return new Operation("«operation.name()»", Arrays.asList(«operation.components.map[ctx.getVariableName(it)].join(", ")»), «inputNodes(ctx, operation)», «outputNodes(ctx, operation)»);
			}
			
		}
		'''
	}
	
	def static inputNodes(CompilingContext ctx, extension Operation operation) {
		'''Arrays.asList(«operation.inputPorts.map[
			val owner = operation.components.findFirst[component| component.inputPorts.contains(it)]
			'''«ctx.getVariableName(owner)».getInputPorts().get(«owner.inputPorts.indexOf(it)»)'''
		].join(", ")»)'''
	}
	
	def static outputNodes(CompilingContext ctx, extension Operation operation) {
		'''Arrays.asList(«operation.outputPorts.map[
			val owner = operation.components.findFirst[component| component.outputPorts.contains(it)]
			'''«ctx.getVariableName(owner)».getOutputPorts().get(«owner.outputPorts.indexOf(it)»)'''
		].join(", ")»)'''
	}
	
	def static connections(CompilingContext ctx, extension Operation operation) {
		val connections = operation.components.stream().flatMap[
			Stream.concat(inputPorts.stream().flatMap[incomingConnections.stream()], outputPorts.stream().flatMap[outgoingConnections.stream()])
		].collect(Collectors.toSet()).map[
			val fromCompiled = '''«ctx.getVariableName(from.component)».getOutputPorts().get(«from.component.outputPorts.indexOf(from)»)'''
			val toCompiled = '''«ctx.getVariableName(to.component).toFirstLower()».getInputPorts().get(«to.component.inputPorts.indexOf(to)»)'''
			'''Connection.connectTo(«fromCompiled», «toCompiled»);'''
		]
		return connections.join("\n")
	}
	
	def static declaration(CompilingContext ctx, extension Node node) {
		if(node instanceof Component) {
			return declaration(ctx, node as Component)
		} else {
			return declaration(ctx, node as Operation)	
		}
	}
	
	def static declaration(CompilingContext ctx, extension Component node) {
		return '''final «name().toFirstUpper()» «ctx.getVariableName(node)» = new «name().toFirstUpper()»();'''
	}
	
	def static declaration(CompilingContext ctx, extension Operation operation) {
		return '''final «name().toFirstUpper()» «ctx.getVariableName(operation)» = «ctx.groupID».operation.«name().toFirstUpper()».getOperation();'''
	}
	
	def static importStatement(CompilingContext ctx, extension Node node) {
		if(node instanceof Component) {
			return importStatement(ctx, node as Component)
		} else {
			return importStatement(ctx, node as Operation)
		}
	}
	
	def static importStatement(CompilingContext ctx, extension Operation node) {
		return '''import «ctx.groupID».operation.«name().toFirstUpper()»;'''
	}
	
	def static importStatement(CompilingContext ctx, extension Component node) {
		return '''import «node.class.name.replace("$", ".")»;'''
	}
	
	@Data static class CompilingContext {
		
		val String groupID 
		val Set<String> imports = new HashSet()
		val Map<Node, String> variableNamesNodeToString = new HashMap()
		val Map<String, Node> variableNamesStringToNode = new HashMap()
		
		def String getVariableName(Node node) {
			if(variableNamesNodeToString.containsKey(node)) {
				return variableNamesNodeToString.get(node)
			}
			val preferred = node.name().toFirstLower()
			if(variableNamesStringToNode.containsKey(preferred)) {
				if(variableNamesStringToNode.get(preferred) === node) {
					return preferred
				} else {
					return getNumberedName(node, 0)
				}
			} else {
				variableNamesStringToNode.put(preferred, node)
				variableNamesNodeToString.put(node, preferred)
				return preferred
			}
		}
		
		def private String getNumberedName(Node node, int number) {
			val name = node.name.toFirstLower()+number
			if(variableNamesStringToNode.containsKey(name)) {
				return getNumberedName(node, number+1)
			} else {
				variableNamesStringToNode.put(name, node)
				variableNamesNodeToString.put(node, name)
				return name
			}
		}
		
	}
	
}