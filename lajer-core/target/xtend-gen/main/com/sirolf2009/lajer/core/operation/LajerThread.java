package com.sirolf2009.lajer.core.operation;

import com.sirolf2009.lajer.core.Port;
import java.util.Collections;
import java.util.List;
import java.util.function.Consumer;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.ExclusiveRange;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class LajerThread {
  private final Port port;
  
  private final List<Object> args;
  
  public void start() {
    final Runnable _function = () -> {
      this.run();
    };
    new Thread(_function).start();
  }
  
  public void run() {
    this.runPort(this.port, this.args);
  }
  
  public void runPort(final Port port, final List<Object> args) {
    final Object result = port.apply(args);
    int _size = port.getOutgoingConnections().size();
    boolean _equals = (_size == 1);
    if (_equals) {
      this.runPort(port.getOutgoingConnections().get(0).getTo(), Collections.<Object>unmodifiableList(CollectionLiterals.<Object>newArrayList(result)));
    } else {
      int _size_1 = port.getOutgoingConnections().size();
      boolean _greaterThan = (_size_1 > 1);
      if (_greaterThan) {
        int _size_2 = port.getOutgoingConnections().size();
        final Consumer<Integer> _function = (Integer it) -> {
          final Runnable _function_1 = () -> {
            new LajerThread(port, args).runPort(port.getOutgoingConnections().get((it).intValue()).getTo(), Collections.<Object>unmodifiableList(CollectionLiterals.<Object>newArrayList(result)));
          };
          new Thread(_function_1).start();
        };
        new ExclusiveRange(1, _size_2, true).forEach(_function);
        this.runPort(port.getOutgoingConnections().get(0).getTo(), Collections.<Object>unmodifiableList(CollectionLiterals.<Object>newArrayList(result)));
      }
    }
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
