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
	private MatchVersusService mvs;
	
	@Autowired
	private MatchVersusBoService mvbs;
	
	//添加玩法
	@RequestMapping("/addPlayType")
	public ResponseObject addPlayType(@RequestParam int versusId,
                                      @RequestParam int bo,
                                      @RequestParam String name,
                                      @RequestParam String templateClass,
                                      @RequestParam double leftWinRate,
                                      @RequestParam double rightWinRate,
                                      @RequestParam boolean fixedOdds,
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
		if(leftWinRate <= 0 || rightWinRate <= 0) {
			return new ResponseObject(104, "预计胜率不能小于等于零");
		}
		
		//参数字符串
		String paramStr = null;
		Map<String, String> paramMap = new LinkedHashMap<String, String>();
		if(params != null && params.length > 0) {
			for(String param : params) {
				String[] strs = param.split("\\|");
				paramMap.put(strs[0], strs[1]);
			}
			paramStr = template.getParamJsonStr(paramMap);
		}
		
		
		List<PlayType> ptList = new ArrayList<PlayType>();
		if(bo < 0) { //应用到所有
			if(template.getSupport() <= 0) {
				PlayType versusPy = new PlayType();//总盘口玩法
				versusPy.setVersusId(versus.getId());
				versusPy.setName(name);
				versusPy.setBo(0);
				versusPy.setParamStr(paramStr);
				versusPy.setLeftWinRate(leftWinRate);
				versusPy.setRightWinRate(rightWinRate);
				versusPy.setFixedOdds(fixedOdds);
				if(versus.getStatus() == MatchStatus.未开始 || versus.getStatus() == MatchStatus.进行中) {
					versusPy.setGuessStart(true);
				} else {
					versusPy.setGuessStart(false);
				}
				versusPy.setTemplateClass(template.getClass().getName());
				versusPy.setLeftGuessName(template.getLeftGuessName(versus, boList, paramMap));
				versusPy.setRightGuessName(template.getRightGuessName(versus, boList, paramMap));
				ptList.add(versusPy);
			}
			if(template.getSupport() < 0 || template.getSupport() > 0) {
				for(int i=0; i<boList.size(); i++) { //bo
					MatchVersusBo versusBo = boList.get(i);
					PlayType boPy = new PlayType();
					boPy.setVersusId(versus.getId());
					boPy.setName(name);
					boPy.setBo(versusBo.getBo());
					boPy.setParamStr(paramStr);
					boPy.setLeftWinRate(leftWinRate);
					boPy.setRightWinRate(rightWinRate);
					boPy.setFixedOdds(fixedOdds);
					if(versus.getStatus() == MatchStatus.未开始 || versus.getStatus() == MatchStatus.进行中) {
						boPy.setGuessStart(true);
					} else {
						boPy.setGuessStart(false);
					}
					boPy.setTemplateClass(template.getClass().getName());
					boPy.setLeftGuessName(template.getLeftGuessName(versus, boList, paramMap));
					boPy.setRightGuessName(template.getRightGuessName(versus, boList, paramMap));
					ptList.add(boPy);
				}
			}
		} else if(bo > 0) { //只应用到bo
			if(template.getSupport() == 0) {
				return new ResponseObject(105, "玩法模版不支持");
			}
			PlayType boPy = new PlayType();
			boPy.setVersusId(versus.getId());
			boPy.setName(name);
			boPy.setBo(bo);
			boPy.setParamStr(paramStr);
			boPy.setLeftWinRate(leftWinRate);
			boPy.setRightWinRate(rightWinRate);
			boPy.setFixedOdds(fixedOdds);
			if(versus.getStatus() == MatchStatus.未开始 || versus.getStatus() == MatchStatus.进行中) {
				boPy.setGuessStart(true);
			} else {
				boPy.setGuessStart(false);
			}
			boPy.setTemplateClass(template.getClass().getName());
			boPy.setLeftGuessName(template.getLeftGuessName(versus, boList, paramMap));
			boPy.setRightGuessName(template.getRightGuessName(versus, boList, paramMap));
			ptList.add(boPy);
		} else { //只应用到总盘口
			if(template.getSupport() > 0) {
				return new ResponseObject(105, "玩法模版不支持");
			}
			PlayType versusPy = new PlayType();//总盘口玩法
			versusPy.setVersusId(versus.getId());
			versusPy.setName(name);
			versusPy.setBo(0);
			versusPy.setParamStr(paramStr);
			versusPy.setLeftWinRate(leftWinRate);
			versusPy.setRightWinRate(rightWinRate);
			versusPy.setFixedOdds(fixedOdds);
			if(versus.getStatus() == MatchStatus.未开始 || versus.getStatus() == MatchStatus.进行中) {
				versusPy.setGuessStart(true);
			} else {
				versusPy.setGuessStart(false);
			}
			versusPy.setTemplateClass(template.getClass().getName());
			versusPy.setLeftGuessName(template.getLeftGuessName(versus, boList, paramMap));
			versusPy.setRightGuessName(template.getRightGuessName(versus, boList, paramMap));
			ptList.add(versusPy);
		}
		
		if(ptList.size() <= 0) {
			return new ResponseObject(107, "添加失败，未添加任何玩法");
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
				return new ResponseObject(106, "已添加相同的玩法，请不要重复添加");
			}
		}
		pts.addList(ptList, versusId);
		pts.loadStartedPlayTypeToMap();//重新加载一次
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
	
	//更改暂停状态
	@RequestMapping("/setPause")
	public ResponseObject setPause(@RequestParam int playTypeId, @RequestParam boolean pause) {
		pts.updatePause(pause, playTypeId);
		return new ResponseObject(100, "操作成功");
	}
	
	//更改预计胜率
	@RequestMapping("/updateWinRate")
	public ResponseObject updateWinRate(@RequestParam double leftWinRate, @RequestParam double rightWinRate, @RequestParam int playTypeId) {
		pts.updateWinRate(leftWinRate, rightWinRate, playTypeId);
		return new ResponseObject(100, "操作成功");
	}
	
	//更改是否固定赔率
	@RequestMapping("/updateFixedOdds")
	public ResponseObject updateFixedOdds(@RequestParam boolean fixedOdds, @RequestParam int playTypeId) {
		pts.updateFixedOdds(fixedOdds, playTypeId);
		return new ResponseObject(100, "操作成功");
	}
	
	//更新名称
	@RequestMapping("/updateName")
	public ResponseObject updateName(@RequestParam String name, @RequestParam int playTypeId) {
		pts.updateName(name, playTypeId);
		return new ResponseObject(100, "操作成功");
	}
	
	//更新双方竞猜名
	@RequestMapping("/updateGuessName")
	public ResponseObject updateGuessName(@RequestParam String leftGuessName, @RequestParam String rightGuessName, @RequestParam int playTypeId) {
		pts.updateGuessName(leftGuessName, rightGuessName, playTypeId);
		return new ResponseObject(100, "操作成功");
	}
}