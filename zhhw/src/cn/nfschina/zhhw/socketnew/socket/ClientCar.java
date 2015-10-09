package cn.nfschina.zhhw.socketnew.socket;

import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

import cn.nfschina.zhhw.socketnew.thread.ClientCarThread;

public class ClientCar {
	
	public static void main(String[] args) {
		try {
			Socket socket = new Socket("127.0.0.1",5556);
			socket.setSoTimeout(500);
			ClientCarThread thread = new ClientCarThread(socket,"#015825919341");
			new Thread(thread).start();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}
}
