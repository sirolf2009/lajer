package com.sirolf2009.lajer.core.operation;

import com.google.common.base.Objects;
import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.operation.model.Connection;
import com.sirolf2009.lajer.core.operation.model.PortComponent;
import com.sirolf2009.lajer.core.operation.model.PortOperation;
import java.util.List;
import java.util.function.Consumer;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.ExclusiveRange;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class LajerThread {
  private final Port port;
  
  private final List<Object> args;
  
  public void start() {
    final Runnable _function = () -> {
      this.runPort(this.port, this.args);
    };
    new Thread(_function).start();
  }
  
  public Object runPort(final Port port, final Object... args) {
    if ((port instanceof PortComponent)) {
      return this.activateComponent(((PortComponent)port), args);
    } else {
      if ((port instanceof PortOperation)) {
        return this.runOperation(((PortOperation)port), ((PortOperation)port).getInput(), args);
      }
    }
    return null;
  }
  
  public Object runOperation(final PortOperation operationPort, final Object... args) {
    final Object result = this.operationStep(operationPort, operationPort.getInput(), args);
    return result;
  }
  
  public Object operationStep(final PortOperation operationPort, final Port port, final Object... args) {
    final Function1<Connection, Boolean> _function = (Connection it) -> {
      Port _from = it.getFrom();
      return Boolean.valueOf(Objects.equal(_from, port));
    };
    final List<Connection> next = IterableExtensions.<Connection>toList(IterableExtensions.<Connection>filter(operationPort.getOperation().getConnections(), _function));
    final Object result = this.runPort(port, args);
    if (((next == null) || (next.size() == 0))) {
      return result;
    } else {
      int _size = next.size();
      boolean _equals = (_size == 1);
      if (_equals) {
        return this.operationStep(operationPort, next.get(0).getTo(), result);
      } else {
        int _size_1 = next.size();
        final Consumer<Integer> _function_1 = (Integer it) -> {
          new LajerThread(port, (List<Object>)Conversions.doWrapArray(args)).operationStep(operationPort, next.get((it).intValue()).getTo(), result);
        };
        new ExclusiveRange(1, _size_1, true).forEach(_function_1);
        return this.operationStep(operationPort, next.get(0).getTo(), result);
      }
    }
  }
  
  public Object activateComponent(final PortComponent component, final Object... args) {
    return component.accept(args);
  }
  
  public LajerThread(final Port port, final List<Object> args) {
    super();
    this.port = port;
    this.args = args;
  }
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((this.port== null) ? 0 : this.port.hashCode());
    result = prime * result + ((this.args== null) ? 0 : this.args.hashCode());
    return result;
  }
  
  @Override
  @Pure
  public boolean equals(final Object obj) {
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    if (getClass() != obj.getClass())
      return false;
    LajerThread other = (LajerThread) obj;
    if (this.port == null) {
      if (other.port != null)
        return false;
    } else if (!this.port.equals(other.port))
      return false;
    if (this.args == null) {
      if (other.args != null)
        return false;
    } else if (!this.args.equals(other.args))
      return false;
    return true;
  }
  
  @Override
  @Pure
  public String toString() {
    ToStringBuilder b = new ToStringBuilder(this);
    b.add("port", this.port);
    b.add("args", this.args);
    return b.toString();
  }
  
  @Pure
  public Port getPort() {
    return this.port;
  }
  
  @Pure
  public List<Object> getArgs() {
    return this.args;
  }
}
