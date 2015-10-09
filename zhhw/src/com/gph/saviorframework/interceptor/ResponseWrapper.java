package com.gph.saviorframework.interceptor;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

public class ResponseWrapper extends HttpServletResponseWrapper {
	
	private MyPrintWriter tmpWriter;
	private ByteArrayOutputStream outputStream;

	public ResponseWrapper(HttpServletResponse httpServletResponse) {
		super(httpServletResponse);
		outputStream = new ByteArrayOutputStream();
		tmpWriter = new MyPrintWriter(outputStream);
	}

	public void finalize() throws Throwable {
		super.finalize();
		outputStream.close();
		tmpWriter.close();
	}

	public String getContent() {
		try {
			tmpWriter.flush();
			String s = tmpWriter.getByteArrayOutputStream().toString("UTF-8");
			return s;
		} catch (UnsupportedEncodingException e) {
			return "UnsupportedEncoding";
		}
	}

	public PrintWriter getWriter() throws IOException {
		return tmpWriter;
	}

	public void close() throws IOException {
		tmpWriter.close();
	}

	private static class MyPrintWriter extends PrintWriter {
		private ByteArrayOutputStream myOutput; 

		public MyPrintWriter(ByteArrayOutputStream output) {
			super(output);
			myOutput = output;
		}

		public ByteArrayOutputStream getByteArrayOutputStream() {
			return myOutput;
		}
	}
}
