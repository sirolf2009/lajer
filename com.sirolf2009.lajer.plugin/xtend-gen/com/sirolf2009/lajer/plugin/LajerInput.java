package com.sirolf2009.lajer.plugin;

import java.io.File;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IPersistableElement;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class LajerInput implements IEditorInput {
  private final File file;
  
  @Override
  public boolean exists() {
    return this.file.exists();
  }
  
  @Override
  public ImageDescriptor getImageDescriptor() {
    return null;
  }
  
  @Override
  public String getName() {
    return this.file.getName();
  }
  
  @Override
  public IPersistableElement getPersistable() {
    return null;
  }
  
  @Override
  public String getToolTipText() {
    return "tooltip";
  }
  
  @Override
  public <T extends Object> T getAdapter(final Class<T> adapter) {
    return null;
  }
  
  public LajerInput(final File file) {
    super();
    this.file = file;
  }
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((this.file== null) ? 0 : this.file.hashCode());
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
    LajerInput other = (LajerInput) obj;
    if (this.file == null) {
      if (other.file != null)
        return false;
    } else if (!this.file.equals(other.file))
      return false;
    return true;
  }
  
  @Override
  @Pure
  public String toString() {
    ToStringBuilder b = new ToStringBuilder(this);
    b.add("file", this.file);
    return b.toString();
  }
  
  @Pure
  public File getFile() {
    return this.file;
  }
}
