package cn.nfschina.zhhw.controller;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.gph.saviorframework.common.model.User;
import com.gph.saviorframework.security.util.UserSession;
import cn.nfschina.zhhw.model.CarWarning;
import cn.nfschina.zhhw.service.CarWarningService;

@RequestMapping(value = "/carwarning")
@Controller
public class CarWarningController {

	@Resource
	private CarWarningService carWarningService;
	
	@Resource
	private UserSession userSession;
	
	@RequestMapping(value = "/getAllCarWarning")
	@ResponseBody
	private List<CarWarning> getAllCarWarning(){
		return carWarningService.getAllCarWarning();
	}
	
	@RequestMapping(value = "/updateCarWarning")
	@ResponseBody
	private ModelMap updateCarWarning(String warningId,	String describe){
		ModelMap mm = new ModelMap();
		//传过来的描述数据有问题，比如输入abc,接受到的值是abc,abc
		String a = describe.substring(describe.lastIndexOf(",")+1);
		describe = describe.substring(0,describe.indexOf(a,0)+a.length());
		User user = userSession.getUser();
		int row = carWarningService.updCarWarning(describe, user.getUsername(), warningId);
		if(row > 0){
			mm.addAttribute("success", true);
		}else{
			mm.addAttribute("success", false);
		}
		return mm;
	}
}
