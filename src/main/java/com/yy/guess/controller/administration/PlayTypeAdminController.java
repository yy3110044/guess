package com.yy.guess.controller.administration;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.ResponseObject;
import com.yy.fast4j.QueryCondition.SortType;
import com.yy.guess.playTemplate.GuessPlayTemplate;
import com.yy.guess.playTemplate.GuessPlayTemplateFactory;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.enums.MatchStatus;
import com.yy.guess.service.BetService;
import com.yy.guess.service.MatchVersusBoService;
import com.yy.guess.service.MatchVersusService;
import com.yy.guess.service.PlayTypeService;

@CrossOrigin
@RestController
@RequestMapping(value="/administration", method=RequestMethod.POST)
public class PlayTypeAdminController {
	@Autowired
	private PlayTypeService pts;
	
	@Autowired
	private BetService bs;
	
	@Autowired
	private MatchVersusService mvs;
	
	@Autowired
	private MatchVersusBoService mvbs;
	
	//添加玩法
	@RequestMapping("/addPlayType")
	public ResponseObject addPlayType(@RequestParam int versusId,
                                      @RequestParam int bo,
                                      @RequestParam String name,
                                      @RequestParam String templateClass,
                                      HttpServletRequest req) {
		String[] params = req.getParameterValues("params[]");
		MatchVersus versus = mvs.findById(versusId);
		if(versus == null) {
			return new ResponseObject(101, "对阵不存在");
		}
		GuessPlayTemplate template = GuessPlayTemplateFactory.getGuessPlayTemplate(templateClass);
		if(template == null) {
			return new ResponseObject(102, "玩法模版不存在：" + templateClass);
		}
		List<MatchVersusBo> boList = mvbs.query(new QueryCondition().addCondition("versusId", "=", versusId).addSort("bo", SortType.ASC));
		if(bo > boList.size()) {
			return new ResponseObject(103, "bo超出范围");
		}
		
		//参数字符串
		String paramStr = null;
		if(params != null && params.length > 0) {
			Map<String, String> paramMap = new LinkedHashMap<String, String>();
			for(String param : params) {
				String[] strs = param.split("\\|");
				paramMap.put(strs[0], strs[1]);
			}
			paramStr = template.getParamJsonStr(paramMap);
		}
		
		
		List<PlayType> ptList = new ArrayList<PlayType>();
		if(bo < 0) { //应用到所有
			PlayType versusPy = new PlayType();//总盘口玩法
			versusPy.setVersusId(versus.getId());
			versusPy.setName(name);
			versusPy.setBo(0);
			versusPy.setParamStr(paramStr);
			if(versus.getStatus() == MatchStatus.未开始 || versus.getStatus() == MatchStatus.进行中) {
				versusPy.setGuessStart(true);
			} else {
				versusPy.setGuessStart(false);
			}
			versusPy.setTemplateClass(template.getClass().getName());
			ptList.add(versusPy);
			for(int i=0; i<boList.size(); i++) { //bo
				MatchVersusBo versusBo = boList.get(i);
				PlayType boPy = new PlayType();
				boPy.setVersusId(versus.getId());
				boPy.setName(name);
				boPy.setBo(versusBo.getBo());
				boPy.setParamStr(paramStr);
				if(versus.getStatus() == MatchStatus.未开始 || versus.getStatus() == MatchStatus.进行中) {
					boPy.setGuessStart(true);
				} else {
					boPy.setGuessStart(false);
				}
				boPy.setTemplateClass(template.getClass().getName());
				ptList.add(boPy);
			}
		} else if(bo > 0) { //只应用到bo
			if(template.getSupport() == 0) {
				return new ResponseObject(104, "玩法模版不支持");
			}
			PlayType boPy = new PlayType();
			boPy.setVersusId(versus.getId());
			boPy.setName(name);
			boPy.setBo(bo);
			boPy.setParamStr(paramStr);
			if(versus.getStatus() == MatchStatus.未开始 || versus.getStatus() == MatchStatus.进行中) {
				boPy.setGuessStart(true);
			} else {
				boPy.setGuessStart(false);
			}
			boPy.setTemplateClass(template.getClass().getName());
			ptList.add(boPy);
		} else { //只应用到总盘口
			if(template.getSupport() > 0) {
				return new ResponseObject(104, "玩法模版不支持");
			}
			PlayType versusPy = new PlayType();//总盘口玩法
			versusPy.setVersusId(versus.getId());
			versusPy.setName(name);
			versusPy.setBo(0);
			versusPy.setParamStr(paramStr);
			if(versus.getStatus() == MatchStatus.未开始 || versus.getStatus() == MatchStatus.进行中) {
				versusPy.setGuessStart(true);
			} else {
				versusPy.setGuessStart(false);
			}
			versusPy.setTemplateClass(template.getClass().getName());
			ptList.add(versusPy);
		}
		
		QueryCondition existsQc = new QueryCondition();
		existsQc.addCondition("versusId", "=", versus.getId());
		existsQc.addCondition("templateClass", "=", templateClass);
		if(paramStr != null) {
			existsQc.addCondition("paramStr", "=", paramStr);
		}
		for(PlayType pt : ptList) {
			existsQc.addCondition("bo", "=", pt.getBo());
			if(pts.find(existsQc) != null) {
				return new ResponseObject(105, "已添加相同的玩法，请不要重复添加");
			}
		}
		pts.addList(ptList);
		return new ResponseObject(100, "添加成功");
	}
	
	//返回某个对阵下的竞猜玩法数
	@RequestMapping("/getPlayTypeCount")
	public ResponseObject getPlayTypeCount(@RequestParam int versusId, Integer bo) {
		QueryCondition qc = new QueryCondition();
		qc.addCondition("versusId", "=", versusId);
		if(bo != null) {
			qc.addCondition("bo", "=", bo);
		}
		int count = pts.getCount(qc);
		return new ResponseObject(100, "返回成功", count);
	}
	
	//返回某个对阵下的所有竞猜玩法
	@RequestMapping("/getPlayType")
	public ResponseObject getPlayType(@RequestParam int versusId, Integer bo) {
		QueryCondition qc = new QueryCondition();
		qc.addCondition("versusId", "=", versusId);
		if(bo != null) {
			qc.addCondition("bo", "=", bo);
		}
		qc.addSort("bo", SortType.ASC);
		List<PlayType> list = pts.query(qc);
		return new ResponseObject(100, "返回成功", list);
	}

	//删除玩法
	@RequestMapping("/playTypeDelete")
	public ResponseObject playTypeDelete(@RequestParam int playTypeId) {
		pts.delete(playTypeId);
		return new ResponseObject(100, "删除成功");
	}
	
	//关闭或开启某个玩法的竞猜
	@RequestMapping("/setGuessStart")
	public ResponseObject setGuessStart(@RequestParam int playTypeId, @RequestParam boolean guessStart) {
		if(guessStart) {
			bs.startGuessByPlayTypeId(playTypeId);
		} else {
			bs.stopGuessByPlayTypeId(playTypeId);
		}
		return new ResponseObject(100, "操作成功");
	}
	
	//更改赔率状态以及赔率
	@RequestMapping("/setFixedOdds")
	public ResponseObject setFixedOdds(@RequestParam int playTypeId, @RequestParam boolean fixedOdds, @RequestParam(defaultValue="0") double leftOdds, @RequestParam(defaultValue="0") double rightOdds) {
		pts.updateFixedOdds(fixedOdds, leftOdds, rightOdds, playTypeId);
		return new ResponseObject(100, "更改成功");
	}
}