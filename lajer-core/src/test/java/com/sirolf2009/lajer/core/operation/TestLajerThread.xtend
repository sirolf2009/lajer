package com.sirolf2009.lajer.core.operation

import com.sirolf2009.lajer.core.component.Component
import com.sirolf2009.lajer.core.component.MethodPort
import com.sirolf2009.lajer.core.operation.model.Operation
import java.lang.invoke.MethodHandles
import java.lang.invoke.MethodType
import org.junit.Assert
import org.junit.Test

import static extension com.sirolf2009.lajer.core.operation.model.Connection.*

class TestLajerThread {

	@Test
	def void testSinglePort() {
		val saver = new Saver()
		new LajerThread(saver.inputPorts.get(0), #[2]).run()
		Assert.assertEquals(2, saver.number)
	}

	@Test
	def void testMultiplePorts() {
		val doubler = new Doubler()
		val quadrupler = new Quadrupler()
		val saver = new Saver()

		doubler.outputPorts.get(0).connectTo(quadrupler.inputPorts.get(0))
		quadrupler.outputPorts.get(0).connectTo(saver.inputPorts.get(0))

		new LajerThread(doubler.inputPorts.get(0), #[2]).run()
		Assert.assertEquals(16, saver.number)
	}

	@Test
	def void testBranchingPorts() {
		val doubler = new Doubler()
		val quadrupler = new Quadrupler()
		val saver1 = new Saver()
		val saver2 = new Saver()

		doubler.outputPorts.get(0).connectTo(quadrupler.inputPorts.get(0))
		quadrupler.outputPorts.get(0).connectTo(saver1.inputPorts.get(0))
		doubler.outputPorts.get(0).connectTo(saver2.inputPorts.get(0))

		new LajerThread(doubler.inputPorts.get(0), #[2]).run()
		Thread.sleep(1000)
		Assert.assertEquals(16, saver1.number)
		Assert.assertEquals(4, saver2.number)
	}

	@Test
	def void testSimpleOperation() {
		val doubler = new Doubler()
		val saver = new Saver()

		doubler.outputPorts.get(0).connectTo(saver.inputPorts.get(0))
		val operation = new Operation("", #[doubler, saver], #[doubler.inputPorts.get(0)], #[])

		new LajerThread(operation.inputPorts.get(0), #[2]).run()
		Assert.assertEquals(4, saver.number)
	}

	@Test
	def void testDoubleSimpleOperation() {
		val operation1Creator = [
			val doubler = new Doubler()
			val quadrupler = new Quadrupler()
			doubler.outputPorts.get(0).connectTo(quadrupler.inputPorts.get(0))
			new Operation("", #[doubler, quadrupler], #[doubler.inputPorts.get(0)], #[quadrupler.outputPorts.get(0)])
		]
		val operation1 = operation1Creator.apply(null)

		val saver = new Saver()
		val operation2Creator = [
			val doubler = new Doubler()
			doubler.outputPorts.get(0).connectTo(saver.inputPorts.get(0))
			new Operation("", #[doubler, saver], #[doubler.inputPorts.get(0)], #[])
		]
		val operation2 = operation2Creator.apply(null)

		operation1.outputPorts.get(0).connectTo(operation2.inputPorts.get(0))
		val operation = new Operation("", #[operation1, operation2], #[operation1.inputPorts.get(0)], #[])

		new LajerThread(operation.inputPorts.get(0), #[2]).run()
		Assert.assertEquals(32, saver.number)
	}

	/**
	 *            /--> saver1
	 * doubler >--
	 *            \--> saver2
	 */
	@Test
	def void testBranchingOperation() {
		val doubler = new Doubler()
		val saver1 = new Saver()
		val saver2 = new Saver()

		doubler.outputPorts.get(0).connectTo(saver1.inputPorts.get(0))
		doubler.outputPorts.get(0).connectTo(saver2.inputPorts.get(0))

		val operation = new Operation("", #[doubler, saver1, saver2], #[doubler.inputPorts.get(0)], #[])

		new LajerThread(operation.inputPorts.get(0), #[2]).run()
		Thread.sleep(1000)
		Assert.assertEquals(4, saver1.number)
		Assert.assertEquals(4, saver2.number)
	}

	/**                              /--> saver1
	 *            /--> quadrupler >--
	 * doubler >--                   \--> saver2
	 *            \--> saver3
	 */
	@Test
	def void testIncorporationBranchingOperation() {
		val saver1 = new Saver()
		val saver2 = new Saver()
		val saver3 = new Saver()

		val operation1 = {
			val quadrupler = new Quadrupler()
			
			quadrupler.outputPorts.get(0).connectTo(saver1.inputPorts.get(0))
			quadrupler.outputPorts.get(0).connectTo(saver2.inputPorts.get(0))
			
			new Operation("", #[quadrupler, saver1, saver2], #[quadrupler.inputPorts.get(0)], #[])
		}

		val operation2 = {
			val doubler = new Doubler()
			
			doubler.outputPorts.get(0).connectTo(operation1.inputPorts.get(0))
			doubler.outputPorts.get(0).connectTo(saver3.inputPorts.get(0))
			
			new Operation("", #[doubler, operation1], #[doubler.inputPorts.get(0)], #[])
		}

		new LajerThread(operation2.inputPorts.get(0), #[2]).run()
		Thread.sleep(1000)
		Assert.assertEquals(16, saver1.number)
		Assert.assertEquals(16, saver2.number)
		Assert.assertEquals(4, saver3.number)
	}

	static class Doubler extends Component {

		def int doubler(int number) {
			return number * 2
		}

		override getPorts() {
			return #[new MethodPort(this, MethodHandles.lookup.bind(this, "doubler", MethodType.methodType(int, int)))]
		}

	}

	static class Quadrupler extends Component {

		def int quadrupler(int number) {
			return number * 4
		}

		override getPorts() {
			return #[new MethodPort(this, MethodHandles.lookup.bind(this, "quadrupler", MethodType.methodType(int, int)))]
		}

	}

	static class Saver extends Component {

		var int number = -1

		def void save(int number) {
			this.number = number
		}

		override getPorts() {
			return #[new MethodPort(this, MethodHandles.lookup.bind(this, "save", MethodType.methodType(void, int)))]
		}

	}

}
