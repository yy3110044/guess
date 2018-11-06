package com.yy.guess.controller.administration.v2;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.ResponseObject;
import com.yy.fast4j.QueryCondition.SortType;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.guess.po.enums.NewGuessVersusStatus;
import com.yy.guess.service.NewGuessVersusItemService;
import com.yy.guess.service.NewGuessVersusService;

@CrossOrigin
@RestController
@RequestMapping(value="/administration/v2/versusAdmin", method=RequestMethod.POST)
public class VersusAdminController {
	@Autowired
	private NewGuessVersusService ngvs;
	
	@Autowired
	private NewGuessVersusItemService ngvis;
	
	//返回某个对阵
	@RequestMapping("/versusGet")
	public ResponseObject versusGet(@RequestParam int versusId) {
		NewGuessVersus versus = ngvs.findById(versusId);
		List<NewGuessVersusItem> versusItemList = ngvis.query(new QueryCondition().addCondition("versusId", "=", versusId));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("versus", versus).set("versusItemList", versusItemList));
	}
	
	//删除某个对阵
	@RequestMapping("/versusDelete")
	public ResponseObject versusDelete(@RequestParam int versusId) {
		ngvs.deleteVersus(versusId);
		return new ResponseObject(100, "删除成功");
	}
	
	//添加对阵
	@RequestMapping("/versusAdd")
	public ResponseObject versusAdd(@RequestParam String name,
                                    @RequestParam String logoUrl,
                                    @RequestParam int itemId,
                                    @RequestParam String itemName,
                                    @RequestParam double returnRate,
                                    @RequestParam double betAmountMin,
                                    @RequestParam double betAmountMax,
                                    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTime,
                                    @RequestParam int superVersusId,
                                    HttpServletRequest req) {
		String[] versusItems = req.getParameterValues("versusItems[]");
		if(versusItems == null || versusItems.length < 2) {
			return new ResponseObject(101, "必须至少添加两个竞猜项");
		}
		
		if(superVersusId > 0 && ngvs.findById(superVersusId) == null) {
			return new ResponseObject(102, "父对阵不存在");
		}
		
		//生成versus对象
		NewGuessVersus versus = new NewGuessVersus();
		versus.setName(name);
		versus.setLogoUrl(logoUrl);
		versus.setItemId(itemId);
		versus.setItemName(itemName);
		versus.setReturnRate(returnRate);
		versus.setBetAmountMin(betAmountMin);
		versus.setBetAmountMax(betAmountMax);
		versus.setStartTime(startTime == null ? new Date() : startTime);
		versus.setBetPause(true);
		versus.setSuperVersusId(superVersusId);

		//生成versusItem对象列表
		List<NewGuessVersusItem> versusItemList = new ArrayList<NewGuessVersusItem>();
		for(String item : versusItems) {
			String[] strs = item.split("\\|");
			String versusItemName = strs[0];
			String versusItemOdds = strs[1];
			String versusItemFixedOdds = strs[2];
			String versusItemChangeOddsMin = strs[3];
			String versusItemChangeOddsMax = strs[4];
			NewGuessVersusItem versusItem = new NewGuessVersusItem();
			versusItem.setName(versusItemName);
			versusItem.setFixedOdds(Boolean.parseBoolean(versusItemFixedOdds));
			versusItem.setOdds(Double.parseDouble(versusItemOdds));
			versusItem.setChangeOddsMin(Double.parseDouble(versusItemChangeOddsMin));
			versusItem.setChangeOddsMax(Double.parseDouble(versusItemChangeOddsMax));
			versusItemList.add(versusItem);
		}
		ngvs.addVersus(versus, versusItemList);
		ngvs.checkStart(versus);
		return new ResponseObject(100, "添加成功");
	}
	
	//对阵分页查询
	@RequestMapping("/versusList")
	public ResponseObject versusList(@RequestParam(defaultValue="20") int pageSize,
			                         @RequestParam(defaultValue="1") int pageNo,
			                         @RequestParam(defaultValue="5") int showCount,
			                         Integer itemId,
			                         NewGuessVersusStatus status,
			                         @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTimeStart,
			                         @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTimeEnd) {
		QueryCondition qc = new QueryCondition();
		qc.addCondition("superVersusId", "=", 0);
		if(itemId != null) {
			qc.addCondition("itemId", "=", itemId);
		}
		if(status != null) {
			qc.addCondition("status", "=", status);
		}
		if(startTimeStart != null) {
			qc.addCondition("startTime", ">=", startTimeStart);
		}
		if(startTimeEnd != null) {
			qc.addCondition("startTime", "<=", startTimeEnd);
		}
		qc.addSort("startTime", SortType.DESC);
		qc.setPage(new Page(pageSize, pageNo, showCount));
		
		List<JsonResultMap> resultList = this.getVersusList(qc);
		Page page = qc.getPage(ngvs.getCount(qc));

		return new ResponseObject(100, "返回成功", new JsonResultMap().set("page", page).set("list", resultList));
	}
	
	//返回一个对阵下的所有子对阵
	@RequestMapping("/versusListBySuperVersusId")
	public ResponseObject versusListBySuperVersusId(@RequestParam int superVersusId) {
		QueryCondition qc = new QueryCondition();
		qc.addCondition("superVersusId", "=", superVersusId);
		List<JsonResultMap> resultList = this.getVersusList(qc);
		return new ResponseObject(100, "返回成功", resultList);
	}
	
	//返回一个对阵下的所有竞猜项
	@RequestMapping("/versusItemByVersusId")
	public ResponseObject versusItemByVersusId(@RequestParam int versusId) {
		List<NewGuessVersusItem> versusItemList = ngvis.query(new QueryCondition().addCondition("versusId", "=", versusId));
		return new ResponseObject(100, "返回成功", versusItemList);
	}
	
	private List<JsonResultMap> getVersusList(QueryCondition qc) {
		List<JsonResultMap> resultList = new ArrayList<JsonResultMap>();
		List<NewGuessVersus> list = ngvs.query(qc);
		for(NewGuessVersus versus : list) {
			JsonResultMap map = new JsonResultMap();
			map.put("versus", versus);
			map.put("versusItemList", ngvis.query(new QueryCondition().addCondition("versusId", "=", versus.getId())));
			resultList.add(map);
		}
		return resultList;
	}
}