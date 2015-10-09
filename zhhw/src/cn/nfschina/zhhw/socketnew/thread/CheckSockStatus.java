package cn.nfschina.zhhw.socketnew.thread;

import java.io.IOException;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import cn.nfschina.zhhw.socketnew.socket.Server;

/**
 * 检测客户端是否在线的线程，如果一个客户端超过3.5秒没有给服务器发送消息，则判断为不在线
 * @ClassName: CheckSockStatus
 * @company: nfschina
 * @date 2015年9月28日 下午1:59:28
 * @author wcy
 */
public class CheckSockStatus implements Runnable{

	@Override
	public void run() {
		List<String> list = new ArrayList<String>();
		while(true){
			try {
				list.clear();
				Thread.sleep(1000);
				Iterator<String> it = Server.carConnTime.keySet().iterator();
				
				while(it.hasNext()){
					String key = it.next();
					Long beforeTime = Server.carConnTime.get(key);
//					System.out.println(beforeTime);
					//如果系统当前时间减去上次接收心跳数据的时间，则说明已不在线
					long time = System.currentTimeMillis()-beforeTime;
					if(time>3500){
						list.add(key);
//						Socket socket = Server.mapCar.get(key);
//						socket.close();
//						Server.mapCar.remove(key);
//						Server.carConnTime.remove(key);
					}
				}
				for(String key:list){
					Socket socket = Server.mapCar.get(key);
					socket.close();
					Server.mapCar.remove(key);
					Server.carConnTime.remove(key);
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
