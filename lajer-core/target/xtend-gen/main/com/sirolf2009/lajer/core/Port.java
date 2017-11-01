package com.sirolf2009.lajer.core;

import com.sirolf2009.lajer.core.component.Component;
import com.sirolf2009.lajer.core.operation.model.Connection;
import java.lang.invoke.MethodHandle;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class Port implements Function<List<Object>, Object> {
  private final Component component;
  
  private final MethodHandle handle;
  
  private final List<Connection> incomingConnections = new ArrayList<Connection>();
  
  private final List<Connection> outgoingConnections = new ArrayList<Connection>();
  
  @Override
  public Object apply(final List<Object> args) {
    try {
      return this.handle.invokeWithArguments(args);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public Port(final Component component, final MethodHandle handle) {
    super();
    this.component = component;
    this.handle = handle;
  }
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((this.component== null) ? 0 : this.component.hashCode());
    result = prime * result + ((this.handle== null) ? 0 : this.handle.hashCode());
    result = prime * result + ((this.incomingConnections== null) ? 0 : this.incomingConnections.hashCode());
    result = prime * result + ((this.outgoingConnections== null) ? 0 : this.outgoingConnections.hashCode());
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
    Port other = (Port) obj;
    if (this.component == null) {
      if (other.component != null)
        return false;
    } else if (!this.component.equals(other.component))
      return false;
    if (this.handle == null) {
      if (other.handle != null)
        return false;
    } else if (!this.handle.equals(other.handle))
      return false;
    if (this.incomingConnections == null) {
      if (other.incomingConnections != null)
        return false;
    } else if (!this.incomingConnections.equals(other.incomingConnections))
      return false;
    if (this.outgoingConnections == null) {
      if (other.outgoingConnections != null)
        return false;
    } else if (!this.outgoingConnections.equals(other.outgoingConnections))
      return false;
    return true;
  }
  
  @Override
  @Pure
  public String toString() {
    ToStringBuilder b = new ToStringBuilder(this);
    b.add("component", this.component);
    b.add("handle", this.handle);
    b.add("incomingConnections", this.incomingConnections);
    b.add("outgoingConnections", this.outgoingConnections);
    return b.toString();
  }
  
  @Pure
  public Component getComponent() {
    return this.component;
  }
  
  @Pure
  public MethodHandle getHandle() {
    return this.handle;
  }
  
  @Pure
  public List<Connection> getIncomingConnections() {
    return this.incomingConnections;
  }
  
  @Pure
  public List<Connection> getOutgoingConnections() {
    return this.outgoingConnections;
  }
}
