package xmlhelper;

using StringTools;

class XmlUtil {
    public static function getBool(xml:Xml, att:String, ?def:Bool = false):Bool {
        if (xml.exists(att))
        {
            var betteratt = xml.get(att).toLowerCase();
            if (betteratt == "true" || betteratt == "1")
                return true;
            else if (betteratt == "false" || betteratt == "0")
                return false;
        }    
        return def;
    }

    public static function getFloat(xml:Xml, att:String, ?def:Float = 0) {
        if (xml.exists(att))
            return Std.parseFloat(xml.get(att));
        return def;
    }

    public static function getInt(xml:Xml, att:String, ?def:Int = 0) {
        if (xml.exists(att))
            return Std.parseInt(xml.get(att));
        return def;
    }

    public static function getDynamic(xml:Xml, att:String):Dynamic {
        var numberArray = [for (i in 0...9) Std.string(i)];
        var boolAtt = xml.get(att).toLowerCase();
        if ((boolAtt == "false" || boolAtt == "0") || (boolAtt == "true" || boolAtt == "1"))
            return getBool(xml, att);
        else if (Simplify.containsArray(att, numberArray))
        {
            if (xml.get(att).contains('.'))
                return getFloat(xml, att);
            else
                return getInt(xml, att);
        }    

        return xml.get(att);
    }

    public static function getArray(xml:Xml, att:String) {
        return [];
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
}