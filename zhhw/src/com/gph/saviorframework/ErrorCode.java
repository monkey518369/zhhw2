package com.gph.saviorframework;

/**
 * 错误码
 * @author guopeihui
 *
 */
public interface ErrorCode {
	/** 乐观锁异常 */
	static final String OPTIMISTIC_LOCKING = "OPTIMISTIC_LOCKING";

	/** 违反数据完整性异常 */
	static final String DATA_INTEGRITY_VIOLATION = "DATA_INTEGRITY_VIOLATION";

	/** 未捕获异常 */
	static final String UNCAUGHT_EXCEPTION = "UNCAUGHT_EXCEPTION";

	/** 文件不存在 */
	static final String FILE_NOT_EXIST = "FILE_NOT_EXIST";

	/** 文件删除失败 */
	static final String FILE_DELETE_FAILED = "FILE_DELETE_FAILED";

	/** 密码不正确 */
	static final String PASSWORD_INCORRECT = "PASSWORD_INCORRECT";

	/** 密码无效 */
	static final String PASSWORD_INVALID = "PASSWORD_INVALID";
}
