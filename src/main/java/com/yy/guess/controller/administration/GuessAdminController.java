package com.yy.guess.controller.administration;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import javax.servlet.http.HttpServletRequest;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.QueryCondition.SortType;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.playTemplate.GuessPlayTemplate;
import com.yy.guess.playTemplate.GuessPlayTemplateFactory;
import com.yy.guess.po.Match;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.Sport;
import com.yy.guess.po.Team;
import com.yy.guess.po.enums.MatchStatus;
import com.yy.guess.service.BetService;
import com.yy.guess.service.MatchService;
import com.yy.guess.service.MatchVersusBoService;
import com.yy.guess.service.MatchVersusService;
import com.yy.guess.service.PlayTypeService;
import com.yy.guess.service.SportService;
import com.yy.guess.service.TeamService;

/**
 * 竞猜管理
 * @author yy
 *
 */
@CrossOrigin
@RestController
@RequestMapping(value="/administration", method=RequestMethod.POST)
public class GuessAdminController {
	
	@Autowired
	private SportService ss;
	
	@Autowired
	private TeamService ts;
	
	@Autowired
	private MatchService ms;
	
	@Autowired
	private MatchVersusService mvs;
	
	@Autowired
	private MatchVersusBoService mvbs;
	
	@Autowired
	private PlayTypeService pts;
	
	@Autowired
	private BetService bs;
	
	/**
	 * 添加运动项目
	 * @param name
	 * @param logoUrl
	 * @param description
	 * @return
	 */
	@RequestMapping("/sportAdd")
	public ResponseObject sportAdd(@RequestParam String name, @RequestParam String logoUrl, @RequestParam String description) {
		if(Fast4jUtils.empty(name, logoUrl)) {
			return new ResponseObject(101, "名称和logo图不能为空");
		}
		Sport sport = ss.find(new QueryCondition().addCondition("name", "=", name));
		if(sport != null) {
			return new ResponseObject(102, "此名称已存在");
		}
		sport = new Sport();
		sport.setName(name);
		sport.setLogoUrl(logoUrl);
		sport.setDescription(description);
		ss.add(sport);
		return new ResponseObject(100, "添加成功");
	}
	
	/**
	 * 运动项目列表
	 * @param pageSize
	 * @param pageNo
	 * @param showCount
	 * @return
	 */
	@RequestMapping("/sportList")
	public ResponseObject sportList(@RequestParam(defaultValue="20") int pageSize,
                                    @RequestParam(defaultValue="1") int pageNo,
                                    @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		qc.setPage(new Page(pageSize, pageNo, showCount));
		List<Sport> list = ss.query(qc);
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", qc.getPage(ss.getCount(qc))));
	}
	
	/**
	 * 删除运动项目
	 * @param sportId
	 * @return
	 */
	@RequestMapping("/sportDelete")
	public ResponseObject sportDelete(@RequestParam int sportId) {
		QueryCondition qc = new QueryCondition().addCondition("sportId", "=", sportId);
		int teamCount = ts.getCount(qc);
		int matchCount = ms.getCount(qc);
		if(teamCount > 0 || matchCount > 0) {
			return new ResponseObject(101, "队伍以及比赛引用了此记录，无法删除");
		}
		ss.delete(sportId);
		return new ResponseObject(100, "删除成功");
	}
	
	/**
	 * 返回所有运动项目
	 * @return
	 */
	@RequestMapping("/getAllSports")
	public ResponseObject getAllSports() {
		return new ResponseObject(100, "返回成功", ss.query(null));
	}
	
	/**
	 * 添加队伍
	 * @param sportId
	 * @param name
	 * @param logoUrl
	 * @param description
	 * @return
	 */
	@RequestMapping("/teamAdd")
	public ResponseObject teamAdd(@RequestParam int sportId,
                                  @RequestParam String name,
                                  @RequestParam String logoUrl,
                                  String description) {
		Sport sport = ss.findById(sportId);
		if(sport == null) {
			return new ResponseObject(101, "运动项目不存在，请先添加");
		}
		
		Team team = new Team();
		team.setSportId(sportId);
		team.setSportName(sport.getName());
		team.setName(name);
		team.setLogoUrl(logoUrl);
		team.setDescription(description);
		ts.add(team);
		return new ResponseObject(100, "队伍添加成功");
	}
	
