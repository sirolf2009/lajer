package com.sirolf2009.lajer.core.operation;

import com.sirolf2009.lajer.core.Node;
import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.component.Component;
import com.sirolf2009.lajer.core.operation.LajerThread;
import com.sirolf2009.lajer.core.operation.model.Connection;
import com.sirolf2009.lajer.core.operation.model.Operation;
import java.lang.invoke.MethodHandle;
import java.lang.invoke.MethodHandles;
import java.lang.invoke.MethodType;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;
import javax.swing.JOptionPane;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.InputOutput;
import org.junit.Test;

@SuppressWarnings("all")
public class TestCalculator {
  public static class Summer extends Component {
    public int calculate(final String equation) {
      final int a = Integer.parseInt(equation.split("\\+")[0]);
      final int b = Integer.parseInt(equation.split("\\+")[1]);
      return this.add(a, b);
    }
    
    private int add(final int a, final int b) {
      return (a + b);
    }
    
    @Override
    public List<Port> getPorts() {
      try {
        MethodHandle _bind = MethodHandles.lookup().bind(this, "calculate", MethodType.methodType(int.class, String.class));
        Port _port = new Port(this, _bind);
        return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(_port));
      } catch (Throwable _e) {
        throw Exceptions.sneakyThrow(_e);
      }
    }
  }
  
  public static class Subtractor extends Component {
    public int calculate(final String equation) {
      final int a = Integer.parseInt(equation.split("\\-")[0]);
      final int b = Integer.parseInt(equation.split("\\-")[1]);
      return this.subtract(a, b);
    }
    
    private int subtract(final int a, final int b) {
      return (a - b);
    }
    
    @Override
    public List<Port> getPorts() {
      try {
        MethodHandle _bind = MethodHandles.lookup().bind(this, "calculate", MethodType.methodType(int.class, String.class));
        Port _port = new Port(this, _bind);
        return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(_port));
      } catch (Throwable _e) {
        throw Exceptions.sneakyThrow(_e);
      }
    }
  }
  
  public static class UserInput extends Component {
    public String readUserInput() {
      InputOutput.<String>println("Please enter an equation:");
      final Scanner scanner = new Scanner(System.in);
      return scanner.next();
    }
    
    @Override
    public List<Port> getPorts() {
      try {
        MethodHandle _bind = MethodHandles.lookup().bind(this, "readUserInput", MethodType.methodType(String.class));
        Port _port = new Port(this, _bind);
        return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(_port));
      } catch (Throwable _e) {
        throw Exceptions.sneakyThrow(_e);
      }
    }
  }
  
  public static class Displayer extends Component {
    public void display(final int result) {
      JOptionPane.showMessageDialog(null, ("Your result is: " + Integer.valueOf(result)));
    }
    
    @Override
    public List<Port> getPorts() {
      try {
        MethodHandle _bind = MethodHandles.lookup().bind(this, "display", MethodType.methodType(void.class, int.class));
        Port _port = new Port(this, _bind);
        return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(_port));
      } catch (Throwable _e) {
        throw Exceptions.sneakyThrow(_e);
      }
    }
  }
  
  @Test
  public void test() {
    try {
      final TestCalculator.Summer summer = new TestCalculator.Summer();
      final TestCalculator.Subtractor subtractor = new TestCalculator.Subtractor();
      final TestCalculator.UserInput input = new TestCalculator.UserInput();
      final TestCalculator.Displayer displayer = new TestCalculator.Displayer();
      Connection.connectTo(input.getOutputPorts().get(0), summer.getInputPorts().get(0));
      Connection.connectTo(input.getOutputPorts().get(0), subtractor.getInputPorts().get(0));
      Connection.connectTo(summer.getOutputPorts().get(0), displayer.getInputPorts().get(0));
      Connection.connectTo(subtractor.getOutputPorts().get(0), displayer.getInputPorts().get(0));
      Port _get = input.getInputPorts().get(0);
      final Operation calculator = new Operation(Collections.<Node>unmodifiableList(CollectionLiterals.<Node>newArrayList(input, summer, subtractor, displayer)), Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(_get)), Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList()));
      Port _get_1 = calculator.getInputPorts().get(0);
      new LajerThread(_get_1, Collections.<Object>unmodifiableList(CollectionLiterals.<Object>newArrayList())).start();
      Thread.sleep(10000);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
