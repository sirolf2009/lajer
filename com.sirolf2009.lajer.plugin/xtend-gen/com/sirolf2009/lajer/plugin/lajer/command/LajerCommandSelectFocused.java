package com.sirolf2009.lajer.plugin.lajer.command;

import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import org.eclipse.xtext.xbase.lib.Extension;

@SuppressWarnings("all")
public class LajerCommandSelectFocused extends LajerCommand {
  @Override
  public void accept(@Extension final LajerManager manager) {
    PortFigure _focused = manager.getFocused();
    boolean _tripleNotEquals = (_focused != null);
    if (_tripleNotEquals) {
      boolean _isSelected = manager.getFocused().isSelected();
      if (_isSelected) {
        PortFigure _focused_1 = manager.getFocused();
        _focused_1.setSelected(false);
        manager.getSelected().remove(manager.getFocused());
      } else {
        PortFigure _focused_2 = manager.getFocused();
        _focused_2.setSelected(true);
        manager.getSelected().add(manager.getFocused());
      }
      manager.getFocused().repaint();
    }
  }
}
