package com.sirolf2009.lajer.core

import com.sirolf2009.lajer.core.model.ComponentModel
import com.sirolf2009.lajer.core.model.ConnectionModel
import com.sirolf2009.lajer.core.model.NodeModel
import com.sirolf2009.lajer.core.model.OperationModel
import com.sirolf2009.lajer.core.model.PortModel
import com.sirolf2009.lajer.core.model.SplitterModel
import java.io.File
import java.io.FileOutputStream
import java.io.OutputStream
import java.io.PrintWriter
import java.text.ParseException
import java.util.ArrayList
import java.util.HashMap
import java.util.NoSuchElementException
import java.util.regex.Pattern

class LajerModelPersistor {

	static val versionPattern = Pattern.compile("version: ([0-9]+)")
	static val namePattern = Pattern.compile("name: (.+)")
	static val nodesPattern = Pattern.compile("nodes: \\[(.*)\\]")
	static val nodeDeclarationPattern = Pattern.compile('''\(([CSO]):([a-zA-Z0-9\.]+):([0-9]):([0-9])\)->([a-zA-Z0-9]+)''')
	static val connectionsPattern = Pattern.compile("connections: \\[(.*)\\]")
	static val connectionDeclarationPattern = Pattern.compile('''\(([a-zA-Z]+):([0-9])\)->\(([a-zA-Z]+):([0-9])\)''')
	static val inputsPattern = Pattern.compile("inputs: \\[(.*)\\]")
	static val outputsPattern = Pattern.compile("outputs: \\[(.*)\\]")
	static val portDeclarationPattern = Pattern.compile('''\(([a-zA-Z0-9]+):([0-9])\)''')

	def static persistModel(OperationModel operation, File destination) {
		new FileOutputStream(destination) => [
			operation.persistModel(it)
			close()
		]
	}

	def static persistModel(OperationModel operation, OutputStream out) {
		val ctx = new SerializationContext()
		val writer = new PrintWriter(out)
		writer.append('''
		version: 1
		name: «operation.fullyQualifiedName»
		nodes: [«operation.components.map['''(«typeID(it)»:«fullyQualifiedName»:«inputPorts.size()»:«outputPorts.size()»)->«ctx.getVariableName(it)»'''].join(",")»]
		connections: [«operation.connections.map[
			return '''«ctx.asInputIdentifier(from)»->«ctx.asOutputIdentifier(to)»'''
		].join(",")»]
		inputs: [«operation.inputPorts.map[
			return ctx.asInputIdentifier(it)
		].join(",")»]
		outputs: [«operation.outputPorts.map[
			return ctx.asInputIdentifier(it)
		].join(",")»]''')
		writer.flush()
	}

	def static typeID(NodeModel node) {
		if(node instanceof ComponentModel) {
			return "C"
		} else if(node instanceof SplitterModel) {
			return "S"
		} else if(node instanceof OperationModel) {
			return "O"
		} else {
			throw new IllegalArgumentException("Unknown model type " + node)
		}
	}

	def static asInputIdentifier(SerializationContext ctx, PortModel port) {
		return '''(«ctx.getVariableName(port.component)»:«port.component.inputPorts.indexOf(port)»)'''
	}

	def static asOutputIdentifier(SerializationContext ctx, PortModel port) {
		return '''(«ctx.getVariableName(port.component)»:«port.component.inputPorts.indexOf(port)»)'''
	}

	def static parseModel(String model) {
		val version = Integer.parseInt(model.findOne(versionPattern))
		if(version != 1) {
			throw new IllegalArgumentException("Unknown version: " + version)
		}
		val name = model.findOne(namePattern)
		val nodesTag = model.findOne(nodesPattern)
		val nodes = new HashMap<String, NodeModel>()
		nodesTag.findZeroOrMoreGroups(LajerModelPersistor.nodeDeclarationPattern, 5).forEach [
			val node = if(get(0) == "C") {
					new ComponentModel(get(1), new ArrayList(get(2).asInt()), new ArrayList(get(3).asInt()))
				} else if(get(0) == "S") {
					new ComponentModel(get(1), new ArrayList(get(2).asInt()), new ArrayList(get(3).asInt()))
				} else if(get(0) == "O") {
					new OperationModel(get(1), new ArrayList(get(2).asInt()), new ArrayList(get(3).asInt()), new ArrayList())
				}
			(0 ..< get(2).asInt()).forEach[node.inputPorts.add(new PortModel(node, new ArrayList(), new ArrayList()))]
			(0 ..< get(3).asInt()).forEach[node.outputPorts.add(new PortModel(node, new ArrayList(), new ArrayList()))]
			nodes.put(get(4), node)
		]
		val connectionsTag = model.findOne(connectionsPattern)
		connectionsTag.findZeroOrMoreGroups(connectionDeclarationPattern, 4).forEach [
			val from = nodes.get(get(0)).outputPorts.get(get(1).asInt())
			val to = nodes.get(get(2)).outputPorts.get(get(3).asInt())
			val connection = new ConnectionModel(from, to)
			from.outgoingConnections += connection
			to.incomingConnections += connection
		]
		val inputsTag = model.findOne(inputsPattern)
		val inputs = inputsTag.findZeroOrMoreGroups(portDeclarationPattern, 2).map [
			nodes.get(get(0)).inputPorts.get(get(1).asInt())
		].toList()
		val outputsTag = model.findOne(outputsPattern)
		val outputs = outputsTag.findZeroOrMoreGroups(portDeclarationPattern, 2).map [
			nodes.get(get(0)).outputPorts.get(get(1).asInt())
		].toList()
		return new OperationModel(name, inputs, outputs, nodes.values().toList())
	}

	def static findOne(String model, Pattern pattern) {
		val matcher = pattern.matcher(model)
		if(!matcher.find()) {
			throw new NoSuchElementException(pattern.pattern + " not present in " + model)
		} else if(matcher.groupCount() != 1) {
			throw new ParseException("multiple " + pattern.pattern + " in " + model, matcher.start(2))
		} else {
			return matcher.group(1)
		}
	}

	def static findZeroOrMore(String model, Pattern pattern) {
		return findZeroOrMoreGroups(model, pattern, 1).map[get(0)]
	}

	def static findZeroOrMoreGroups(String model, Pattern pattern, int groups) {
		val matcher = pattern.matcher(model)
		val matches = new ArrayList()
		while(matcher.find()) {
			val match = new ArrayList()
			(0 ..< groups).forEach [
				match.add(matcher.group(it + 1))
			]
			matches.add(match)
		}
		return matches
	}

	def static asInt(String string) {
		return Integer.parseInt(string)
	}

}
