package com.sirolf2009.lajer.plugin.figure;

import com.sirolf2009.lajer.core.Node;
import com.sirolf2009.lajer.plugin.figure.InputFigure;
import com.sirolf2009.lajer.plugin.figure.OutputFigure;
import java.util.List;

@SuppressWarnings("all")
public interface INodeFigure {
  public abstract Node getNode();
  
  public abstract List<InputFigure> getInputFigures();
  
  public abstract List<OutputFigure> getOutputFigures();
}
