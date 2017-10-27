package com.sirolf2009.lajer.core.operation.model;

import com.sirolf2009.lajer.core.Port;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class Connection {
  private final Class<?> dataType;
  
  private final Port from;
  
  private final Port to;
  
  public Connection(final Class<?> dataType, final Port from, final Port to) {
    super();
    this.dataType = dataType;
    this.from = from;
    this.to = to;
  }
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((this.dataType== null) ? 0 : this.dataType.hashCode());
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
    if (this.dataType == null) {
      if (other.dataType != null)
        return false;
    } else if (!this.dataType.equals(other.dataType))
      return false;
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
    b.add("dataType", this.dataType);
    b.add("from", this.from);
    b.add("to", this.to);
    return b.toString();
  }
  
  @Pure
  public Class<?> getDataType() {
    return this.dataType;
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
