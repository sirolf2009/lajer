package com.sirolf2009.lajer.core.operation.model;

import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.component.Component;
import java.lang.invoke.MethodHandle;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class PortComponent extends Port {
  private final Component component;
  
  private final MethodHandle handle;
  
  @Override
  public Object accept(final Object... args) {
    try {
      return this.handle.invokeWithArguments(args);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public PortComponent(final Component component, final MethodHandle handle) {
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
    PortComponent other = (PortComponent) obj;
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
  public Component getComponent() {
    return this.component;
  }
  
  @Pure
  public MethodHandle getHandle() {
    return this.handle;
  }
}
