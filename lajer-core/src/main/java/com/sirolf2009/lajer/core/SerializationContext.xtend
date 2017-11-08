package com.sirolf2009.lajer.core

import java.util.HashMap
import java.util.Map
import org.eclipse.xtend.lib.annotations.Data
import com.sirolf2009.lajer.core.model.NodeModel

@Data class SerializationContext {

	val Map<NodeModel, String> variableNamesNodeToString = new HashMap()
	val Map<String, NodeModel> variableNamesStringToNode = new HashMap()

	def String getVariableName(NodeModel node) {
		if(variableNamesNodeToString.containsKey(node)) {
			return variableNamesNodeToString.get(node)
		}
		val preferred = node.getName().toFirstLower()
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

	def private String getNumberedName(NodeModel node, int number) {
		val name = node.name.toFirstLower() + number
		if(variableNamesStringToNode.containsKey(name)) {
			return getNumberedName(node, number + 1)
		} else {
			variableNamesStringToNode.put(name, node)
			variableNamesNodeToString.put(node, name)
			return name
		}
	}

}
