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
		val expected = '''
		version: 1
		name: com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator
		nodes: [(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Displayer:1:1)->displayer,(S:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.EquationChecker:1:2)->equationChecker,(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Subtractor:1:1)->subtractor,(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Summer:1:1)->summer,(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Summer:1:1)->summer0]
		connections: [(equationChecker:1)->(subtractor:0),(equationChecker:0)->(summer0:0),(subtractor:0)->(displayer:0),(summer:0)->(equationChecker:0),(summer0:0)->(displayer:0)]
		inputs: [(summer:0)]
		outputs: []'''
		Assert.assertEquals(expected.trim(), model.trim())
	}

	@Test
	def void testParseCalculator() {
		val persisted = '''
		version: 1
		name: com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator
		nodes: [(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Displayer:1:1)->displayer,(S:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.EquationChecker:1:2)->equationChecker,(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Subtractor:1:1)->subtractor,(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Summer:1:1)->summer,(C:com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Summer:1:1)->summer0]
		connections: [(equationChecker:0)->(summer0:0),(equationChecker:1)->(subtractor:0),(subtractor:0)->(displayer:0),(summer:0)->(equationChecker:0),(summer0:0)->(displayer:0)]
		inputs: [(summer:0)]
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
