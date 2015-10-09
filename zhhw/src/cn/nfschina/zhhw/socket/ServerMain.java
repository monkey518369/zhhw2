package cn.nfschina.zhhw.socket;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class ServerMain {
	//设置连接时间，如果在一小时内没有收到消息，则断开连接
	final int keepTime = 1000*60*60;
	
	//用于管理socket连接,存储设备id和车辆的socket
    static Map<String,Socket> socketMap = new HashMap<String, Socket>();
	
	
	
	private static ServerSocket serversocket;
	
	public static void main(String[] args) throws IOException {
		serversocket = new ServerSocket(5555);
		while(true){
			Socket socket = serversocket.accept();
			new Thread(new ServerThread(socket)).start();
		}
	}
}

class ServerThread implements Runnable{
	private Socket socket;
	
	public ServerThread(Socket socket) {
		this.socket = socket;
	}
	
	@Override
	public void run() {
		//存储读取的字符
		byte[] by = new byte[1024];
		//存储读取的字符长度
		int len = 0;
		while(socket.isConnected()){
			try {
				InputStream is = socket.getInputStream();
				while((len = is.read(by, 0, 1024))!=-1){
					String str = new String(by,0,len);
					/*
					 * 如果发送的数据以"#"号开头，则是车载设备发送的数据，将连接放入ServerMain.socketMap中,便于后台发送数据后能找到相应设备。
					 * 否则说明是后台发送给车载设备的，则解析字符串，将接收到的字符串发送给车载设备
					 */
					if(str.startsWith("#")){
						ServerMain.socketMap.put(str, socket);
					}else{
						//获取“#”的索引，进而获得服务器与车载设备的套接字发送数据
						int index = str.indexOf("#");
						String id = str.substring(index,str.indexOf(",", index));
						Socket socket = ServerMain.socketMap.get(id);
						
						//如果获得的连接为空，说明尚未建立连接，结束现成
						if(socket == null){
							break;
						}
						OutputStreamWriter ow = null;
						OutputStream os = socket.getOutputStream();
						ow = new OutputStreamWriter(os);
						ow.write(str);
						os.flush();
						ow.flush();
					}
				}
//				break;	//后台短连接接收数据后结束线程
			} catch (IOException e) {
				/*
				 * 表示客户端长连接断开与服务器的连接意外断开
				 * 1、关闭连接
				 * 2、从ServerMain.socketMap移除id和socket的映射
				 */
				try {
					socket.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
				
				Set<String> set = ServerMain.socketMap.keySet();
				for(String key:set){
					if(ServerMain.socketMap.get(key) == socket){
						ServerMain.socketMap.remove(key);
					}
				}
				e.printStackTrace();
			}
		}
	}
	
}


