package com.sirolf2009.lajer.plugin.lajer.command;

import com.sirolf2009.lajer.plugin.figure.OutputFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import org.eclipse.xtext.xbase.lib.Extension;

@SuppressWarnings("all")
public class LajerCommandMarkSelectedAsOutput extends LajerCommand {
  @Override
  public void accept(@Extension final LajerManager manager) {
    if (((manager.getFocused() != null) && manager.isOutput(manager.getFocused()))) {
      PortFigure _focused = manager.getFocused();
      manager.markAsOutput(((OutputFigure) _focused));
    }
  }
}
