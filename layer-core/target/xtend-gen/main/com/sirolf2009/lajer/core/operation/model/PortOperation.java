package com.sirolf2009.lajer.core.operation.model;

import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.operation.model.Operation;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class PortOperation extends Port {
  private final Operation operation;
  
  private final Port input;
  
  @Override
  public Object accept(final Object... args) {
    return this.input.accept(args);
  }
  
  public PortOperation(final Operation operation, final Port input) {
    super();
    this.operation = operation;
    this.input = input;
  }
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((this.operation== null) ? 0 : this.operation.hashCode());
    result = prime * result + ((this.input== null) ? 0 : this.input.hashCode());
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
    PortOperation other = (PortOperation) obj;
    if (this.operation == null) {
      if (other.operation != null)
        return false;
    } else if (!this.operation.equals(other.operation))
      return false;
    if (this.input == null) {
      if (other.input != null)
        return false;
    } else if (!this.input.equals(other.input))
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
  public Operation getOperation() {
    return this.operation;
  }
  
  @Pure
  public Port getInput() {
    return this.input;
  }
}
