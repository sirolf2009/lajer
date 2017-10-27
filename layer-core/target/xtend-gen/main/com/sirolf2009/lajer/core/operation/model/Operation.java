package com.sirolf2009.lajer.core.operation.model;

import com.sirolf2009.lajer.core.Node;
import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.operation.model.Connection;
import com.sirolf2009.lajer.core.operation.model.PortOperation;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class Operation extends Node {
  private final List<Node> components;
  
  private final List<Port> componentPorts;
  
  private final List<Connection> connections;
  
  @Override
  public List<Port> getPorts() {
    final Function1<Port, Port> _function = (Port it) -> {
      PortOperation _portOperation = new PortOperation(this, it);
      return ((Port) _portOperation);
    };
    return IterableExtensions.<Port>toList(ListExtensions.<Port, Port>map(this.componentPorts, _function));
  }
  
  public Operation(final List<Node> components, final List<Port> componentPorts, final List<Connection> connections) {
    super();
    this.components = components;
    this.componentPorts = componentPorts;
    this.connections = connections;
  }
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((this.components== null) ? 0 : this.components.hashCode());
    result = prime * result + ((this.componentPorts== null) ? 0 : this.componentPorts.hashCode());
    result = prime * result + ((this.connections== null) ? 0 : this.connections.hashCode());
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
    Operation other = (Operation) obj;
    if (this.components == null) {
      if (other.components != null)
        return false;
    } else if (!this.components.equals(other.components))
      return false;
    if (this.componentPorts == null) {
      if (other.componentPorts != null)
        return false;
    } else if (!this.componentPorts.equals(other.componentPorts))
      return false;
    if (this.connections == null) {
      if (other.connections != null)
        return false;
    } else if (!this.connections.equals(other.connections))
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
  
  @Pure
  public List<Node> getComponents() {
    return this.components;
  }
  
  @Pure
  public List<Port> getComponentPorts() {
    return this.componentPorts;
  }
  
  @Pure
  public List<Connection> getConnections() {
    return this.connections;
  }
}
