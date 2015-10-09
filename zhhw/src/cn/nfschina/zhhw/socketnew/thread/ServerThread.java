package cn.nfschina.zhhw.socketnew.thread;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

import cn.nfschina.zhhw.socketnew.socket.Server;

/**
 * 服务器线程
 * @ClassName: ServerThread
 * @Description: TODO
 * @company: nfschina
 * @date 2015年9月28日 下午2:02:11
 * @author wcy
 */
public class ServerThread implements Runnable{

	private Socket socket;
	
	
	public ServerThread(Socket socket) {
		this.socket = socket;
	}
	
	@Override
	public void run() {
		InputStream is = null;
		OutputStream os = null;
		
		try {
			is = socket.getInputStream();
			os = socket.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String recive = "";
		while(true){
			byte[] by = new byte[1024];
			int len = -1;
			try {
				while((len = is.read(by, 0, 1024))!=-1){
					recive = new String(by,0,len,"utf-8");
//					System.out.println(recive);
					//终端发送的连接请求
					if(!recive.contains("heartdata") && recive.startsWith("#") ){
						System.out.println(recive+"已连接");
						Server.mapCar.put("car"+recive, socket);
						Server.carConnTime.put("car"+recive,System.currentTimeMillis());
					}else if(recive.contains("heartdata")){
//						System.out.println("这是终端发送的心跳数据");
						String sim = recive.substring(0,recive.indexOf("heartdata"));
						Server.carConnTime.put("car"+sim, System.currentTimeMillis());
					}else{
						//终端发给后台的确认消息
						if(recive.contains("rogerthat")){
							String sim = recive.substring(recive.indexOf("#", 0));
							System.out.println("收到终端返回的确认"+"   "+ recive);
							Socket manageSocket = Server.mapManage.get("manage"+recive.substring(recive.indexOf("#")));
							OutputStream osToManage = manageSocket.getOutputStream();
							osToManage.write(("rogerthat" + sim).getBytes("utf-8"));
							osToManage.flush();
							break;
						}else{			//后台发给终端的消息
							String sim = recive.substring(recive.indexOf("#", 0),recive.indexOf(",", 0));
							Server.mapManage.put("manage"+sim, socket);
							Socket carSocket = Server.mapCar.get("car"+sim);
							if(carSocket == null){
								os.write(("offline" + sim).getBytes("utf-8"));
								os.flush();
								socket.close();
								return;
							}
							OutputStream osToCar = carSocket.getOutputStream();
							osToCar.write(recive.getBytes("utf-8"));
							os.flush();
						}
					}
				}
			} catch (IOException e) {
				continue;
			}
		}
	}

}
