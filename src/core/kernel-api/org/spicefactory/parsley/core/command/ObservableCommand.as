/*
 * Copyright 2011 the original author or authors.
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

package org.spicefactory.parsley.core.command {

import org.spicefactory.lib.reflect.ClassInfo;
import org.spicefactory.parsley.core.messaging.Message;
	
/**
 * @author Jens Halm
 */
public interface ObservableCommand {
	
	
	function get trigger () : Message;
	
	function get id () : String;
	
	function get command () : Object;
	
	function get type () : ClassInfo;
	
	function get result () : Object;
	
	function get status () : CommandStatus;
	
	function get root () : Boolean;
	
	function observe (callback:Function) : void;
	
	
}
}
