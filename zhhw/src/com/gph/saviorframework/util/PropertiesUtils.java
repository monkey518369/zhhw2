package com.gph.saviorframework.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

public class PropertiesUtils {
	
	public Properties loadProperty(String file) {
		Properties prop = new Properties();
		try {
			InputStream is = this.getClass().getResourceAsStream("/" + file);
			prop.load(is);
			is.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return prop;
	}

	public void saveProperty(String file,Properties prop) throws IOException {
		OutputStream fos = new FileOutputStream(this.getClass()
				.getResource("/"+file).getPath());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		prop.store(fos, df.format(new Date()));
	}
}
