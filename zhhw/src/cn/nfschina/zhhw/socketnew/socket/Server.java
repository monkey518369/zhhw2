package cn.nfschina.zhhw.socketnew.socket;


import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;

import cn.nfschina.zhhw.socketnew.thread.CheckSockStatus;
import cn.nfschina.zhhw.socketnew.thread.ServerThread;

public class Server {
	private static ServerSocket server;
	public static Map<String, Socket> mapCar = new HashMap<String, Socket>();		//存储终端与服务器的连接
	public static Map<String, Socket> mapManage = new HashMap<String, Socket>();		//存储终端与服务器的连接
	public static Map<String, Long> carConnTime = new HashMap<String, Long>();
	public static void main(String[] args) {
		
		CheckSockStatus statusThread = new CheckSockStatus();
		new Thread(statusThread).start();
		
		try {
			server = new ServerSocket(5556);
			while(true){
				Socket socket = server.accept();
				socket.setSoTimeout(300);
				ServerThread thread = new ServerThread(socket);
				new Thread(thread).start();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
