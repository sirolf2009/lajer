package com.sirolf2009.lajer.plugin;

import com.sirolf2009.lajer.core.LajerCompiler;
import com.sirolf2009.lajer.plugin.ExampleComponents;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.Collections;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.LightweightSystem;
import org.eclipse.draw2d.XYLayout;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IEditorSite;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.part.EditorPart;
import org.eclipse.ui.part.FileEditorInput;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class LajerEditor extends EditorPart {
  private LajerManager manager;
  
  @Override
  public void init(final IEditorSite site, final IEditorInput input) throws PartInitException {
    this.setSite(site);
    if ((input instanceof FileEditorInput)) {
      this.setInput(input);
    } else {
      throw new IllegalArgumentException(("Invalid input " + input));
    }
  }
  
  @Override
  public void createPartControl(final Composite parent) {
    Canvas _canvas = new Canvas(parent, SWT.BORDER);
    final Procedure1<Canvas> _function = (Canvas it) -> {
      final LightweightSystem lws = new LightweightSystem(it);
      final Figure contents = new Figure();
      final XYLayout contentsLayout = new XYLayout();
      contents.setLayoutManager(contentsLayout);
      LajerManager _lajerManager = new LajerManager(it, contentsLayout, contents, this);
      this.manager = _lajerManager;
      it.addKeyListener(this.manager);
      ExampleComponents.UserInput _userInput = new ExampleComponents.UserInput();
      this.manager.add(_userInput);
      ExampleComponents.EquationChecker _equationChecker = new ExampleComponents.EquationChecker();
      this.manager.add(_equationChecker);
      ExampleComponents.Summer _summer = new ExampleComponents.Summer();
      this.manager.add(_summer);
      ExampleComponents.Subtractor _subtractor = new ExampleComponents.Subtractor();
      this.manager.add(_subtractor);
      ExampleComponents.Displayer _displayer = new ExampleComponents.Displayer();
      this.manager.add(_displayer);
      lws.setContents(contents);
    };
    ObjectExtensions.<Canvas>operator_doubleArrow(_canvas, _function);
  }
  
  @Override
  public void setFocus() {
  }
  
  @Override
  public void doSave(final IProgressMonitor monitor) {
    try {
      monitor.beginTask("Saving", 1);
      final String generated = LajerCompiler.compile("com.sirolf2009", this.manager.asOperation());
      Files.write(Paths.get(this.getEditorInput().getPath().toString().replace(".lajer", ".java")), Collections.<CharSequence>unmodifiableList(CollectionLiterals.<CharSequence>newArrayList(generated)), StandardOpenOption.CREATE);
      monitor.done();
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  @Override
  public void doSaveAs() {
  }
  
  @Override
  public boolean isDirty() {
    return true;
  }
  
  @Override
  public boolean isSaveAsAllowed() {
    return true;
  }
  
  @Override
  public FileEditorInput getEditorInput() {
    IEditorInput _editorInput = super.getEditorInput();
    return ((FileEditorInput) _editorInput);
  }
}
