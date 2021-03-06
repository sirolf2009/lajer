package com.sirolf2009.lajer.core.annotation

import com.sirolf2009.lajer.core.Port
import java.util.Arrays
import java.util.List
import org.eclipse.xtend.lib.macro.AbstractClassProcessor
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.Visibility

@Active(ComponentProcessor)
annotation Component {

	static class ComponentProcessor extends AbstractClassProcessor {

		override doTransform(MutableClassDeclaration annotatedClass, extension TransformationContext context) {
			if(annotatedClass.extendedClass == newTypeReference(Object)) {
				annotatedClass.extendedClass = newTypeReference(com.sirolf2009.lajer.core.component.Component)
			} else if(annotatedClass.extendedClass == newTypeReference(com.sirolf2009.lajer.core.component.Component)) {
				annotatedClass.addError("Components may not inherit another class")
			}

			val ports = annotatedClass.declaredMethods.filter[visibility.equals(Visibility.PUBLIC)].toList()
			ports.forEach [
				addAnnotation(newAnnotationReference(Expose))
			]

			val adaptablePort = "com.sirolf2009.lajer.core.component.AdaptablePort"
			val functionPort = "com.sirolf2009.lajer.core.component.FunctionPort"
			val consumerPort = "com.sirolf2009.lajer.core.component.ConsumerPort"
			val producerPort = "com.sirolf2009.lajer.core.component.ProducerPort"
			val methodHandle = "java.lang.invoke.MethodHandles"
			val methodType = "java.lang.invoke.MethodType"

			annotatedClass.addMethod("getPorts") [
				returnType = newTypeReference(List, newTypeReference(Port))
				addAnnotation(Override.newAnnotationReference())
				body = '''
				try {
					return «Arrays.newTypeReference()».asList(«ports.map[
			 			if(parameters.size() == 0) {
			 				'''(Port) new «producerPort»(this, «methodHandle».lookup().bind(this, "«simpleName»", «methodType».methodType(«returnType».class)))'''
			 			} else if(returnType == newTypeReference(void)) {
			 				'''(Port) new «adaptablePort»(java.util.Arrays.asList(«parameters.map[type+".class"].join(", ")»), new «consumerPort»(this, «methodHandle».lookup().bind(this, "«simpleName»", «methodType».methodType(«returnType».class, «parameters.map[type+".class"].join(", ")»))))'''
			 			} else {
			 				'''(Port) new «adaptablePort»(java.util.Arrays.asList(«parameters.map[type+".class"].join(", ")»), new «functionPort»(this, «methodHandle».lookup().bind(this, "«simpleName»", «methodType».methodType(«returnType».class, «parameters.map[type+".class"].join(", ")»))))'''
			 			}
			 		].join(",\n")»);
				} catch(Exception e) {
					throw new RuntimeException(e);
				}'''
			]
		}

	}

}
