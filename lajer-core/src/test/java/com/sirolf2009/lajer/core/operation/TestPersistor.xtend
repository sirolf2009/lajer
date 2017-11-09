package com.sirolf2009.lajer.core.operation

import com.sirolf2009.lajer.core.LajerModelPersistor
import com.sirolf2009.lajer.core.model.ComponentModel
import com.sirolf2009.lajer.core.model.SplitterModel
import java.io.ByteArrayOutputStream
import java.nio.charset.Charset
import junit.framework.Assert
import org.junit.Test

class TestPersistor {

	@Test
	def void testPersistCalculator() {
		val out = new ByteArrayOutputStream()
		LajerModelPersistor.persistModel(TestCalculatorModel.calculatorModel, out)
		val model = out.toString(Charset.defaultCharset().name())
		out.close()
		Assert.assertTrue(model, model.contains("version: 1"))
		Assert.assertTrue(model, model.contains("name: com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator"))
		Assert.assertTrue(model, model.contains("(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.UserInput:1:1)->userInput"))
		Assert.assertTrue(model, model.contains("(S:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.EquationChecker:1:2)->equationChecker"))
		Assert.assertTrue(model, model.contains("subtractor->(20:20)"))
		Assert.assertTrue(model, model.contains("(equationChecker:0)->(summer:0)"))
		Assert.assertTrue(model, model.contains("inputs: [(userInput:0)]"))
		Assert.assertTrue(model, model.contains("outputs: []"))
	}

	@Test
	def void testParseCalculator() {
		val persisted = '''
		version: 1
		name: com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator
		nodes: [(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Displayer:1:1)->displayer,(S:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.EquationChecker:1:2)->equationChecker,(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Subtractor:1:1)->subtractor,(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Summer:1:1)->summer,(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.UserInput:1:1)->userInput]
		positions: [displayer->(30:10),equationChecker->(10:10),subtractor->(20:20),summer->(20:0),userInput->(0:10)]
		connections: [(equationChecker:1)->(subtractor:0),(equationChecker:0)->(summer:0),(subtractor:0)->(displayer:0),(summer:0)->(displayer:0),(userInput:0)->(equationChecker:0)]
		inputs: [(userInput:0)]
		outputs: []'''
		val model = LajerModelPersistor.parseModel(persisted)
		model.connections.forEach [ connection |
			val fromComponent = model.components.flatMap[outputPorts.filter[it === connection.from]].get(0)
			val toComponent = model.components.flatMap[inputPorts.filter[it === connection.to]].get(0)
			Assert.assertNotNull(fromComponent)
			Assert.assertNotNull(toComponent)
		]
		Assert.assertEquals(4, model.components.filter[
			it instanceof ComponentModel
		].size())
		Assert.assertEquals(1, model.components.filter[
			it instanceof SplitterModel
		].size())
	}
}
