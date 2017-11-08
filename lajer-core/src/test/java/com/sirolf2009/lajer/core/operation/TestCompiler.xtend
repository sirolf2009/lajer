package com.sirolf2009.lajer.core.operation

import com.sirolf2009.lajer.core.operation.TestCalculator.EquationChecker
import com.sirolf2009.lajer.core.operation.TestCalculator.Summer
import junit.framework.Assert
import org.junit.Test

class TestCompiler {
	
	@Test
	def void testFullyQualifiedName() {
		Assert.assertEquals("com.sirolf2009.lajer.core.operation.TestCalculator.Summer", new Summer().fullyQualifiedName)
		Assert.assertEquals("com.sirolf2009.lajer.core.operation.TestCalculator.EquationChecker", new EquationChecker().fullyQualifiedName)
		Assert.assertEquals("com.sirolf2009.lajer.Calculator", TestCalculator.calculator.fullyQualifiedName)
	}
	
	@Test
	def void testName() {
		Assert.assertEquals("Summer", new Summer().getName())
		Assert.assertEquals("EquationChecker", new EquationChecker().getName())
		Assert.assertEquals("Calculator", TestCalculator.calculator.getName())
	}
	
}