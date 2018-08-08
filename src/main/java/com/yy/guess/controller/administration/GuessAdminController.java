package com.yy.guess.controller.administration;

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
}