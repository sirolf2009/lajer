package com.sirolf2009.lajer.core.operation

import com.sirolf2009.lajer.core.model.ComponentModel
import com.sirolf2009.lajer.core.model.ConnectionModel
import com.sirolf2009.lajer.core.model.OperationModel
import com.sirolf2009.lajer.core.model.PortModel
import com.sirolf2009.lajer.core.model.SplitterModel

class TestCalculatorModel {
	
	def static calculatorModel() {
		val input = new UserInput()
		val checker = new EquationChecker()
		val summer = new Summer()
		val subtractor = new Subtractor()
		val displayer = new Displayer()
		
		ConnectionModel.connectTo(input, checker)
		ConnectionModel.connectTo(checker.outputPorts.get(0), summer.inputPorts.get(0))
		ConnectionModel.connectTo(checker.outputPorts.get(1), subtractor.inputPorts.get(0))
		ConnectionModel.connectTo(summer, displayer)
		ConnectionModel.connectTo(subtractor, displayer)
		
		new OperationModel("com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator", #[input.inputPorts.get(0)], #[], #[input, checker, summer, subtractor, displayer])
	}

	static class Summer extends ComponentModel {

		new() {
			super("com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Summer", newArrayList(), newArrayList())
			inputPorts.add(new PortModel(this, newArrayList(), newArrayList()))
			outputPorts.add(new PortModel(this, newArrayList(), newArrayList()))
		}

	}

	static class Subtractor extends ComponentModel {

		new() {
			super("com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Subtractor", newArrayList(), newArrayList())
			inputPorts.add(new PortModel(this, newArrayList(), newArrayList()))
			outputPorts.add(new PortModel(this, newArrayList(), newArrayList()))
		}

	}

	static class UserInput extends ComponentModel {

		new() {
			super("com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Summer", newArrayList(), newArrayList())
			inputPorts.add(new PortModel(this, newArrayList(), newArrayList()))
			outputPorts.add(new PortModel(this, newArrayList(), newArrayList()))
		}

	}

	static class EquationChecker extends SplitterModel {

		new() {
			super("com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.EquationChecker", newArrayList(), newArrayList())
			inputPorts.add(new PortModel(this, newArrayList(), newArrayList()))
			outputPorts.add(new PortModel(this, newArrayList(), newArrayList()))
			outputPorts.add(new PortModel(this, newArrayList(), newArrayList()))
		}

	}

	static class Displayer extends ComponentModel {

		new() {
			super("com.sirolf2009.lajer.core.model.ComponentModel.TestCalculator.Displayer", newArrayList(), newArrayList())
			inputPorts.add(new PortModel(this, newArrayList(), newArrayList()))
			outputPorts.add(new PortModel(this, newArrayList(), newArrayList()))
		}

	}

}
