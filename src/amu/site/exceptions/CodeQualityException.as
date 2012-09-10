package amu.site.exceptions{
	public class CodeQualityException extends Error{
		public static const NOT_OVERRIDEN:String=''
		function CodeQualityException(msg:String,id:int=0){
			super(msg,id)
		}
	}
}