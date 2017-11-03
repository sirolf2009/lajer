package com.sirolf2009.lajer.core;

import com.sirolf2009.lajer.core.component.Component;
import com.sirolf2009.lajer.core.operation.model.Connection;
import java.lang.invoke.MethodHandle;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class Port implements Function<List<Object>, Object> {
  @Accessors
  private final transient Component component;
  
  private final MethodHandle handle;
  
  @Accessors
  private final transient List<Connection> incomingConnections = new ArrayList<Connection>();
  
  @Accessors
  private final transient List<Connection> outgoingConnections = new ArrayList<Connection>();
  
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
    result = prime * result + ((this.handle== null) ? 0 : this.handle.hashCode());
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
    if (this.handle == null) {
      if (other.handle != null)
        return false;
    } else if (!this.handle.equals(other.handle))
      return false;
    return true;
  }
  
  @Override
  @Pure
  public String toString() {
    ToStringBuilder b = new ToStringBuilder(this);
    b.add("handle", this.handle);
    return b.toString();
  }
  
  @Pure
  public MethodHandle getHandle() {
    return this.handle;
  }
  
  @Pure
  public Component getComponent() {
    return this.component;
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
