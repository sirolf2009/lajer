package com.sirolf2009.lajer.plugin;

import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.component.Component;
import com.sirolf2009.lajer.core.component.MethodPort;
import com.sirolf2009.lajer.core.splitter.Splitter;
import com.sirolf2009.lajer.core.splitter.SplitterPort;
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

@SuppressWarnings("all")
public class ExampleComponents {
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
        MethodPort _methodPort = new MethodPort(this, _bind);
        return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(_methodPort));
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
        MethodPort _methodPort = new MethodPort(this, _bind);
        return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(_methodPort));
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
        MethodPort _methodPort = new MethodPort(this, _bind);
        return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(_methodPort));
      } catch (Throwable _e) {
        throw Exceptions.sneakyThrow(_e);
      }
    }
  }
  
  public static class EquationChecker extends Splitter {
    public Boolean check(final String string) {
      return Boolean.valueOf(string.contains("+"));
    }
    
    @Override
    public SplitterPort getSplitterPort() {
      try {
        MethodHandle _bind = MethodHandles.lookup().bind(this, "check", MethodType.methodType(Boolean.class, String.class));
        return new SplitterPort(this, _bind);
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
        MethodPort _methodPort = new MethodPort(this, _bind);
        return Collections.<Port>unmodifiableList(CollectionLiterals.<Port>newArrayList(_methodPort));
      } catch (Throwable _e) {
        throw Exceptions.sneakyThrow(_e);
      }
    }
  }
}
