package com.sirolf2009.lajer.core.operation;

import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.operation.model.Connection;
import com.sirolf2009.lajer.core.splitter.SplitterPort;
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
    final Runnable _function = new Runnable() {
      @Override
      public void run() {
        LajerThread.this.run();
      }
    };
    new Thread(_function).start();
  }
  
  public void run() {
    this.runPort(this.port, this.args);
  }
  
  public void runPort(final Port port, final List<Object> args) {
    if ((port instanceof SplitterPort)) {
      this.runSplitterPort(((SplitterPort)port), args);
    } else {
      Object _apply = port.apply(args);
      this.propagate(Collections.<Object>unmodifiableList(CollectionLiterals.<Object>newArrayList(_apply)), port.getOutgoingConnections());
    }
  }
  
  public void runSplitterPort(final SplitterPort port, final List<Object> args) {
    final Boolean result = port.apply(args);
    if ((result).booleanValue()) {
      this.propagate(args, port.getComponent().getTruePort().getOutgoingConnections());
    } else {
      this.propagate(args, port.getComponent().getFalsePort().getOutgoingConnections());
    }
  }
  
  public void propagate(final List<Object> args, final List<Connection> connections) {
    int _size = connections.size();
    boolean _equals = (_size == 1);
    if (_equals) {
      this.runPort(connections.get(0).getTo(), args);
    } else {
      int _size_1 = connections.size();
      boolean _greaterThan = (_size_1 > 1);
      if (_greaterThan) {
        int _size_2 = connections.size();
        final Consumer<Integer> _function = new Consumer<Integer>() {
          @Override
          public void accept(final Integer it) {
            final Runnable _function = new Runnable() {
              @Override
              public void run() {
                Port _from = connections.get((it).intValue()).getFrom();
                new LajerThread(_from, args).runPort(connections.get((it).intValue()).getTo(), args);
              }
            };
            new Thread(_function).start();
          }
        };
        new ExclusiveRange(1, _size_2, true).forEach(_function);
        this.runPort(connections.get(0).getTo(), args);
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
