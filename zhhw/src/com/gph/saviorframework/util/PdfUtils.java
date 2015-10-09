package com.gph.saviorframework.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

import org.apache.commons.lang3.StringUtils;
import org.pdfbox.pdmodel.PDDocument;
import org.pdfbox.util.PDFTextStripper;

public class PdfUtils {

	private String swfPath;
	private String xpdfPath;

	public int pdf2swf(String sourceFile, String destFile) {
		try {
			String command = swfPath + File.separator + "pdf2swf " + sourceFile + " -o " + destFile+" -s flashversion=9 -s languagedir="+xpdfPath;
			Process pro = Runtime.getRuntime().exec(command);

			BufferedReader bufferedReader = new BufferedReader(
					new InputStreamReader(pro.getInputStream()));
			String line = StringUtils.EMPTY;
			while ((line = bufferedReader.readLine()) != null) {
				System.out.println(line);
			}
			pro.waitFor();
			return pro.exitValue();
		} catch (InterruptedException e) {
			e.printStackTrace();
			return -1;
		} catch (IOException e1) {
			e1.printStackTrace();
			return -1;
		}
	}
	
	public String getPdfContent(String source){
		String content = StringUtils.EMPTY;
		PDDocument document = null;
		try {
			document = PDDocument.load(new File(source));
			PDFTextStripper textStripper = new PDFTextStripper();
			content = textStripper.getText(document);
			document.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return content;
	}

	public String getSwfPath() {
		return swfPath;
	}

	public void setSwfPath(String swfPath) {
		this.swfPath = swfPath;
	}
}
