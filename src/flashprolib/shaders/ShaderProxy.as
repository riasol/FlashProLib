package flashprolib.shaders{

	import flash.display.Shader;
	import flash.display.ShaderInput;
	import flash.display.ShaderParameter;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	* Class to handle loading or embedding, and passing values to a shader
	* to make it easier dealing with the quirks of the Shader class and bytecode.
	*/
	dynamic public class ShaderProxy extends Proxy implements IEventDispatcher {

		private var _shader:Shader;
		private var _eventDispatcher:EventDispatcher;

		/**
		* Constructor. This accepts a path to a .pbj file to load or
		* a shader bytecode class to instantiate. If a file needs to be loaded,
		* the loading is initiated immediately. Completion of load will result in
		* a COMPLETE event being fired.
		*
		* @param pathOrClass Either the path to a .pbj file or the shader bytecode class.
		*/
		public function ShaderProxy(pathOrClass:Object) {
			_eventDispatcher = new EventDispatcher();
			var shaderClass:Class = pathOrClass as Class;
			// if a class is passed, immediately instantiate it
			if (shaderClass != null) {
				createShader(ByteArray(new shaderClass()));
			// if a file path is passed, immediately load it
			} else if ((pathOrClass as String) != null) {
				load(pathOrClass as String);
			} else {
				throw new Error("Invalid object passed to constructor.");
			}
		}

		/**
		* Creates the Shader instance from the bytecode.
		*
		* @param data The ByteArray containing the shader bytecode.
		*/
		private function createShader(data:ByteArray):void {
			_shader = new Shader(data);
			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		* Loads the specified .pbj file.
		*
		* @param path The path to the .pbj file to load.
		*/
		private function load(path:String):void {
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, onShaderLoaded);
			loader.load(new URLRequest(path));
		}

		/**
		* Handler for when the .pbj file completes loading.
		*
		* @param event Event dispatched by URLLoader.
		*/
		private function onShaderLoaded(event:Event):void {
			var loader:URLLoader = event.target as URLLoader;
			createShader(loader.data as ByteArray);
		}

		/**
		* Method that will be called any time this class instance is called accessing a property
		* as an implicit getter that does not exist on this class.
		*
		* @param name The name of the property being accessed.
		*
		* @return The value for the property, if any, or null.
		*/
		override flash_proxy function getProperty(name:*):* {
			if (_shader) {
				// first, check to see if property is a parameter on the shader
				var result:Object = getParameter(name);
				// if it is not a parameter, check to see if it is an input
				if (result == null) {
					result = getInput(name);
				}
				return result;
			}
			return null;
		}

		/**
		* Method that will be called any time this class instance is called accessing a property
		* as an implicit setter that does not exist on this class.
		*
		* @param name The name of the property being accessed.
		* @param value The value for the property being accessed.
		*/
		override flash_proxy function setProperty(name:*, value:*):void {
			if (_shader) {
				// first, check to see if property is a parameter on the shader
				if (!setParameter(name, value)) {
					// if it is not a parameter, check to see if it is an input
					setInput(name, value);
				}
			}
		}
flash_proxy override function callProperty(name:*, ...rest):* {
		       try {
		         // custom code here
		       }
		       catch (e:Error) {
		         // respond to error here
		       }
		}
		/**
		* Returns the value of the property if it is an input property on the shader.
		*
		* @param name The name of the input property being accessed.
		*
		* @return The value for the input property, if any, or null.
		*/
		public function getInput(name:String):Object {
			// only attempt to access the input property name if it is valid for the shader
			if (_shader.data.hasOwnProperty(name) && _shader.data[name] is ShaderInput) {
				return _shader.data[name].input;
			}
			return null;
		}

		/**
		* Sets the value of the property if it is an input property on the shader.
		*
		* @param name The name of the input property being accessed.
		* @param value The value for the input property.
		*
		* @return True if the input property existed on the shader.
		*/
		public function setInput(name:String, value:Object):Boolean {
			// only attempt to access the input property name if it is valid for the shader
			if (_shader.data.hasOwnProperty(name) && _shader.data[name] is ShaderInput) {
				_shader.data[name].input = value;
				return true;
			}
			return false;
		}

		/**
		* Returns the value of the specified parameter from the shader.
		* This method ensures that float and int values are extracted from
		* the Array that wraps them.
		*
		* @param name The name of the parameter to retrieve.
		*
		* @return The value of the parameter.
		*/
		public function getParameter(name:String):Object {
			// check to see if parameter exists and is a shader parameter
			if (_shader.data.hasOwnProperty(name) && _shader.data[name] is ShaderParameter) {
				var value:Object = _shader.data[name].value;
				var type:String = _shader.data[name].type;
				// if type is float or int, grab the only value from the array
				if (type == "float" || type == "int") {
					value = (value as Array)[0];
				}
				return value;
			}
			return null;
		}

		/**
		* Sets the value of the specified parameter of the shader.
		* This method ensures that all values are passed as arrays to the shader,
		* even if the parameter is scalar.
		*
		* @param name The name of the parameter to set.
		* @param value The value to give the parameter.
		*
		* @return True if the parameter was found and set.
		*/
		public function setParameter(name:String, value:Object):Boolean {
			// check to see if parameter exists and is a shader parameter
			if (_shader.data.hasOwnProperty(name) && _shader.data[name] is ShaderParameter) {
				// wrap scalar values in an array
				if (!(value is Array)) {
					value = [value];
				}
				_shader.data[name].value = value;
				return true;
			}
			return false;
		}

		/**
		* Registers an event listener object with an EventDispatcher object
		* so that the listener receives notification of an event.
		*
		* @param type The type of event.
		* @param listener The listener function that processes the event.
		* @param useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
		* @param priority The priority level of the event listener.
		* @param useWeakReference Determines whether the reference to the listener is strong or weak.
		*/
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=true):void {
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		* Removes a listener from the EventDispatcher object.
		*
		* @param type The type of event.
		* @param listener The listener object to remove.
		* @param useCapture Specifies whether the listener was registered for the capture phase or the target and bubbling phases.
		*/
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}

		/**
		* Dispatches an event into the event flow.
		*
		* @param event The event object dispatched into the event flow.
		*
		* @return A value of true unless preventDefault() is called on the event, in which case it returns false.
		*/
		public function dispatchEvent(event:Event):Boolean {
			return _eventDispatcher.dispatchEvent(event);
		}

		/**
		* Checks whether an event listener is registered with this EventDispatcher object
		* or any of its ancestors for the specified event type.
		*
		* @param type The type of event.
		*
		* @return A value of true if a listener of the specified type will be triggered; false otherwise.
		*/
		public function willTrigger(type:String):Boolean {
			return _eventDispatcher.willTrigger(type);
		}

		/**
		* Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
		*
		* @param type The type of event.
		*
		* @return A value of true if a listener of the specified type is registered; false otherwise.
		*/
		public function hasEventListener(type:String):Boolean {
			return _eventDispatcher.hasEventListener(type);
		}

		/**
		* Returns the Shader instance this class wraps.
		*
		* @return The Shader instance managed by this class.
		*/
		public function get shader():Shader {
			return _shader;
		}
	}

}