package com.sirolf2009.lajer.core.operation;

import com.sirolf2009.lajer.core.Node;
import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.component.Component;
import com.sirolf2009.lajer.core.operation.LajerThread;
import com.sirolf2009.lajer.core.operation.model.Connection;
import com.sirolf2009.lajer.core.operation.model.Operation;
import com.sirolf2009.lajer.core.operation.model.PortComponent;
import java.lang.invoke.MethodHandle;
import java.lang.invoke.MethodHandles;
import java.lang.invoke.MethodType;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;
import javax.swing.JOptionPane;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
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
    
    private final List<Port> ports = new Function0<List<Port>>() {
      public List<Port> apply() {
        try {
          MethodHandle _bind = MethodHandles.lookup().bind(Summer.this, "calculate", MethodType.methodType(int.class, String.class));
          PortComponent _portComponent = new PortComponent(Summer.this, _bind);
          return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(((Port) _portComponent)));
        } catch (Throwable _e) {
          throw Exceptions.sneakyThrow(_e);
        }
      }
    }.apply();
    
    @Override
    public List<Port> getPorts() {
      return this.ports;
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
    
    private final List<Port> ports = new Function0<List<Port>>() {
      public List<Port> apply() {
        try {
          MethodHandle _bind = MethodHandles.lookup().bind(Subtractor.this, "calculate", MethodType.methodType(int.class, String.class));
          PortComponent _portComponent = new PortComponent(Subtractor.this, _bind);
          return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(((Port) _portComponent)));
        } catch (Throwable _e) {
          throw Exceptions.sneakyThrow(_e);
        }
      }
    }.apply();
    
    @Override
    public List<Port> getPorts() {
      return this.ports;
    }
  }
  
  public static class UserInput extends Component {
    public String readUserInput() {
      InputOutput.<String>println("Please enter an equation:");
      final Scanner scanner = new Scanner(System.in);
      return scanner.next();
    }
    
    private final List<Port> ports = new Function0<List<Port>>() {
      public List<Port> apply() {
        try {
          MethodHandle _bind = MethodHandles.lookup().bind(UserInput.this, "readUserInput", MethodType.methodType(String.class));
          PortComponent _portComponent = new PortComponent(UserInput.this, _bind);
          return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(((Port) _portComponent)));
        } catch (Throwable _e) {
          throw Exceptions.sneakyThrow(_e);
        }
      }
    }.apply();
    
    @Override
    public List<Port> getPorts() {
      return this.ports;
    }
  }
  
  public static class Displayer extends Component {
    public void display(final int result) {
      JOptionPane.showMessageDialog(null, ("Your result is: " + Integer.valueOf(result)));
    }
    
    private final List<Port> ports = new Function0<List<Port>>() {
      public List<Port> apply() {
        try {
          MethodHandle _bind = MethodHandles.lookup().bind(Displayer.this, "display", MethodType.methodType(void.class, int.class));
          PortComponent _portComponent = new PortComponent(Displayer.this, _bind);
          return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(((Port) _portComponent)));
        } catch (Throwable _e) {
          throw Exceptions.sneakyThrow(_e);
        }
      }
    }.apply();
    
    @Override
    public List<Port> getPorts() {
      return this.ports;
    }
  }
  
  @Test
  public void test() {
    try {
      final TestCalculator.Summer summer = new TestCalculator.Summer();
      final TestCalculator.Subtractor subtractor = new TestCalculator.Subtractor();
      final TestCalculator.UserInput input = new TestCalculator.UserInput();
      final TestCalculator.Displayer displayer = new TestCalculator.Displayer();
      Port _get = input.ports.get(0);
      Port _get_1 = input.ports.get(0);
      Port _get_2 = summer.ports.get(0);
      Connection _connection = new Connection(String.class, _get_1, _get_2);
      Port _get_3 = input.ports.get(0);
      Port _get_4 = subtractor.ports.get(0);
      Connection _connection_1 = new Connection(String.class, _get_3, _get_4);
      final Operation CPU = new Operation(Collections.<Node>unmodifiableList(CollectionLiterals.<Node>newArrayList(input, summer, subtractor)), Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(_get)), Collections.<Connection>unmodifiableList(CollectionLiterals.<Connection>newArrayList(_connection, _connection_1)));
      Port _get_5 = CPU.getPorts().get(0);
      Port _get_6 = CPU.getPorts().get(0);
      Port _get_7 = displayer.ports.get(0);
      Connection _connection_2 = new Connection(int.class, _get_6, _get_7);
      final Operation calculator = new Operation(Collections.<Node>unmodifiableList(CollectionLiterals.<Node>newArrayList(CPU, displayer)), Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(_get_5)), Collections.<Connection>unmodifiableList(CollectionLiterals.<Connection>newArrayList(_connection_2)));
      Port _get_8 = calculator.getPorts().get(0);
      new LajerThread(_get_8, Collections.<Object>unmodifiableList(CollectionLiterals.<Object>newArrayList())).start();
      Thread.sleep(10000);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
