/**
* @文件名： StringUtils.java
* @描述: TODO
* @作者：   paul 
* @创建日期： 2014-2-14
* @版本： V 1.0
*/
package ${basepackage}.utils;

import java.util.Collection;
import java.util.Iterator;

/**
 * @文件名 StringUtils.java
 * @作者   paul
 * @创建日期 2014-2-14
 * @版本 V 1.0
 */
public class StringUtils {
	//首字母转小写
	public static String toLowerCaseFirstOne(String s)
    {
        if(Character.isLowerCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
    }
    //首字母转大写
    public static String toUpperCaseFirstOne(String s)
    {
        if(Character.isUpperCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
    }
    /**
     * 数组转字符串
     * @param vlaues
     * @return
     */
    public static String arrayToString(Object[] vlaues,String delim) {
    	if(delim==null){
    		delim = ",";
    	}
        StringBuffer buffer = new StringBuffer(vlaues.length);
        if (vlaues != null) {
            for (int i = 0; i < vlaues.length; i++) {
                buffer.append(String.valueOf(vlaues[i])).append(delim);
            }
        }
        if (buffer.length() > 0) {
            return buffer.toString().substring(0, buffer.length() - delim.length());
        }
        return "";
    }
    /**
     * 数组转字符串
     * @param vlaues
     * @return
     */
    public static String arrayToString(Collection vlaues,String delim) {
    	if(delim==null){
    		delim = ",";
    	}
    	StringBuffer buffer = new StringBuffer(vlaues.size());
    	if (vlaues != null) {
    		Iterator iterator=vlaues.iterator();
    		while(iterator.hasNext()){
    			buffer.append(String.valueOf(iterator.next())).append(delim);
    		}
    	}
    	if (buffer.length() > 0) {
    		return buffer.toString().substring(0, buffer.length() - delim.length());
    	}
    	return "";
    }
}
