package flashprolib.flexx
{
	import mx.resources.ResourceManager;
	import mx.validators.EmailValidator;
	import mx.validators.StringValidator;
	

	public class ValidatorsDigest
	{
		public static function getEmptyValidator(minLength:Number=3):StringValidator{
			var v:StringValidator=new StringValidator()
			//v.requiredFieldError='wymagane'
			v.minLength=minLength;
			v.required=true
			return v
		}
		public static function getEmailValidator():EmailValidator{
			var v:EmailValidator=new EmailValidator()
			v.required=true
			return v
		}
	}
}