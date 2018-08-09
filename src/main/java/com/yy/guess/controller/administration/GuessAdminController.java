package com.yy.guess.controller.administration;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import com.yy.guess.po.Match;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.Sport;
import com.yy.guess.po.Team;
import com.yy.guess.po.enums.MatchStatus;
import com.yy.guess.service.MatchService;
import com.yy.guess.service.MatchVersusService;
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
}