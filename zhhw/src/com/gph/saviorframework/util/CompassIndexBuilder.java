package com.gph.saviorframework.util;

import org.compass.gps.CompassGps;
import org.springframework.beans.factory.InitializingBean;

public class CompassIndexBuilder implements InitializingBean {

	// 是否需要建立索引，可被设置为false使本Builder失效.
	private boolean buildIndex = false;

	// 索引操作线程延时启动的时间，单位为秒
	private int lazyTime = 10;

	// Compass封装
	private CompassGps compassGps;

	// 索引线程
	private Thread indexThread = new Thread() {

		@Override
		public void run() {
			try {
				Thread.sleep(lazyTime * 1000);
				System.out.println("begin compass index...");
				long beginTime = System.currentTimeMillis();
				// 重建索引.
				// 如果compass实体中定义的索引文件已存在，索引过程中会建立临时索引，
				// 索引完成后再进行覆盖.
				compassGps.index();
				long costTime = System.currentTimeMillis() - beginTime;
				System.out.println("compss index finished.");
				System.out.println("costed " + costTime + " milliseconds");
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	};

	/**
	 * 实现<code>InitializingBean</code>接口，在完成注入后调用启动索引线程.
	 * 
	 * @see org.springframework.beans.factory.InitializingBean#afterPropertiesSet()
	 */
	public void afterPropertiesSet() throws Exception {
		if (buildIndex) {
			indexThread.setDaemon(true);
			indexThread.setName("Compass Indexer");
			indexThread.start();
		}
	}

	public void setBuildIndex(boolean buildIndex) {
		this.buildIndex = buildIndex;
	}

	public void setLazyTime(int lazyTime) {
		this.lazyTime = lazyTime;
	}

	public void setCompassGps(CompassGps compassGps) {
		this.compassGps = compassGps;
	}
}
