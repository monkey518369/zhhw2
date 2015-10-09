package cn.nfschina.zhhw.socketnew.thread;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.net.SocketTimeoutException;

/**
 * 后台给服务器发送消息的线程
 * @ClassName: ClientManageThread
 * @company: nfschina
 * @date 2015年9月28日 下午2:01:13
 * @author wcy
 */
public class ClientManageThread implements Runnable{

	private Socket socket;
	private String data;
	
	public ClientManageThread(Socket socket,String data){
		this.socket = socket;
		this.data = data;
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
		
		try {
			os.write(data.getBytes("utf-8"));
			os.flush();
			
			byte[] by = new byte[1024];
			int len = -1;
			String recive = "";
			while(true){
				try{
					while((len=is.read(by, 0, 1024))!=-1){
						recive = new String(by,0,len,"utf-8");
						System.out.println("收到终端返回的确认消息"+recive);
						if("rogerthat".equals(recive)){
							return;
						}else if(recive.contains("offline")){
							System.out.println("接受消息的终端不在线！");
							return;
						}
					}
				}catch(SocketTimeoutException e){
					os.write(data.getBytes("utf-8"));
					os.flush();
					try {
						Thread.sleep(500);
					} catch (InterruptedException e1) {
						e1.printStackTrace();
					}
					continue;
				}
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
