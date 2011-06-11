/*
 * Copyright 2010 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.spicefactory.parsley.processor.core {
import org.spicefactory.parsley.processor.util.ObjectProcessorFactories;
import org.spicefactory.lib.reflect.Property;
import org.spicefactory.parsley.core.lifecycle.ManagedObject;
import org.spicefactory.parsley.core.registry.ObjectProcessor;
import org.spicefactory.parsley.core.registry.ObjectProcessorFactory;

/**
 * Processor that sets the value of a single property in the target object, potentially 
 * resolving references to other objects in the Context.
 * 
 * @author Jens Halm
 */
public class PropertyProcessor implements ObjectProcessor {
	
	
	private var target:ManagedObject;
	private var _property:Property;
	private var _unresolvedValue:*;	
	
	
	/**
	 * Creates a new processor instance.
	 * 
	 * @param target the target to apply the property value to
	 * @param property the property to set
	 * @param unresolvedValue the unresolved property value
	 */
	function PropertyProcessor (target:ManagedObject, property:Property, unresolvedValue:*) {
		this.target = target;
		this._property = property;
		this._unresolvedValue = unresolvedValue;
	}


	/**
	 * The property set by this processor.
	 */
	public function get property () : Property {
		return _property;
	}
	
	/**
	 * The unresolved value of the property.
	 * Unresolved means that for special objects like references to other
	 * objects in the Context, this will be an instance of <code>ResolvableValue</code>
	 * that merely represents the actual value.
	 */
	public function get unresolvedValue () : * {
		return _unresolvedValue;
	}
	
	/**
	 * @inheritDoc
	 */
	public function preInit () : void {
		var value:* = target.resolveValue(unresolvedValue);
		if (value != null || unresolvedValue == null) {
			// do not override default value when optional dependencies are missing
			property.setValue(target.instance, value);
		}
	}
	
	/**
	 * @inheritDoc
	 */
	public function postDestroy () : void {
		/* nothing to do */
	}
	
	
	/**
	 * @private
	 */
	public function toString () : String {
		return "[Property(name=" + property + ",value=" + unresolvedValue + ")]";
	}	
	
	
	/**
	 * Creates a new processor factory.
	 * 
	 * @param property the property to set
	 * @param value the unresolved property value
	 * @return a new processor factory
	 */
	public static function newFactory (property:Property, value:*) : ObjectProcessorFactory {
		return ObjectProcessorFactories.newFactory(PropertyProcessor, [property, value]);
	}
	
	
}
}

