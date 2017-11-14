package com.sirolf2009.lajer.core.operation

import org.eclipse.xtend.core.compiler.batch.XtendCompilerTester
import org.junit.Test
import com.sirolf2009.lajer.core.annotation.Component

class TestComponentAnnotation {

	extension XtendCompilerTester compilerTester = XtendCompilerTester.newXtendCompilerTester(Component)

	@Test
	def void test() {
		'''
		import com.sirolf2009.lajer.core.annotation.Component
		import com.sirolf2009.lajer.core.annotation.Expose
		
		@Component class Math {
					
			def public add(int a, int b) {
				return a + b
			}
			def multiply(int a, int b) {
				return a * b
			}
			def private subtract(int a, int b) {
				return a - b
			}
			
		}'''.assertCompilesTo('''
		import com.sirolf2009.lajer.core.Port;
		import com.sirolf2009.lajer.core.annotation.Component;
		import com.sirolf2009.lajer.core.annotation.Expose;
		import java.util.Arrays;
		import java.util.List;
		
		@Component
		@SuppressWarnings("all")
		public class Math extends com.sirolf2009.lajer.core.component.Component {
		  @Expose
		  public int add(final int a, final int b) {
		    return (a + b);
		  }
		  
		  @Expose
		  public int multiply(final int a, final int b) {
		    return (a * b);
		  }
		  
		  private int subtract(final int a, final int b) {
		    return (a - b);
		  }
		  
		  @java.lang.Override
		  public List<Port> getPorts() {
		    try {
		    	return Arrays.asList((Port) new com.sirolf2009.lajer.core.component.MethodPort(this, java.lang.invoke.MethodHandles.lookup().bind(this, "add", java.lang.invoke.MethodType.methodType(int.class, int.class, int.class))),
		    	(Port) new com.sirolf2009.lajer.core.component.MethodPort(this, java.lang.invoke.MethodHandles.lookup().bind(this, "multiply", java.lang.invoke.MethodType.methodType(int.class, int.class, int.class))));
		    } catch(Exception e) {
		    	throw new RuntimeException(e);
		    }
		  }
		}
		''')
	}

}
