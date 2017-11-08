package com.sirolf2009.lajer.plugin.figure;

import com.sirolf2009.lajer.core.model.NodeModel;
import com.sirolf2009.lajer.plugin.figure.InputFigure;
import com.sirolf2009.lajer.plugin.figure.OutputFigure;
import java.util.List;

@SuppressWarnings("all")
public interface INodeFigure {
  public abstract NodeModel getNode();
  
  public abstract List<InputFigure> getInputFigures();
  
  public abstract List<OutputFigure> getOutputFigures();
}
