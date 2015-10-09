package cn.nfschina.zhhw.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.nfschina.zhhw.model.TruckInfo;
import cn.nfschina.zhhw.service.InfoManageService;
import cn.nfschina.zhhw.service.TruckManageService;
import cn.nfschina.zhhw.socket.SetCarClient;
import cn.nfschina.zhhw.util.ConstantFile;

/**
 * 
 * @author shaolinxing
 * @time 2015年9月24日 上午9:34:45
 */
@RequestMapping("setcar")
@Controller
@Scope("prototype")
public class SetCarController {

	
	private String path = "zhhw/truckmanager/";
	
	@Resource
	private InfoManageService infoManageService;
	
	@Resource
	private TruckManageService truckManageService; 
	
	private String socketResult;//放置socket返回的数据
	
	//跳转方法
	@RequestMapping("/toset")
	public String toSetAlarm(){
		
		return path + "setalarm";
	}
	
	/**
	 * 根据组织得到车辆
	 * @param orgId
	 * @param request
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月21日 下午3:47:06 
	 * @return List<TruckInfo>
	 */
	@RequestMapping("/getcarbyorgid")
	@ResponseBody
	public List<TruckInfo> getCarsByOrgId(@RequestParam(required=false) String orgId,HttpServletRequest request){
		
		List<TruckInfo> list = new ArrayList<TruckInfo>();
		
		if(orgId!=null){
			list = infoManageService.getCarsByOrg(orgId);
		}else{
			list = truckManageService.getAllTruck(null);
		}
		
		return list;
		
	}
	
	@RequestMapping("/setspeed")
	@ResponseBody
	public Map<String,String> setSpeed(@RequestParam(required=true) String item,
									   @RequestParam(required=true)String type,
									   @RequestParam(required=true)String param1,
									   @RequestParam(required=false)String param2,
									   HttpServletRequest request){
		Map<String,String> map = new HashMap<String,String>();
		
		String data = "";
		switch(type){
		    case "time":data = ConstantFile.PARAMETRER_SET_CODE + "#0" + item + ",1,"+
		    		 		   ConstantFile.CODE_ALERT_TIME + ","+param1;
		    	break;
		    case "jobTime":data =  ConstantFile.PARAMETRER_SET_CODE + "#0" + item + ",1,"+
		    					   ConstantFile.CODE_WORK_TIME + ","+param1;
		    	break;
		    case "speed":data = ConstantFile.PARAMETRER_SET_CODE + "#0" + item + ",2,"+
					   			ConstantFile.CODE_MAX_SPEED_TIME + "," + param1 + "," +
					   			ConstantFile.CODE_MAX_SPEED_TIME + "," + param2;
		        break;
		    default:data = null;
		}
		
		try {
			SetCarClient.getSocket(data, 1, this);
			while(socketResult==null||socketResult==""){
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		map.put("result", socketResult);
		return map;
		
	}
	
	

	public void callBack(String socketResult){
		this.socketResult = socketResult;
	}
}
