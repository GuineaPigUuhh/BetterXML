package xmlhelper;

using StringTools;

enum XmlCanTypes {
    STR;
    INT;
    FLOAT;
    BOOL;
    DYNAMIC;
}

class XmlUtil {
    /**
     * Look for the value you want in XML and format it to bool
     * @param xml your XML Class
     * @param att the variable you want to get from the XML to make Parse
     * @param def When parse fails it will return this value
     * @return Bool
     */
    public static function getBool(xml:Xml, att:String, ?def:Bool = false):Bool {
        if (xml.exists(att))
            return Simplify.parseBool(xml.get(att).toLowerCase());
        return def;
    }

    /**
     * Look for the value you want in the XML and format it to Number, depending on what is written it will format it to float or int
     * @param xml your XML Class
     * @param att the variable you want to get from the XML to make Parse
     * @param def When parse fails it will return this value
     */
    public static function getNumber(xml:Xml, att:String, ?def:Float = 0) {
        if (xml.get(att).contains('.'))
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
     */
    public static function getFloat(xml:Xml, att:String, ?def:Float = 0) {
        if (xml.exists(att))
            return Std.parseFloat(xml.get(att));
        return def;
    }

    /**
     * Look for the value you want in XML and format it to int
     * @param xml your XML Class
     * @param att the variable you want to get from the XML to make Parse
     * @param def When parse fails it will return this value
     */
    public static function getInt(xml:Xml, att:String, ?def:Int = 0) {
        if (xml.exists(att))
            return Std.parseInt(xml.get(att));
        return def;
    }

    /**
     * Look for the value you want in the XML and identify the type of the variable and the function applies it to a type it thinks it is, It is not recommended that you use
     * @param xml your XML Class
     * @param att the variable you want to get from the XML to make Parse
     */
    @:haxe.warning("It is not recommended that you use")
    public static function getDynamic(xml:Xml, att:String):Dynamic {
        var numberArray = [for (i in 0...9) Std.string(i)];
        var boolAtt = xml.get(att).toLowerCase();
        if ((boolAtt == "false" || boolAtt == "0") || (boolAtt == "true" || boolAtt == "1"))
            return getBool(xml, att);
        else if (Simplify.containsArray(att, numberArray))
            return getNumber(xml, att);
        
        return xml.get(att);
    }

    /**
     * make an XML string become an array
     * @param xml your XML Class
     * @param att the variable you want to get from the XML to make Parse
     * @param arrayType will format each type variable you choose
     * @param splot value that the function will use to separate the Variable string from the XML
     */
    public static function getArray(xml:Xml, att:String, ?arrayType:XmlCanTypes = STR, ?splot:String = ',') {
        var array:Array<Dynamic> = [];
        if (xml.exists(att))
        {
            array = xml.get(att).split(splot);
            for (i in array)
            {
                switch (arrayType)
                {
                    case STR: 
                    case BOOL: i = Simplify.parseBool(i);
                    case FLOAT: i = Std.parseFloat(i);
                    case INT: i = Std.parseFloat(i);
                    case DYNAMIC:
                }
            }    
        }    
        return array;
    }
}

class Simplify {
    public static function containsArray(text:String, array:Array<String>) {
        for (i in array)
        {
            if (text.contains(i))
            {
                return true;
            }    
        }    
        return false;
    }

    public static function parseBool(s:String) {
        if (s == "true" || s == "1")
            return true;
        else if (s == "false" || s == "0")
            return false;
        return false;
    }
}