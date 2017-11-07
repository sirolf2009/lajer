package com.sirolf2009.lajer.plugin.lajer.command;

import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.operation.LajerThread;
import com.sirolf2009.lajer.plugin.figure.InputFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import java.util.Collections;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Extension;

@SuppressWarnings("all")
public class LajerCommandActivateSelected extends LajerCommand {
  @Override
  public void accept(@Extension final LajerManager manager) {
    if (((manager.getFocused() != null) && (manager.getFocused() instanceof InputFigure))) {
      Port _port = manager.getFocused().getPort();
      new LajerThread(_port, Collections.<Object>unmodifiableList(CollectionLiterals.<Object>newArrayList())).start();
    }
  }
  
  @Override
  public String name() {
    return "activate-selected";
  }
  
  @Override
  public String author() {
    return "sirolf2009";
  }
}
