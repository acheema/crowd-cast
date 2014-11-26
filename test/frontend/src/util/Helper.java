package util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Helper {
	
	  public static Timestamp getTimestamp() {
		    java.util.Date date= new java.util.Date();
		    return new Timestamp(date.getTime());
		  }
	  
	  public static String getTimestampAsID() {
		    SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmssSSS");
		    return sdf.format(getTimestamp());
		  }

}
