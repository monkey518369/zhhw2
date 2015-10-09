package cn.nfschina.zhhw.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.nfschina.zhhw.model.DriverInfo;
import cn.nfschina.zhhw.model.TruckInfo;
import cn.nfschina.zhhw.service.DriverService;
import cn.nfschina.zhhw.service.TruckManageService;

/**
 * @ClassName: CarDispatchController
 * @Description: 车辆远程调度控制器
 * @company: nfschina
 * @date 2015年9月22日 上午9:02:56
 * @author wcy
 */
@RequestMapping(value = "/cardispatch")
@Controller
public class CarDispatchController {
	
	public static List<String> resultList = new ArrayList<String>();
	
	@Resource
	private DriverService driverService;
	
	@Resource
	private TruckManageService truckManageService;
	
	@RequestMapping(value = "/getAllDriverPhone")
	@ResponseBody
	private List<DriverInfo> getAllDriverPhone(){
		return driverService.getAllDriver();
	}
	
	@RequestMapping(value = "/dispatch")
	@ResponseBody
	private Object carDispatch(String ids,String textMessage,String message,String ConversationType,String phoneNum) throws UnknownHostException, IOException{
		List<TruckInfo> trucks = truckManageService.getTruckById(ids);
		resultList.clear();
		loop:for(TruckInfo truck:trucks){
			String sim = truck.getSim();
			if(textMessage != null){
				String sendMessage = "16#"+sim+",";
				//表示紧急
				if(textMessage.equals("urgent")){
					sendMessage = sendMessage + "1";		//1
				}else if(textMessage.equals("terminalScren")){
					sendMessage = sendMessage + "4";		//100
				}else if(textMessage.equals("terminalTTS")){	
					sendMessage = sendMessage + "8";		//1000
				}else if(textMessage.equals("screnShow")){
					sendMessage = sendMessage + "10";		//10000
				}
				sendMessage = sendMessage + "," + message+";";
				Socket socket = new Socket("127.0.0.1", 5556);
				socket.setSoTimeout(1500);
				InputStream is = null;		//服务器端接收消息的输入流	
				OutputStream os = null;		//客户端向服务器端发送消息的输出流
				try {
					is = socket.getInputStream();
					os = socket.getOutputStream();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				try {
					os.write(sendMessage.getBytes("utf-8"));
					os.flush();
					
					byte[] by = new byte[1024];
					int len = -1;
					String recive = "";
					int conut = 0;
					while(true){
						try{
							while((len=is.read(by, 0, 1024))!=-1){
								recive = new String(by,0,len,"utf-8");
//								System.out.println("收到终端返回的确认消息"+recive);
								if(recive.contains("rogerthat")){
									CarDispatchController.resultList.add(truck.getPlate_no()+"已成功接收文本消息！");
									continue loop;
								}else if(recive.contains("offline")){
//									System.out.println("接受消息的终端不在线！");
									CarDispatchController.resultList.add(truck.getPlate_no()+"终端不在线！");
									continue loop;
								}
							}
						}catch(SocketTimeoutException e){
							conut ++;
							if(conut == 2){
								CarDispatchController.resultList.add(truck.getPlate_no()+"终端未能响应!");
								break;
							}
							os.write(sendMessage.getBytes("utf-8"));
							os.flush();
//							try {
//								Thread.sleep(500);
//							} catch (InterruptedException e1) {
//								e1.printStackTrace();
//							}
							continue;
						}
					}
					
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		loop:for(TruckInfo truck:trucks){
			String sim = truck.getSim();
			if(ConversationType != null){
				String sendMessage = "24#"+sim+",";
				//表示紧急
				if(ConversationType.equals("common")){
					sendMessage = sendMessage + "0";		//1
				}else if(ConversationType.equals("monitor")){
					sendMessage = sendMessage + "1";		//100
				}
				sendMessage = sendMessage + "," + phoneNum+";";
				Socket socket = new Socket("127.0.0.1", 5556);
				socket.setSoTimeout(1500);
				InputStream is = null;		//服务器端接收消息的输入流	
				OutputStream os = null;		//客户端向服务器端发送消息的输出流
				try {
					is = socket.getInputStream();
					os = socket.getOutputStream();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				try {
					os.write(sendMessage.getBytes("utf-8"));
					os.flush();
					
					byte[] by = new byte[1024];
					int len = -1;
					String recive = "";
					int conut = 0;
					while(true){
						try{
							while((len=is.read(by, 0, 1024))!=-1){
								recive = new String(by,0,len,"utf-8");
//								System.out.println("收到终端返回的确认消息"+recive);
								if(recive.contains("rogerthat")){
									CarDispatchController.resultList.add(truck.getPlate_no()+"已成功接收电话消息！");
									continue loop;
								}else if(recive.contains("offline")){
//									System.out.println("接受消息的终端不在线！");
									CarDispatchController.resultList.add(truck.getPlate_no()+"终端不在线！");
									continue loop;
								}
							}
						}catch(SocketTimeoutException e){
							conut ++;
							if(conut == 2){
								CarDispatchController.resultList.add(truck.getPlate_no()+"终端未能响应!");
								break;
							}
							os.write(sendMessage.getBytes("utf-8"));
							os.flush();
//							try {
//								Thread.sleep(500);
//							} catch (InterruptedException e1) {
//								e1.printStackTrace();
//							}
							continue;
						}
					}
					
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return resultList;
	}
}
