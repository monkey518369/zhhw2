package cn.nfschina.zhhw.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @Description:增加定时器任务支持，测试类
 * copyright nfschina
 * MyTask.java
 * create on 2015年9月1日 上午9:26:26
 * @author wcy
 */
@Component
public class MyTask {

	private int num = 0;
	@Scheduled(cron="* 39 14 * * ? ")
	public void taskCycle(){
		System.out.println(num+5);
	}
	
}
