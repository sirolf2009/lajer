package com.sirolf2009.lajer.plugin;

import com.sirolf2009.lajer.core.LajerCompiler;
import com.sirolf2009.lajer.core.model.ComponentModel;
import com.sirolf2009.lajer.core.model.ConnectionModel;
import com.sirolf2009.lajer.core.model.PortModel;
import com.sirolf2009.lajer.core.model.SplitterModel;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
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
import org.eclipse.jdt.core.IAnnotation;
import org.eclipse.jdt.core.IJavaElement;
import org.eclipse.jdt.core.IJavaProject;
import org.eclipse.jdt.core.IMethod;
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
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
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
              final Function1<IAnnotation, Boolean> _function_1 = (IAnnotation it_2) -> {
                return Boolean.valueOf((it_2.getElementName().equals("Component") || it_2.getElementName().equals("Splitter")));
              };
              final IAnnotation nodeType = ((IAnnotation[])Conversions.unwrapArray(IterableExtensions.<IAnnotation>filter(((Iterable<IAnnotation>)Conversions.doWrapArray(type.getAnnotations())), _function_1), IAnnotation.class))[0];
              final Function1<IMethod, Boolean> _function_2 = (IMethod it_2) -> {
                try {
                  final Function1<IAnnotation, Boolean> _function_3 = (IAnnotation it_3) -> {
                    return Boolean.valueOf(it_3.getElementName().equals("Expose"));
                  };
                  boolean _isEmpty = IterableExtensions.isEmpty(IterableExtensions.<IAnnotation>filter(((Iterable<IAnnotation>)Conversions.doWrapArray(it_2.getAnnotations())), _function_3));
                  return Boolean.valueOf((!_isEmpty));
                } catch (Throwable _e) {
                  throw Exceptions.sneakyThrow(_e);
                }
              };
              final List<IMethod> exposed = IterableExtensions.<IMethod>toList(IterableExtensions.<IMethod>filter(((Iterable<IMethod>)Conversions.doWrapArray(type.getMethods())), _function_2));
              boolean _equals = nodeType.getElementName().equals("Component");
              if (_equals) {
                String _fullyQualifiedName = type.getFullyQualifiedName();
                ArrayList<PortModel> _arrayList = new ArrayList<PortModel>();
                ArrayList<PortModel> _arrayList_1 = new ArrayList<PortModel>();
                final ComponentModel model = new ComponentModel(_fullyQualifiedName, _arrayList, _arrayList_1);
                final Function1<IMethod, PortModel> _function_3 = (IMethod it_2) -> {
                  ArrayList<ConnectionModel> _arrayList_2 = new ArrayList<ConnectionModel>();
                  ArrayList<ConnectionModel> _arrayList_3 = new ArrayList<ConnectionModel>();
                  return new PortModel(model, _arrayList_2, _arrayList_3);
                };
                final Consumer<PortModel> _function_4 = (PortModel it_2) -> {
                  List<PortModel> _inputPorts = model.getInputPorts();
                  _inputPorts.add(it_2);
                  List<PortModel> _outputPorts = model.getOutputPorts();
                  _outputPorts.add(it_2);
                };
                ListExtensions.<IMethod, PortModel>map(exposed, _function_3).forEach(_function_4);
                LajerEditor.this.manager.add(model, 10, 10);
              } else {
                String _fullyQualifiedName_1 = type.getFullyQualifiedName();
                ArrayList<PortModel> _arrayList_2 = new ArrayList<PortModel>();
                ArrayList<PortModel> _arrayList_3 = new ArrayList<PortModel>();
                final SplitterModel model_1 = new SplitterModel(_fullyQualifiedName_1, _arrayList_2, _arrayList_3);
                int _size = exposed.size();
                boolean _equals_1 = (_size == 1);
                if (_equals_1) {
                  List<PortModel> _inputPorts = model_1.getInputPorts();
                  ArrayList<ConnectionModel> _arrayList_4 = new ArrayList<ConnectionModel>();
                  ArrayList<ConnectionModel> _arrayList_5 = new ArrayList<ConnectionModel>();
                  PortModel _portModel = new PortModel(model_1, _arrayList_4, _arrayList_5);
                  _inputPorts.add(_portModel);
                  List<PortModel> _outputPorts = model_1.getOutputPorts();
                  ArrayList<ConnectionModel> _arrayList_6 = new ArrayList<ConnectionModel>();
                  ArrayList<ConnectionModel> _arrayList_7 = new ArrayList<ConnectionModel>();
                  PortModel _portModel_1 = new PortModel(model_1, _arrayList_6, _arrayList_7);
                  _outputPorts.add(_portModel_1);
                  List<PortModel> _outputPorts_1 = model_1.getOutputPorts();
                  ArrayList<ConnectionModel> _arrayList_8 = new ArrayList<ConnectionModel>();
                  ArrayList<ConnectionModel> _arrayList_9 = new ArrayList<ConnectionModel>();
                  PortModel _portModel_2 = new PortModel(model_1, _arrayList_8, _arrayList_9);
                  _outputPorts_1.add(_portModel_2);
                } else {
                  throw new RuntimeException("Only one method may be exposed for a splitter");
                }
                LajerEditor.this.manager.add(model_1, 10, 10);
              }
              LajerEditor.this.markAsDirty();
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
      monitor.subTask("Saving");
      monitor.subTask("Compiling");
      final String generated = LajerCompiler.compile(this.manager.asOperation());
      Files.write(Paths.get(this.getEditorInput().getPath().toString().replace(".lajer", ".java")), Collections.<CharSequence>unmodifiableList(CollectionLiterals.<CharSequence>newArrayList(generated)), StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
      monitor.done();
      this.dirty = false;
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