	/**
	 * 删除队伍
	 * @param teamId
	 * @return
	 */
	@RequestMapping("/teamDelete")
	public ResponseObject teamDelete(@RequestParam int teamId) {
		int leftTeamCount = mvs.getCount(new QueryCondition().addCondition("leftTeamId", "=", teamId));
		int rightTeamCount = mvs.getCount(new QueryCondition().addCondition("rightTeamId", "=", teamId));
		if(leftTeamCount > 0 || rightTeamCount > 0) {
			return new ResponseObject(101, "对阵表引用了相关队伍，不能删除");
		}
		ts.delete(teamId);
		return new ResponseObject(100, "删除成功");
	}
	
	/**
	 * 返回队伍列表
	 * @param sportId
	 * @param pageSize
	 * @param pageNo
	 * @param showCount
	 * @return
	 */
	@RequestMapping("/teamList")
	public ResponseObject teamList(@RequestParam int sportId,
			                       @RequestParam(defaultValue="20") int pageSize,
                                   @RequestParam(defaultValue="1") int pageNo,
                                   @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		if(sportId > 0) {
			qc.addCondition("sportId", "=", sportId);
		}
		qc.setPage(new Page(pageSize, pageNo, showCount));
		List<Team> list = ts.query(qc);
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", qc.getPage(ts.getCount(qc))));
	}
	
	/**
	 * 返回某个运动项目下的所有队伍
	 * @param sportId
	 * @return
	 */
	@RequestMapping("/getAllTeamsBySportId")
	public ResponseObject getAllTeamsBySportId(@RequestParam int sportId) {
		List<Team> list = ts.query(new QueryCondition().addCondition("sportId", "=", sportId));
		return new ResponseObject(100, "返回成功", list);
	}
	
