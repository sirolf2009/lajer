package com.sirolf2009.lajer.core.operation

import com.sirolf2009.lajer.core.annotation.Expose
import com.sirolf2009.lajer.core.component.Component
import com.sirolf2009.lajer.core.operation.model.Operation
import com.sirolf2009.lajer.core.splitter.Splitter
import com.sirolf2009.lajer.core.splitter.SplitterPort
import java.lang.invoke.MethodHandles
import java.lang.invoke.MethodType
import java.util.Scanner
import javax.swing.JOptionPane

import static extension com.sirolf2009.lajer.core.operation.model.Connection.*
import com.sirolf2009.lajer.core.component.AdaptablePort
import com.sirolf2009.lajer.core.component.FunctionPort

class TestCalculator {
	
	def static getCalculator() {
		val summer = new Summer()
		val subtractor = new Subtractor()
		val input = new UserInput()
		val checker = new EquationChecker()
		val displayer = new Displayer()
		
		input -> checker
		checker.truePort -> summer
		checker.falsePort -> subtractor
		summer -> displayer
		subtractor -> displayer
		
		return new Operation("com.sirolf2009.lajer.Calculator", #[input, checker, summer, subtractor, displayer], #[input.inputPorts.get(0)], #[])
	}

	// Component
	static class Summer extends Component {

		// method, imagine equation is 2+2
		@Expose def int calculate(String equation) {
			val a = Integer.parseInt(equation.split("\\+").get(0))
			val b = Integer.parseInt(equation.split("\\+").get(1))
			return add(a, b)
		}

		// method
		def private int add(int a, int b) {
			return a + b
		}
		
		override getPorts() {
			return #[new AdaptablePort(#[String], new FunctionPort(this, MethodHandles.lookup.bind(this, "calculate", MethodType.methodType(int, String))))]
		}
		
	}

	// Component
	static class Subtractor extends Component {

		// method, imagine equation is 2-2
		@Expose def int calculate(String equation) {
			val a = Integer.parseInt(equation.split("\\-").get(0))
			val b = Integer.parseInt(equation.split("\\-").get(1))
			return subtract(a, b)
		}

		// method
		def private int subtract(int a, int b) {
			return a - b
		}
		
		override getPorts() {
			return #[new FunctionPort(this, MethodHandles.lookup.bind(this, "calculate", MethodType.methodType(int, String)))]
		}

	}

	// Component
	static class UserInput extends Component {

		// Method
		@Expose def String readUserInput() {
			println("Please enter an equation:")
			val scanner = new Scanner(System.in)
			return scanner.next()
		}
		
		override getPorts() {
			return #[new FunctionPort(this, MethodHandles.lookup.bind(this, "readUserInput", MethodType.methodType(String)))]
		}

	}

	// Splitter
	static class EquationChecker extends Splitter {

		// Method
		@Expose def Boolean check(String string) {
			return string.contains("+")
		}
		
		override getSplitterPort() {
			return new SplitterPort(this, MethodHandles.lookup.bind(this, "check", MethodType.methodType(Boolean, String)))
		}
		
	}

	// Component
	static class Displayer extends Component {

		// method, returns void so cannot be connected to another component
		@Expose def void display(int result) {
			JOptionPane.showMessageDialog(null, "Your result is: " + result)
		}
		
		override getPorts() {
			return #[new FunctionPort(this, MethodHandles.lookup.bind(this, "display", MethodType.methodType(void, int)))]
		}

	}

}
