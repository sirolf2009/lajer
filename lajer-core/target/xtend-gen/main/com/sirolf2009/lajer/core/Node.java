package com.sirolf2009.lajer.core;

import com.sirolf2009.lajer.core.Port;
import java.util.List;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.IterableExtensions;

@SuppressWarnings("all")
public abstract class Node {
  public abstract List<Port> getInputPorts();
  
  public abstract List<Port> getOutputPorts();
  
  public abstract String getFullyQualifiedName();
  
  public String getName() {
    return IterableExtensions.<String>last(((Iterable<String>)Conversions.doWrapArray(this.getFullyQualifiedName().split("\\."))));
  }
}
