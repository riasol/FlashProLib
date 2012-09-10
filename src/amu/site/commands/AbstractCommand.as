
package amu.site.commands{
import com.adobe.cairngorm.commands.ICommand;
import com.adobe.cairngorm.control.CairngormEvent;

import flash.system.System;

import mx.controls.Alert;
import mx.core.Application;
import mx.rpc.IResponder;
import mx.rpc.events.FaultEvent;
	


	public class AbstractCommand  implements ICommand, IResponder{
		/**
		 * @abstract 
		 */
		public  function execute(e:CairngormEvent):void
		{
			
			throw new Error("AbstractCommand:execute() is abstract")
		}
		/**
		 * @abstract 
		 */
	public function result( e : Object ) : void
		{		
		throw new Error("AbstractCommand:result() is abstract")
	}

	public function fault( e : Object ) : void
	{
		var faultEvent : FaultEvent = FaultEvent( e );
		trace("Remote call error "+faultEvent.fault.faultDetail)
		//System.pause()
		//Alert.show(faultEvent.fault.faultDetail,"Remote call error",4.0,Application.application.document)
	}
	}
}