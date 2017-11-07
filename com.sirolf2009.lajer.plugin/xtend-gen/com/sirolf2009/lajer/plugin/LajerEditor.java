package com.sirolf2009.lajer.plugin;

import com.sirolf2009.lajer.core.LajerCompiler;
import com.sirolf2009.lajer.plugin.ExampleComponents;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.Collections;
import java.util.List;
import java.util.function.Consumer;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.Path;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.LightweightSystem;
import org.eclipse.draw2d.XYLayout;
import org.eclipse.jdt.core.IJavaElement;
import org.eclipse.jdt.core.IJavaProject;
import org.eclipse.jdt.core.IType;
import org.eclipse.jdt.core.JavaCore;
import org.eclipse.jdt.internal.core.PackageFragment;
import org.eclipse.swt.SWT;
import org.eclipse.swt.dnd.DND;
import org.eclipse.swt.dnd.DropTarget;
import org.eclipse.swt.dnd.DropTargetEvent;
import org.eclipse.swt.dnd.DropTargetListener;
import org.eclipse.swt.dnd.FileTransfer;
import org.eclipse.swt.dnd.Transfer;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IEditorSite;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.part.EditorPart;
import org.eclipse.ui.part.FileEditorInput;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.InputOutput;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class LajerEditor extends EditorPart {
  private LajerManager manager;
  
  private Canvas canvas;
  
  private boolean dirty = false;
  
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
    Canvas _canvas = new Canvas(parent, SWT.NONE);
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
      final DropTarget target = new DropTarget(it, DND.DROP_NONE);
      FileTransfer _instance = FileTransfer.getInstance();
      target.setTransfer(new Transfer[] { _instance });
      target.addDropListener(new DropTargetListener() {
        @Override
        public void dragEnter(final DropTargetEvent arg0) {
        }
        
        @Override
        public void dragLeave(final DropTargetEvent arg0) {
        }
        
        @Override
        public void dragOperationChanged(final DropTargetEvent arg0) {
        }
        
        @Override
        public void dragOver(final DropTargetEvent arg0) {
        }
        
        @Override
        public void drop(final DropTargetEvent event) {
          final String[] files = ((String[]) event.data);
          final Consumer<String> _function = (String it_1) -> {
            try {
              final IFile file = ResourcesPlugin.getWorkspace().getRoot().getFileForLocation(Path.fromPortableString(it_1));
              final IJavaElement javaFile = JavaCore.create(file);
              final IJavaProject project = JavaCore.create(file.getProject());
              IJavaElement _parent = javaFile.getParent();
              final PackageFragment package_ = ((PackageFragment) _parent);
              String _join = IterableExtensions.join(((Iterable<?>)Conversions.doWrapArray(package_.names)), ".");
              String _plus = (_join + ".");
              String _replace = javaFile.getElementName().replace(".java", "");
              String _plus_1 = (_plus + _replace);
              final IType type = project.findType(_plus_1);
              InputOutput.<String>println(IterableExtensions.join(((Iterable<?>)Conversions.doWrapArray(type.getMethods())), "\n"));
            } catch (Throwable _e) {
              throw Exceptions.sneakyThrow(_e);
            }
          };
          ((List<String>)Conversions.doWrapArray(files)).forEach(_function);
        }
        
        @Override
        public void dropAccept(final DropTargetEvent arg0) {
        }
      });
    };
    ObjectExtensions.<Canvas>operator_doubleArrow(_canvas, _function);
  }
  
  @Override
  public void setFocus() {
    if (this.canvas!=null) {
      this.canvas.setFocus();
    }
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
  
  public boolean markAsDirty() {
    return this.dirty = true;
  }
  
  @Override
  public boolean isDirty() {
    return this.dirty;
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
