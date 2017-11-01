package com.sirolf2009.lajer.core.operation.model;

import com.sirolf2009.lajer.core.Node;
import com.sirolf2009.lajer.core.Port;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class Connection {
  private final Port from;
  
  private final Port to;
  
  public static Connection operator_mappedTo(final Node from, final Node to) {
    return Connection.connectTo(from, to);
  }
  
  public static Connection connectTo(final Node from, final Node to) {
    return Connection.connectTo(from.getOutputPorts().get(0), to.getInputPorts().get(0));
  }
  
  public static Connection operator_mappedTo(final Port from, final Port to) {
    return Connection.connectTo(from, to);
  }
  
  public static Connection connectTo(final Port from, final Port to) {
    final Connection connection = new Connection(from, to);
    List<Connection> _outgoingConnections = from.getOutgoingConnections();
    _outgoingConnections.add(connection);
    List<Connection> _incomingConnections = to.getIncomingConnections();
    _incomingConnections.add(connection);
    return connection;
  }
  
  public Connection(final Port from, final Port to) {
    super();
    this.from = from;
    this.to = to;
  }
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((this.from== null) ? 0 : this.from.hashCode());
    result = prime * result + ((this.to== null) ? 0 : this.to.hashCode());
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
    Connection other = (Connection) obj;
    if (this.from == null) {
      if (other.from != null)
        return false;
    } else if (!this.from.equals(other.from))
      return false;
    if (this.to == null) {
      if (other.to != null)
        return false;
    } else if (!this.to.equals(other.to))
      return false;
    return true;
  }
  
  @Override
  @Pure
  public String toString() {
    ToStringBuilder b = new ToStringBuilder(this);
    b.add("from", this.from);
    b.add("to", this.to);
    return b.toString();
  }
  
  @Pure
  public Port getFrom() {
    return this.from;
  }
  
  @Pure
  public Port getTo() {
    return this.to;
  }
}
