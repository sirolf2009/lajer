package com.sirolf2009.lajer.core.component;

import com.sirolf2009.lajer.core.Node;
import com.sirolf2009.lajer.core.Port;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public abstract class Component extends Node {
  private final List<Port> ports = this.getPorts();
  
  protected abstract List<Port> getPorts();
  
  @Override
  public List<Port> getInputPorts() {
    return this.ports;
  }
  
  @Override
  public List<Port> getOutputPorts() {
    return this.ports;
  }
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((this.ports== null) ? 0 : this.ports.hashCode());
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
    Component other = (Component) obj;
    if (this.ports == null) {
      if (other.ports != null)
        return false;
    } else if (!this.ports.equals(other.ports))
      return false;
    return true;
  }
  
  @Override
  @Pure
  public String toString() {
    String result = new ToStringBuilder(this)
    	.addAllFields()
    	.toString();
    return result;
  }
}
