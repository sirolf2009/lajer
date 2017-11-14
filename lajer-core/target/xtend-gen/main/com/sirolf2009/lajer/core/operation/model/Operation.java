package com.sirolf2009.lajer.core.operation.model;

import com.sirolf2009.lajer.core.Node;
import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.operation.model.Connection;
import java.util.List;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class Operation extends Node {
  private final String fullyQualifiedName;
  
  private final List<Node> components;
  
  private final List<Port> inputPorts;
  
  private final List<Port> outputPorts;
  
  public Set<Connection> getConnections() {
    final Function<Node, Stream<Connection>> _function = new Function<Node, Stream<Connection>>() {
      @Override
      public Stream<Connection> apply(final Node it) {
        final Function<Port, Stream<Connection>> _function = new Function<Port, Stream<Connection>>() {
          @Override
          public Stream<Connection> apply(final Port it) {
            return it.getIncomingConnections().stream();
          }
        };
        final Function<Port, Stream<Connection>> _function_1 = new Function<Port, Stream<Connection>>() {
          @Override
          public Stream<Connection> apply(final Port it) {
            return it.getOutgoingConnections().stream();
          }
        };
        return Stream.<Connection>concat(it.getInputPorts().stream().<Connection>flatMap(_function), it.getOutputPorts().stream().<Connection>flatMap(_function_1));
      }
    };
    return this.components.stream().<Connection>flatMap(_function).collect(Collectors.<Connection>toSet());
  }
  
  public Operation(final String fullyQualifiedName, final List<Node> components, final List<Port> inputPorts, final List<Port> outputPorts) {
    super();
    this.fullyQualifiedName = fullyQualifiedName;
    this.components = components;
    this.inputPorts = inputPorts;
    this.outputPorts = outputPorts;
  }
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((this.fullyQualifiedName== null) ? 0 : this.fullyQualifiedName.hashCode());
    result = prime * result + ((this.components== null) ? 0 : this.components.hashCode());
    result = prime * result + ((this.inputPorts== null) ? 0 : this.inputPorts.hashCode());
    result = prime * result + ((this.outputPorts== null) ? 0 : this.outputPorts.hashCode());
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
    if (this.fullyQualifiedName == null) {
      if (other.fullyQualifiedName != null)
        return false;
    } else if (!this.fullyQualifiedName.equals(other.fullyQualifiedName))
      return false;
    if (this.components == null) {
      if (other.components != null)
        return false;
    } else if (!this.components.equals(other.components))
      return false;
    if (this.inputPorts == null) {
      if (other.inputPorts != null)
        return false;
    } else if (!this.inputPorts.equals(other.inputPorts))
      return false;
    if (this.outputPorts == null) {
      if (other.outputPorts != null)
        return false;
    } else if (!this.outputPorts.equals(other.outputPorts))
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
  public String getFullyQualifiedName() {
    return this.fullyQualifiedName;
  }
  
  @Pure
  public List<Node> getComponents() {
    return this.components;
  }
  
  @Pure
  public List<Port> getInputPorts() {
    return this.inputPorts;
  }
  
  @Pure
  public List<Port> getOutputPorts() {
    return this.outputPorts;
  }
}
