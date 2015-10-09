package com.gph.saviorframework;

/**
 * 框架异常处理
 * @author guopeihui
 *
 */
public class SaviorFrameworkException extends Exception {
	
	private static final long serialVersionUID = 1L;

	public SaviorFrameworkException() {
		super();
	}

	/**
	 * @param message
	 * @param cause
	 */
	public SaviorFrameworkException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * @param message
	 */
	public SaviorFrameworkException(String message) {
		super(message);
	}

	/**
	 * @param cause
	 */
	public SaviorFrameworkException(Throwable cause) {
		super(cause);
	}

}
