package xmlhelper;

using StringTools;

/**
 * These are the types that XML can parse
 * @param STR
 * @param INT
 * @param FLOAT
 * @param BOOL
 * @param DYNAMIC
 */
enum XmlTypes {
	STR;
	INT;
	FLOAT;
	BOOL;
	DYNAMIC;
}

/**
 * change the writing type of the string
 * @param NONE
 * @param UPPERCASE
 * @param LOWERCASE
 */
enum XmlStringEffects {
	NONE;
	UPPER;
	LOWER;
}

/**
 * Functions that help you with XML.
 */
@haxe.warning("XmlHelper Class has not yet been tested")
class XmlHelper {
	/**
	 * This function is useless but it can be nice to organize, it is only used for these functions within this class, but I let you use it
	 * @param xml your XML Class
	 * @param att the variable you want to get from the XML to make Parse
	 * @param effect change the writing type of the string
	 * @param def When parse fails it will return this value 
	 * @return String
	 */
	public static function getString(xml:Xml, att:String, ?effect:XmlStringEffects = NONE, ?def:String = ''):String {
		if (xml.get(att) != null) {
			switch (effect) {
				case LOWER:
					return xml.get(att).toLowerCase();
				case UPPER:
					return xml.get(att).toUpperCase();
				case NONE:
					return xml.get(att);
			}
		}
		return def;
	}

	/**
	 * Look for the value you want in XML and format it to bool
	 * @param xml your XML Class
	 * @param att the variable you want to get from the XML to make Parse
	 * @param def When parse fails it will return this value
	 * @return Bool
	 */
	public static function getBool(xml:Xml, att:String, ?def:Bool = false):Bool {
		if (xml.get(att) != null) {
			if (getString(xml, att, LOWER) == "true")
				return true;
			else if (getString(xml, att, LOWER) == "false")
				return false;
		}
		return def;
	}

	/**
	 * Look for the value you want in the XML and format it to Number, depending on what is written it will format it to float or int
	 * @param xml your XML Class
	 * @param att the variable you want to get from the XML to make Parse
	 * @param def When parse fails it will return this value
	 * @return Float or Int
	 */
	public static function getNumber(xml:Xml, att:String, ?def:Float = 0) {
		if (getString(xml, att).contains('.'))
			return getFloat(xml, att);
		else
			return getInt(xml, att);
		return def;
	}

	/**
	 * Look for the value you want in XML and format it to float
	 * @param xml your XML Class
	 * @param att the variable you want to get from the XML to make Parse
	 * @param def When parse fails it will return this value
	 * @return Float
	 */
	public static function getFloat(xml:Xml, att:String, ?def:Float = 0) {
		if (xml.get(att) != null)
			return Std.parseFloat(xml.get(att));
		return def;
	}

	/**
	 * Look for the value you want in XML and format it to int
	 * @param xml your XML Class
	 * @param att the variable you want to get from the XML to make Parse
	 * @param def When parse fails it will return this value
	 * @return Int
	 */
	public static function getInt(xml:Xml, att:String, ?def:Int = 0) {
		if (xml.get(att) != null)
			return Std.parseInt(xml.get(att));
		return def;
	}

	/**
	 * make an XML string become an array
	 * @param xml your XML Class
	 * @param att the variable you want to get from the XML to make Parse
	 * @param arrayType will format each type variable you choose
	 * @param splot value that the function will use to separate the Variable string from the XML
	 * @return Array<Dynamic>
	 */
	public static function getArray(xml:Xml, att:String, ?arrayType:XmlTypes = STR, ?splot:String = ',') {
		var array:Array<Dynamic> = [];
		if (xml.get(att) != null) {
			array = xml.get(att).split(splot);
			for (i in array) {
				switch (arrayType) {
					case BOOL:
						if (getString(xml, att, LOWER) == "true")
							i = true;
						else
							i = false;
					case FLOAT:
						i = Std.parseFloat(i);
					case INT:
						i = Std.parseInt(i);
					default:
						i = Std.string(i);
				}
			}
		}
		return array;
	}
}
