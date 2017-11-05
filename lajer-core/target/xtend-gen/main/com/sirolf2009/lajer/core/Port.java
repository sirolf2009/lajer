package com.sirolf2009.lajer.core;

import com.sirolf2009.lajer.core.Node;
import com.sirolf2009.lajer.core.operation.model.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public abstract class Port implements Function<List<Object>, Object> {
  @Accessors
  private final transient List<Connection> incomingConnections = new ArrayList<Connection>();
  
  @Accessors
  private final transient List<Connection> outgoingConnections = new ArrayList<Connection>();
  
  @Accessors
  private final transient Node component;
  
  public Port(final Node component) {
    super();
    this.component = component;
  }
  
  @Override
  @Pure
  public int hashCode() {
    int result = 1;
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
    return true;
  }
  
  @Override
  @Pure
  public String toString() {
    ToStringBuilder b = new ToStringBuilder(this);
    return b.toString();
  }
  
  @Pure
  public List<Connection> getIncomingConnections() {
    return this.incomingConnections;
  }
  
  @Pure
  public List<Connection> getOutgoingConnections() {
    return this.outgoingConnections;
  }
  
  @Pure
  public Node getComponent() {
    return this.component;
  }
}
