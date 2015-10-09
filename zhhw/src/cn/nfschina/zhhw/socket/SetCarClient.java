package cn.nfschina.zhhw.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.ConnectException;
import java.net.Socket;
import java.net.SocketException;
import java.net.UnknownHostException;

import javax.swing.JOptionPane;

import cn.nfschina.zhhw.controller.SetCarController;

public class SetCarClient {
	
	public static void getSocket(String data,int type,SetCarController setCarController)
												throws UnknownHostException, IOException {
		try{
			Socket socket = new Socket("127.0.0.1",5555);
			System.out.println(data);
			setCarClientThread socketRunnable = new setCarClientThread(socket,type,data,setCarController);
			new Thread(socketRunnable).start();
		}catch(ConnectException e){
			JOptionPane.showMessageDialog(null, "服务端未启动");
		}
	}
}

class setCarClientThread implements Runnable{
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
	
	private SetCarController setCarController;
    public setCarClientThread(Socket socket,int type) {
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
	public setCarClientThread(Socket socket,int type,String data) {
		this.socket = socket;
		this.type = type;
		this.data = data;
	}
	public setCarClientThread(Socket socket,int type,String data,SetCarController setCarController) {
		this.socket = socket;
		this.type = type;
		this.data = data;
		this.setCarController = setCarController;
	}
	
	public SetCarController getSetCarController() {
		return setCarController;
	}

	public void setSetCarController(SetCarController setCarController) {
		this.setCarController = setCarController;
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
		System.out.println("建立连接充公");
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
				socket.setSoTimeout(10*1000);
				System.out.println("set timeout success");
			} catch (SocketException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			try {
				OutputStream os = socket.getOutputStream();
				InputStream is = socket.getInputStream();
				BufferedReader br = new BufferedReader(new InputStreamReader(is));
				ow = new OutputStreamWriter(os);
				if("".equals(data)||data == null){
					ow.write(heartbeatData);
				}else{
					ow.write(data);
					this.setData("");
				}
				os.flush();
				ow.flush();
				System.out.println("print success");
				while(br.readLine()!=null){
					setCarController.callBack(br.readLine());
				}
				socket.close();
			} catch (IOException e) {
				setCarController.callBack("发送失败,请重新尝试");
				
				e.printStackTrace();
			}finally{
				try {
					socket.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
	}
}