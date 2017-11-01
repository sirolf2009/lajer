package com.sirolf2009.lajer.ide

import com.sirolf2009.lajer.core.Port
import com.sirolf2009.lajer.core.component.Component
import com.sirolf2009.lajer.ide.lajer.LajerLayout
import com.sirolf2009.lajer.ide.lajer.LajerLayout.LajerLayoutData
import com.sirolf2009.lajer.ide.model.RenderedNode
import java.lang.invoke.MethodHandles
import java.lang.invoke.MethodType
import java.util.Optional
import java.util.Scanner
import javax.swing.JOptionPane
import org.eclipse.swt.SWT
import org.eclipse.swt.widgets.Composite

class LajerEditor extends Composite {
	
	new(Composite parent) {
		super(parent, SWT.BORDER)
		layout = new LajerLayout()
		new RenderedNode(this, new UserInput(), Optional.empty())
		new RenderedNode(this, new UserInput(), Optional.empty()) => [
			layoutData = new LajerLayoutData(300, 300)
		]
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