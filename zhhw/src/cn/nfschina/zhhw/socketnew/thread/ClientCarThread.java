package cn.nfschina.zhhw.socketnew.thread;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.net.SocketException;

/**
 * 车载终端连接服务器的线程
 * @ClassName: ClientCarThread
 * @company: nfschina
 * @date 2015年9月28日 下午2:00:51
 * @author wcy
 */
public class ClientCarThread implements Runnable{

	private Socket socket;
	private String data;
	private static final String heart = "heartdata";
	private static String sim = "";
	public ClientCarThread(Socket socket,String data){
		this.socket = socket;
		this.data = data;
		this.sim = data;
	}
	
	@Override
	public void run() {
		InputStream is = null;		//服务器端接收消息的输入流	
		OutputStream os = null;		//客户端向服务器端发送消息的输出流
		try {
			is = socket.getInputStream();
			os = socket.getOutputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		while(true){
			try {
				Thread.sleep(500);
				//初次连接发送车辆的sim卡标识，以后就发送心跳数据
				os.write(data.getBytes("utf-8"));
				os.flush();
				data = sim + heart;
				
				byte[] by = new byte[1024];
				int len = -1;
				
				try{
					while((len = is.read(by, 0, 1024)) != -1){
						String recive = new String(by,0,len,"utf-8");
						System.out.println(recive);
						os.write(("rogerthat"+recive.substring(recive.indexOf("#"), recive.indexOf(","))).getBytes("utf-8"));
						os.flush();
					}
				}catch(IOException e1){
					continue;
				}
			}catch (SocketException e){
				System.out.println("服务器已关闭");
				return;
			} catch (IOException e) {
				e.printStackTrace();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
	
}
