/**
 * http://cookbooks.adobe.com/post_Flex_TextInput_restrict_numbers_with_decimals_and-18997.html
 */
package flashprolib.flexx.spark {

import flash.events.Event;

import flashx.textLayout.operations.InsertTextOperation;

import mx.events.FlexEvent;

import spark.components.TextInput;
import spark.events.TextOperationEvent;

[Exclude(name="restrict", kind="property")]

public class NumericInput extends TextInput
{
    public function NumericInput()
    {
        updateRegex();
		addEventListener(Event.CHANGE,function(e:Event):void{
            dispatchEvent(new Event("numberChanged"));
        })
    }

    //regex pattern
    private var regex:RegExp;

    private var _allowNegative:Boolean = true;
    /**
     * Specifies whether negative numbers are permitted.
     * Valid values are true or false.
     *
     * @default true
     */
    public function set allowNegative(value:Boolean):void
    {
        _allowNegative = value;
        updateRegex();
    }

    private var _fractionalDigits:int = 0;
    /**
     * The maximum number of digits that can appear after the decimal
     * separator.
     *
     *

     The default value is 0
     */
    public function set fractionalDigits(value:int):void
    {
        _fractionalDigits = value;
        updateRegex();
    }

    /**
     *  @private
     */
    override public function set restrict(value:String):void
    {
        throw(new Error("You are not allowed to change the restrict property of this class.  It is read-only."));
    }

    override protected function childrenCreated():void
    {
        super.childrenCreated();

        //listen for the text change event
        addEventListener(TextOperationEvent.CHANGING, onTextChange);
    }

    public function onTextChange(event:TextOperationEvent):void
    {
        if (regex && event.operation is InsertTextOperation)
        {
            // What will be the text if this input is allowed to happen
            var textToBe:String = "";
            // Check selection
            if (selectionActivePosition > 0)
            {
                textToBe += text.substr(0, selectionActivePosition)
            }
            //append the newly entered text with the existing text
            textToBe += InsertTextOperation(event.operation).text;
            if (selectionAnchorPosition > 0)
            {
                textToBe += text.substr(selectionAnchorPosition, text.length - selectionAnchorPosition);
            }
            var match:Object = regex.exec(textToBe);
            if (!match || match[0] != textToBe)
            {
                // The textToBe didn't match the expression... stop the event
                event.preventDefault();
            }
            //special condition checking to prevent multiple dots
            var firstDotIndex:int = textToBe.indexOf(".");
            if( firstDotIndex != -1)
            {
                var lastDotIndex:int = textToBe.lastIndexOf(".");
                if(lastDotIndex != -1 && lastDotIndex != firstDotIndex)
                    event.preventDefault();
            }
        }
    }

    private function updateRegex():void
    {
        var regexString:String = "\\d{0,50}";
        if(_allowNegative)
            regexString = "^\\-?" + regexString;
        else
            regexString = "^" + regexString;
        if(_fractionalDigits > 0 )
            regexString += "\\.?\\d{0," + _fractionalDigits.toString() + "}$";
        else
            regexString += "$";
        regex = new RegExp(regexString);
    }
    private var _number:Number
    [Bindable(event="numberChanged")]
    public function get number():Number {
        return Number(text);
    }

    public function set number(value:Number):void {
        if (_number == value) return;
		_number=value
        text = String(value);
        dispatchEvent(new Event("numberChanged"));
    }
}
}
