package com.yy.guess.controller.administration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.service.MatchVersusService;

@Deprecated
@CrossOrigin
@RestController
@RequestMapping(value="/administration", method=RequestMethod.POST)
public class MatchVersusAdminController {
	@Autowired
	private MatchVersusService mvs;
	
	@RequestMapping("/updateAutoSwitchStatus")
	public ResponseObject updateAutoSwitchStatus(@RequestParam boolean autoSwitchStatus, @RequestParam int versusId) {
		mvs.updateAutoSwitchStatus(autoSwitchStatus, versusId);
		return new ResponseObject(100, "操作成功");
	}
}