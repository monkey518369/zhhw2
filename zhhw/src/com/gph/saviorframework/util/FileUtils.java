package com.gph.saviorframework.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileUtils {
	
	/**
	 * 获取上传文件的扩展名并重新命名
	 * @param fileData
	 * @return
	 */
	public static String getFileName(MultipartFile fileData){  
        //上传的文件名  
        String uploadFileName = fileData.getOriginalFilename();  
        String extensionName = FilenameUtils.getExtension(uploadFileName);
        UUID uuid = UUID.randomUUID();  
        return uuid.toString()+"."+extensionName;  
    }
	
	public static String getExtensionName(MultipartFile fileData){  
        //上传的文件名  
        String uploadFileName = fileData.getOriginalFilename();  
        String extensionName = FilenameUtils.getExtension(uploadFileName);
        return extensionName;
    }
	
	public static void SaveFileFromInputStream(InputStream stream,String path,String filename) throws IOException
    {      
		File file = new File(path);
		if(!file.exists()){
			file.mkdirs();
		}
        FileOutputStream fs=new FileOutputStream( path + "/"+ filename);
        byte[] buffer =new byte[1024*1024];
        int bytesum = 0;
        int byteread = 0; 
        while ((byteread=stream.read(buffer))!=-1)
        {
           bytesum+=byteread;
           fs.write(buffer,0,byteread);
           fs.flush();
        } 
        fs.close();
        stream.close();      
    }       
}
