package com.sirolf2009.lajer.core.operation

import org.junit.Test
import com.sirolf2009.lajer.core.LajerCompiler

class TestCompiler {
	
	@Test
	def void testCalculator() {
		val calculator = TestCalculator.calculator
		println(LajerCompiler.compile("com.sirolf2009", calculator))
	}
	
}