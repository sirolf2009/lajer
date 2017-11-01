package com.sirolf2009.lajer.core.operation

import com.sirolf2009.lajer.core.Port
import com.sirolf2009.lajer.core.component.Component
import com.sirolf2009.lajer.core.operation.model.Operation
import java.lang.invoke.MethodHandles
import java.lang.invoke.MethodType
import java.util.Scanner
import javax.swing.JOptionPane
import org.junit.Test

import static extension com.sirolf2009.lajer.core.operation.model.Connection.*

class TestCalculator {

	@Test
	def void test() {
		val summer = new Summer()
		val subtractor = new Subtractor()
		val input = new UserInput()
		val displayer = new Displayer()
		
		input.outputPorts.get(0).connectTo(summer.inputPorts.get(0))
		input.outputPorts.get(0).connectTo(subtractor.inputPorts.get(0))
		summer.outputPorts.get(0).connectTo(displayer.inputPorts.get(0))
		subtractor.outputPorts.get(0).connectTo(displayer.inputPorts.get(0))
		
		val calculator = new Operation(#[input, summer, subtractor, displayer], #[input.inputPorts.get(0)], #[])
		
		new LajerThread(calculator.inputPorts.get(0), #[]).start()
		Thread.sleep(10000)
	}

	// Component
	static class Summer extends Component {

		// method, imagine equation is 2+2
		def int calculate(String equation) {
			val a = Integer.parseInt(equation.split("\\+").get(0))
			val b = Integer.parseInt(equation.split("\\+").get(1))
			return add(a, b)
		}

		// method
		def private int add(int a, int b) {
			return a + b
		}
		
		override getPorts() {
			return #[new Port(this, MethodHandles.lookup.bind(this, "calculate", MethodType.methodType(int, String)))]
		}

	}

	// Component
	static class Subtractor extends Component {

		// method, imagine equation is 2+2
		def int calculate(String equation) {
			val a = Integer.parseInt(equation.split("\\-").get(0))
			val b = Integer.parseInt(equation.split("\\-").get(1))
			return subtract(a, b)
		}

		// method
		def private int subtract(int a, int b) {
			return a - b
		}
		
		override getPorts() {
			return #[new Port(this, MethodHandles.lookup.bind(this, "calculate", MethodType.methodType(int, String)))]
		}

	}

	// Component
	static class UserInput extends Component {

		// Method
		def String readUserInput() {
			println("Please enter an equation:")
			val scanner = new Scanner(System.in)
			return scanner.next()
		}
		
		override getPorts() {
			return #[new Port(this, MethodHandles.lookup.bind(this, "readUserInput", MethodType.methodType(String)))]
		}

	}

	// Component
	static class Displayer extends Component {

		// method, returns void so cannot be connected to another component
		def void display(int result) {
			JOptionPane.showMessageDialog(null, "Your result is: " + result)
		}
		
		override getPorts() {
			return #[new Port(this, MethodHandles.lookup.bind(this, "display", MethodType.methodType(void, int)))]
		}

	}

}
