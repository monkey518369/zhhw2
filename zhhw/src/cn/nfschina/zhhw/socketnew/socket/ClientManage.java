package cn.nfschina.zhhw.socketnew.socket;

import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

import cn.nfschina.zhhw.socketnew.thread.ClientManageThread;

public class ClientManage {
	
	public static void main(String[] args) {
		try {
			Socket socket = new Socket("192.168.10.50",5556);
			socket.setSoTimeout(1000);
			ClientManageThread thread = new ClientManageThread(socket,"16#015825919341,阿斯蒂2111;");
			new Thread(thread).start();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