	/**
	 * 根据match id返回相对应的运动项目和项目下的所有team
	 * @param matchId
	 * @return
	 */
	@RequestMapping("/getSportAndTeamsByMatchId")
	public ResponseObject getSportAndTeamsByMatchId(@RequestParam int matchId) {
		Match match = ms.findById(matchId);
		if(match == null) {
			return new ResponseObject(101, "赛事不存在");
		}
		
		Sport sport = ss.findById(match.getSportId());
		if(sport == null) {
			return new ResponseObject(102, "项目不存在");
		}
		
		List<Team> teamList = ts.query(new QueryCondition().addCondition("sportId", "=", sport.getId()));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("sport", sport).set("teamList", teamList).set("match", match));
	}

	/**
	 * 添加比赛
	 * @param sportId
	 * @param name
	 * @param logoUrl
	 * @param description
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping("/matchAdd")
	public ResponseObject matchAdd(@RequestParam int sportId,
                                   @RequestParam String name,
                                   @RequestParam String logoUrl,
                                   String description,
                                   @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTime,
                                   @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date endTime,
                                   @RequestParam MatchStatus status) {
		Sport sport = ss.findById(sportId);
		if(sport == null) {
			return new ResponseObject(101, "运动项目不存在，请先添加");
		}
		Match match = new Match();
		match.setSportId(sportId);
		match.setSportName(sport.getName());
		match.setName(name);
		match.setLogoUrl(logoUrl);
		match.setDescription(description);
		match.setStartTime(startTime);
		match.setEndTime(endTime);
		match.setStatus(status);
		ms.add(match);
		return new ResponseObject(100, "添加成功");
	}
	
	/**
	 * 比赛列表
	 * @param sportId
	 * @param status
	 * @param pageSize
	 * @param pageNo
	 * @param showCount
	 * @return
	 */
	@RequestMapping("/matchList")
	public ResponseObject matchList(@RequestParam int sportId,
                                    MatchStatus status,
                                    @RequestParam(defaultValue="20") int pageSize,
                                    @RequestParam(defaultValue="1") int pageNo,
                                    @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		if(sportId > 0) {
			qc.addCondition("sportId", "=", sportId);
		}
		if(status != null) {
			qc.addCondition("status", "=", status);
		}
		qc.setPage(new Page(pageSize, pageNo, showCount));
		qc.addSort("startTime", SortType.DESC);
		List<Match> list = ms.query(qc);
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", qc.getPage(ms.getCount(qc))));
	}
	
	/**
	 * 删除赛事
	 * @param matchId
	 * @return
	 */
	@RequestMapping("/matchDelete")
	public ResponseObject matchDelete(@RequestParam int matchId) {
		int count = mvs.getCount(new QueryCondition().addCondition("matchId", "=", matchId));
		if(count > 0) {
			return new ResponseObject(101, "请先删除此赛事下的所有对阵");
		}
		ms.delete(matchId);
		return new ResponseObject(100, "删除成功");
	}
	
	/**
	 * 返回某个运动下的所有比赛
	 * @param sportId
	 * @return
	 */
	@RequestMapping("/getAllMatchsBySportId")
	public ResponseObject getAllMatchsBySportId(@RequestParam int sportId) {
		List<Match> list = ms.query(new QueryCondition().addCondition("sportId", "=", sportId));
		return new ResponseObject(100, "返回成功", list);
	}
	
	/**
	 * 添加对阵
	 * @param matchId
	 * @param leftTeamId
	 * @param rightTeamId
	 * @param startTime
	 * @param status
	 * @param boCount
	 * @return
	 */
	@RequestMapping("/matchVersusAdd")
	public ResponseObject matchVersusAdd(@RequestParam int matchId,
                                         String name,
			                             @RequestParam int leftTeamId,
                                         @RequestParam int rightTeamId,
                                         @RequestParam @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTime,
                                         @RequestParam MatchStatus status,
                                         @RequestParam int boCount) {
		Match match = ms.findById(matchId);
		if(match == null) {
			return new ResponseObject(101, "赛事不存在");
		}
		Team leftTeam = ts.findById(leftTeamId), rightTeam = ts.findById(rightTeamId);
		if(leftTeam == null || rightTeam == null) {
			return new ResponseObject(102, "比赛队伍不存在");
		}
		if(leftTeamId == rightTeamId) {
			return new ResponseObject(103, "两边队伍不能一样");
		}
		if(boCount <= 0) {
			return new ResponseObject(104, "比赛局数必须大于等于1");
		}

		MatchVersus mv = new MatchVersus();
		mv.setName(name);
		mv.setMatchId(matchId);
		mv.setMatchName(match.getName());
		mv.setLeftTeamId(leftTeamId);
		mv.setLeftTeamName(leftTeam.getName());
		mv.setRightTeamId(rightTeamId);
		mv.setRightTeamName(rightTeam.getName());
		mv.setStartTime(startTime);
		mv.setStatus(status);
		mv.setBoCount(boCount);
		List<MatchVersusBo> boList = new ArrayList<MatchVersusBo>();
		for(int i=1; i<=boCount; i++) {
			MatchVersusBo mvb = new MatchVersusBo();
			mvb.setBo(i);
			mvb.setStatus(status);
			boList.add(mvb);
		}
		mvs.add(mv, boList);
		return new ResponseObject(100, "添加成功");
	}
	
	/**
	 * 返回对阵
	 * @param versusId
	 * @return
	 */
	@RequestMapping("/getMatchVersus")
	public ResponseObject getMatchVersus(@RequestParam int versusId) {
		MatchVersus versus = mvs.findById(versusId);
		List<MatchVersusBo> boList = mvbs.query(new QueryCondition().addCondition("versusId", "=", versusId).addSort("bo", SortType.ASC));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("versus", versus).set("boList", boList));
	}
	
	/**
	 * 返回对阵列表
	 * @param matchId
	 * @param status
	 * @param pageSize
	 * @param pageNo
	 * @param showCount
	 * @return
	 */
	@RequestMapping("/matchVersusList")
	public ResponseObject matchVersusList(@RequestParam int matchId,
                                          MatchStatus status,
                                          @RequestParam(defaultValue="20") int pageSize,
                                          @RequestParam(defaultValue="1") int pageNo,
                                          @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		if(matchId != 0) {
			qc.addCondition("matchId", "=", matchId);
		}
		if(status != null) {
			qc.addCondition("status", "=", status);
		}
		qc.setPage(new Page(pageSize, pageNo, showCount));
		qc.addSort("startTime", SortType.DESC);
		List<MatchVersus> list = mvs.query(qc);
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", qc.getPage(mvs.getCount(qc))));
	}
	
	/**
	 *  更新对阵
	 * @param id
	 * @param startTime
	 * @param boCount
	 * @param realBoCount
	 * @param status
	 * @param result
	 * @return
	 */
	@RequestMapping("/matchVersusUpdate")
	public ResponseObject matchVersusUpdate(@RequestParam int id,
                                            @RequestParam @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTime,
                                            @RequestParam int boCount,
                                            @RequestParam int realBoCount,
                                            @RequestParam MatchStatus status,
                                            @RequestParam int result) {
		MatchVersus versus = mvs.findById(id);
		if(versus == null) {
			return new ResponseObject(101, "对阵不存在");
		}
		
		if(boCount < 1) {
			return new ResponseObject(102, "比赛局数不能小于1");
		}
		
		if(realBoCount < 0) {
			return new ResponseObject(103, "实际局数不能小于0");
		}
		
		if(realBoCount > boCount) {
			return new ResponseObject(104, "实际局数不能大于比赛局数");
		}
		
		versus.setRealBoCount(realBoCount);
		versus.setStartTime(startTime);
		versus.setStatus(status);
		if(MatchStatus.已结束 == status) {
			versus.setResult(result);
		}
		if(MatchStatus.已结束 == status || MatchStatus.未比赛 == status) {//关闭投注接口
			bs.stopGuessByVerssuIdAndBo(versus.getId(), 0);
		}
		if(boCount != versus.getBoCount()) { //更改了boCount
			versus.setBoCount(boCount);
			List<MatchVersusBo> boList = new ArrayList<MatchVersusBo>();
			for(int i=1; i<=boCount; i++) {
				MatchVersusBo mvb = new MatchVersusBo();
				mvb.setBo(i);
				mvb.setStatus(MatchStatus.未开始);
				mvb.setVersusId(versus.getId());
				boList.add(mvb);
			}
			mvs.update(versus, boList);
		} else { //没有更改boCount
			mvs.update(versus);
		}
		return new ResponseObject(100, "修改成功");
	}
	@RequestMapping("/matchVersusBoUpdate")
	public ResponseObject matchVersusBoUpdate(@RequestParam int id,
                                              @RequestParam int firstKillTeam,
                                              @RequestParam int firstKillTime,
                                              @RequestParam int tenthKillTeam,
                                              @RequestParam int tenthKillTime,
                                              @RequestParam int leftTeamKillCount,
                                              @RequestParam int rightTeamKillCount,
                                              @RequestParam int matchTime,
                                              @RequestParam MatchStatus status,
                                              @RequestParam int result) {
		MatchVersusBo versusBo = mvbs.findById(id);
		if(versusBo == null) {
			return new ResponseObject(101, "对阵不存在");
		}
		if(firstKillTime < 0 || tenthKillTime < 0 || matchTime < 0) {
			return new ResponseObject(102, "时间不能为负");
		}
		if(leftTeamKillCount < 0 || rightTeamKillCount < 0) {
			return new ResponseObject(103, "击杀(比分)数不能为负");
		}
		
		versusBo.setFirstKillTeam(firstKillTeam);
		versusBo.setFirstKillTime(firstKillTime);
		versusBo.setTenthKillTeam(tenthKillTeam);
		versusBo.setTenthKillTime(tenthKillTime);
		versusBo.setLeftTeamKillCount(leftTeamKillCount);
		versusBo.setRightTeamKillCount(rightTeamKillCount);
		versusBo.setMatchTime(matchTime);
		versusBo.setStatus(status);
		if(MatchStatus.已结束 == status) {
			versusBo.setResult(result);
		}
		if(MatchStatus.已结束 == status || MatchStatus.未比赛 == status) {//关闭投注接口
			bs.stopGuessByVerssuIdAndBo(versusBo.getVersusId(), versusBo.getBo());
		}
		mvbs.update(versusBo);
		return new ResponseObject(100, "修改成功");
	}
	
	/**
	 * 删除对阵
	 * @param versusId
	 * @return
	 */
	@RequestMapping("/matchVersusDelete")
	public ResponseObject matchVersusDelete(@RequestParam int versusId) {
		mvs.deleteVersus(versusId);
		return new ResponseObject(100, "删除成功");
	}
	@RequestMapping("/getDistinctMatchVersusName")
	public ResponseObject getDistinctMatchVersusName(@RequestParam int matchId) {
		return new ResponseObject(100, "返回成功", mvs.getDistinctName(matchId));
	}
	
	//返回模版信息
	@RequestMapping("/getAllGuessPlayTemplate")
	public ResponseObject getAllGuessPlayTemplate() {
		Set<Entry<String, GuessPlayTemplate>> entrySet = GuessPlayTemplateFactory.getAllTemplate();
		List<JsonResultMap> list = new ArrayList<JsonResultMap>();
		for(Entry<String, GuessPlayTemplate> entry : entrySet) {
			JsonResultMap map = new JsonResultMap();
			GuessPlayTemplate value = entry.getValue();
			map.put("className", entry.getKey());
			map.put("description", value.getDescription());
			map.put("support", value.getSupport());
			map.put("templateParamInfos", value.getTemplateParamInfos());
			list.add(map);
		}
		return new ResponseObject(100, "返回成功", list);
	}
	@RequestMapping("/getGuessPlayTemplateByClassName")
	public ResponseObject getGuessPlayTemplateByClassName(@RequestParam String className) {
		GuessPlayTemplate template = GuessPlayTemplateFactory.getGuessPlayTemplate(className);
		JsonResultMap map = new JsonResultMap();
		map.put("className", template.getClass().getName());
		map.put("description", template.getDescription());
		map.put("support", template.getSupport());
		map.put("templateParamInfos", template.getTemplateParamInfos());
		return new ResponseObject(100, "返回成功", map);
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
		List<PlayType> list = pts.query(qc);
		return new ResponseObject(100, "返回成功", list);
	}
	
	//返回所有玩法类型，以对阵
	@RequestMapping("/getGuessPlayTemplateAndMatchVersus")
	public ResponseObject getGuessPlayTemplateAndMatchVersus(@RequestParam int versusId) {
		JsonResultMap result = new JsonResultMap();

		MatchVersus versus = mvs.findById(versusId);
		List<MatchVersusBo> boList = mvbs.query(new QueryCondition().addCondition("versusId", "=", versusId).addSort("bo", SortType.ASC));
		Set<Entry<String, GuessPlayTemplate>> entrySet = GuessPlayTemplateFactory.getAllTemplate();
		List<JsonResultMap> templateList = new ArrayList<JsonResultMap>();
		for(Entry<String, GuessPlayTemplate> entry : entrySet) {
			JsonResultMap map = new JsonResultMap();
			GuessPlayTemplate value = entry.getValue();
			map.put("className", entry.getKey());
			map.put("description", value.getDescription());
			map.put("support", value.getSupport());
			map.put("templateParamInfos", value.getTemplateParamInfos());
			templateList.add(map);
		}
		
		result.put("versus", versus);
		result.put("boList", boList);
		result.put("templateList", templateList);
		return new ResponseObject(100, "返回成功", result);
	}
	
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
	
	@RequestMapping("/playTypeDelete")
	public ResponseObject playTypeDelete(@RequestParam int playTypeId) {
		pts.delete(playTypeId);
		return new ResponseObject(100, "删除成功");
	}
}