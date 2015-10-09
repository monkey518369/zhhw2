package cn.nfschina.zhhw.socket;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.ConnectException;
import java.net.Socket;
import java.net.UnknownHostException;

import javax.swing.JOptionPane;

public class ClientMain {
	
	public static void main(String[] args) throws UnknownHostException, IOException {
		try{
			Socket socket = new Socket("127.0.0.1",5555);
			//ClientThread socketRunnable = new ClientThread(socket,0,"#015825919341");
			ClientThread socketRunnable = new ClientThread(socket,1,"32#015825919341,60,ff,140902184415,140902184417,60,200,11,39.97186,116.2896,39.976593,116.44409,39.96344,116.45851,39.864952,116.461945,39.847557,116.45096,39.84281,116.306076,39.88129,116.30333,39.88656,116.312256,39.909737,116.30745,39.91553,116.2944,39.95186,116.29646;");
//			ClientThread socketRunnable = new ClientThread(socket,0,"#015825919341");
			new Thread(socketRunnable).start();
		}catch(ConnectException e){
			JOptionPane.showMessageDialog(null, "服务端未启动");
		}
		 
		/*  模拟长连接数据改变
			int i = 0;
			while(true){
				try {
					Thread.sleep(5000);
					socketRunnable.setData(String.valueOf(i++));
				} catch (InterruptedException e) {
					e.printStackTrace();
			}
		}*/
		
	}
}

class ClientThread implements Runnable{
	private Socket socket;
	
	/*
	 * 用于标识连接类型
	 * 0：与车辆建立的长连接
	 * 1：与后台建立的短连接
	 */
	private int type;
	
	//心跳数据，定时发送
	private final String heartbeatData = "asdf";
	
	//真正要发送的数据
	private String data = "";
	
    public ClientThread(Socket socket,int type) {
		super();
		this.type = type;
		this.socket = socket;
	}
    
	/*
	 * 建立socket连接线程初始化参数
	 * socket：连接套接字
	 * type：连接类型标识 。0表示车辆长连接，1表示车辆短连接
	 * data：发送的数据，车辆首次建立连接时发送设备id,后台直接表示发送的真是数据
	 */
	public ClientThread(Socket socket,int type,String data) {
		this.socket = socket;
		this.type = type;
		this.data = data;
	}
	
	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	@Override
	public void run() {
		//与后台建立的连接是短连接，发送完数据即关闭
		if(type == 0){			// 与车辆建立的连接需要保持长连接，不断发送心跳数据包
			while(socket.isConnected()){
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e1) {
					e1.printStackTrace();
				}
				OutputStreamWriter ow;
				try {
					OutputStream os = null;
					if(!socket.isClosed()){
						os = socket.getOutputStream();
					}else{
						break;
					}
					ow = new OutputStreamWriter(os);
					if("".equals(data)||data == null){
						ow.write(heartbeatData);
					}else{
						ow.write(data);
						this.setData("");
					}
					try{
						os.flush();
						ow.flush();
					}catch(Exception e){
						socket.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				//存储读取的字符
				byte[] by = new byte[1024];
				//存储读取的字符长度
				int len = 0;
				try {
					InputStream is = socket.getInputStream();
					while((len = is.read(by, 0, 1024))!=-1){
						String str = new String(by,0,len);
						System.out.println(str);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}else if(type == 1){
			OutputStreamWriter ow;
			try {
				OutputStream os = socket.getOutputStream();
				ow = new OutputStreamWriter(os);
				if("".equals(data)||data == null){
					ow.write(heartbeatData);
				}else{
					ow.write(data);
					this.setData("");
				}
				os.flush();
				ow.flush();
				socket.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}
}