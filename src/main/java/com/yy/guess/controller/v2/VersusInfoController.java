package com.yy.guess.controller.v2;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.LoginManager;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.service.NewGuessItemService;
import com.yy.guess.service.NewGuessVersusItemService;
import com.yy.guess.service.NewGuessVersusService;
import com.yy.guess.service.UserService;
import com.yy.guess.util.QueryResult;

@CrossOrigin
@RestController
@RequestMapping(value="/v2", method=RequestMethod.POST)
public class VersusInfoController {
	@Resource
	private NewGuessVersusService ngvs;
	
	@Resource
	private NewGuessVersusItemService ngvis;

	@Resource
	private NewGuessItemService ngis;
	
	@Resource
	private UserService us;
	
	@Resource
	private LoginManager loginManager;

	//竞猜列表M
	@RequestMapping("/versusListM")
	public ResponseObject versusListM(@RequestParam(defaultValue="20") int pageSize,
            						  @RequestParam(defaultValue="1") int pageNo,
            						  @RequestParam(defaultValue="5") int showCount,
            						  @RequestParam int index,
            						  String date,//当index为3、4时需要此参数，例：2014-01-23
            						  HttpServletRequest req) {
		if(index == 1) {
			long startTime = Fast4jUtils.getEveryDayStartTime();
			return this.versusList(pageSize, pageNo, showCount, new Date(startTime), new Date(startTime + Fast4jUtils._24HoursMillis - 1), 0, req);
		} else if(index == 2) {
			return this.versusList(pageSize, pageNo, showCount, null, null, -1, req);
		} else if(index == 3) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				return this.versusList(pageSize, pageNo, showCount, sdf.parse(date + " 00:00:00"), sdf.parse(date + " 23:59:59"), -1, req);
			} catch (ParseException e) {
				return new ResponseObject(102, "date格式错误：" + date);
			}
		} else if(index == 4) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				return this.versusList(pageSize, pageNo, showCount, sdf.parse(date + " 00:00:00"), sdf.parse(date + " 23:59:59"), 1, req);
			} catch (ParseException e) {
				return new ResponseObject(102, "date格式错误：" + date);
			}
		} else {
			return new ResponseObject(101, "未知的index：" + index);
		}
	}
	
	//竞猜列表
	@RequestMapping("/versusList")
	public ResponseObject versusList(@RequestParam(defaultValue="20") int pageSize,
                                     @RequestParam(defaultValue="1") int pageNo,
                                     @RequestParam(defaultValue="5") int showCount,
                                     @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTimeStart,
                                     @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTimeEnd,
                                     @RequestParam int status,/*-1：取未结束，0：取全部，1：取已结束*/
                                     HttpServletRequest req) {
		String[] itemIds = req.getParameterValues("itemIds[]");
		List<Integer> itemIdList = null;;
		if(itemIds != null && itemIds.length > 0) {
			itemIdList = new ArrayList<Integer>();
			for(String itemId : itemIds) {
				itemIdList.add(Integer.valueOf(itemId));
			}
		}
		QueryResult<NewGuessVersus> result = ngvs.queryInItemId(itemIdList, status, startTimeStart, startTimeEnd, new Page(pageSize, pageNo, showCount));
		List<NewGuessVersus> versusList = result.getList();
		List<JsonResultMap> resultList = new ArrayList<JsonResultMap>();
		long current = System.currentTimeMillis();
		for(NewGuessVersus versus : versusList) {
			JsonResultMap map = new JsonResultMap();
			map.put("versus", versus);
			map.put("versusItemList", ngvis.query(new QueryCondition().addCondition("versusId", "=", versus.getId())));
			map.put("remainingTime", versus.getStartTime().getTime() - current);//剩余时间
			resultList.add(map);
		}
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", resultList).set("page", result.getPage()));
	}
	
	//返回赔率以及状态
	@RequestMapping("/getOddsAndStatus")
	public ResponseObject getOddsAndStatus(HttpServletRequest req) {
		String[] versusItemIdParams = req.getParameterValues("versusItemIds[]");
		if(versusItemIdParams != null && versusItemIdParams.length > 0) {
			int[] versusItemIds = new int[versusItemIdParams.length];
			for(int i=0; i<versusItemIdParams.length; i++) {
				versusItemIds[i] = Integer.parseInt(versusItemIdParams[i]);
			}
			JsonResultMap[] results = ngvs.getVersusItemStatusToCacheReturnArray(versusItemIds);
			return new ResponseObject(100, "返回成功", results);
		} else {
			return new ResponseObject(101, "versusItemIds不能为空");
		}
	}
	
	//根据versusItemId 返回 versus、versusItem
	@RequestMapping("/getVersusAndVersusItemByVersusItemId")
	public ResponseObject getVersusAndVersusItemByVersusItemId(@RequestParam int versusItemId, HttpServletRequest req) {
		JsonResultMap result = ngvs.getVersusAndVersusItemAndOddsToDatabase(versusItemId);
		double balance = 0;
		Integer userId = loginManager.getUserId(req);
		if(userId != null) {
			balance = us.getBalance(userId);
		}
		result.put("balance", balance);
		return new ResponseObject(100, "返回成功", result);
	}

	//返回所有项目
	@RequestMapping("/getAllItem")
	public ResponseObject getAllItem() {
		return new ResponseObject(100, "返回成功", ngis.query(null));
	}
}