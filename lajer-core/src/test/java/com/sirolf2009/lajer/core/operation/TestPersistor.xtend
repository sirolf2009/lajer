package com.sirolf2009.lajer.core.operation

import com.sirolf2009.lajer.core.LajerModelPersistor
import org.junit.Test

class TestPersistor {
	
	val compiledCalculator = '''
	version: 1
	name: com.sirolf2009.lajer.Calculator
	nodes: [(C:com.sirolf2009.lajer.core.operation.TestCalculator.UserInput:1:1)->userInput,(S:com.sirolf2009.lajer.core.operation.TestCalculator.EquationChecker:1:2)->equationChecker,(C:com.sirolf2009.lajer.core.operation.TestCalculator.Summer:1:1)->summer,(C:com.sirolf2009.lajer.core.operation.TestCalculator.Subtractor:1:1)->subtractor,(C:com.sirolf2009.lajer.core.operation.TestCalculator.Displayer:1:1)->displayer]
	connections: [(equationChecker:-1)->(summer:0),(summer:0)->(displayer:0),(userInput:0)->(equationChecker:0),(subtractor:0)->(displayer:0),(equationChecker:-1)->(subtractor:0)]
	inputs: [(userInput:0)]
	outputs: []'''
	
	@Test
	def void testParseCalculator() {
		LajerModelPersistor.parseModel(compiledCalculator)
	}
	
}