package com.gph.app.utils;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.FileInputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

public class ImageUtils {
	
	class ImageInfo{
		
		public int width;
		
		public int height;
	}
	
	/**
	 * 获取图片信息
	 * @param fis
	 * @return
	 */
	public ImageInfo getImageInfo(FileInputStream fis){
		ImageInfo imageInfo = new ImageInfo();
		try {
			BufferedImage sourceImg =ImageIO.read(fis);
			imageInfo.height = sourceImg.getHeight();
			imageInfo.width = sourceImg.getWidth();
		} 
		catch (IOException e) {
			e.printStackTrace();
		} 
		return imageInfo;
	}
	
	/**
	 * 裁剪图片
	 * @param fis
	 * @param x
	 * @param y
	 * @param height
	 * @param width
	 */
	public void cutImage(FileInputStream fis,int x,int y,int height,int width){
		Image img;
		ImageFilter cropFilter;
		try {
			BufferedImage bi = ImageIO.read(fis);
			int srcWidth=bi.getWidth();//原图宽度
			int srcHeight=bi.getHeight();//原图高度
			//若原图大小大于大于切片大小，则进行切割
			if(srcWidth>=width&&srcHeight>=height){
			    Image image=bi.getScaledInstance(srcWidth, srcHeight, Image.SCALE_DEFAULT);
			    
			    cropFilter=new CropImageFilter(x,y,width,height);
			    img=Toolkit.getDefaultToolkit().createImage(
			      new FilteredImageSource(image.getSource(),cropFilter));
			    BufferedImage tag=new BufferedImage(width,height,BufferedImage.TYPE_INT_BGR);
			    Graphics g=tag.getGraphics();
			    g.drawImage(img, 0, 0, null);
			    g.dispose();
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}
