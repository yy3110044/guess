package com.yy.guess.controller.administration.v2;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
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
import com.yy.guess.po.enums.NewGuessBetStatus;
import com.yy.guess.po.enums.NewGuessVersusStatus;
import com.yy.guess.service.NewGuessBetService;
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
	
	@Resource
	private NewGuessBetService ngbs;
	
	//返回某个对阵
	@RequestMapping("/versusGet")
	public ResponseObject versusGet(@RequestParam int versusId) {
		NewGuessVersus versus = ngvs.findById(versusId);
		List<NewGuessVersusItem> versusItemList = ngvis.query(new QueryCondition().addCondition("versusId", "=", versusId));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("versus", versus).set("versusItemList", versusItemList));
	}
	
	//返回某个对阵的缓存
	@RequestMapping("/versusGetCache")
	public ResponseObject versusGetCache(@RequestParam int versusId) {
		NewGuessVersus versus = ngvs.getVersusCache(versusId);
		List<NewGuessVersusItem> versusItemList = ngvs.getVersusItemCacheByVersusId(versusId);
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("versus", versus).set("versusItemList", versusItemList));
	}
	
	//更新暂停状态
	@RequestMapping("/versusBetPauseUpdate")
	public ResponseObject versusBetPauseUpdate(@RequestParam boolean betPause, @RequestParam int versusId) {
		NewGuessVersus versus = ngvs.findById(versusId);
		if(versus == null) {
			return new ResponseObject(101, "对阵不存在");
		}
		if(versus.getStatus() == NewGuessVersusStatus.已结束 || versus.getStatus() == NewGuessVersusStatus.流局) {
			return new ResponseObject(102, "已结束的竞猜，请先重新开启");
		}
		ngvs.updateBetPause(betPause, versusId);
		return new ResponseObject(100, "更改状态成功");
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
			String versusItemUseFixedOdds = strs[2];
			String versusItemChangeOddsPlusStrategy = strs[3];
			String versusItemChangeOddsPlusValue = strs[4];
			String versusItemChangeOddsPlusRatio = strs[5];
			String versusItemChangeOddsMinusStrategy = strs[6];
			String versusItemChangeOddsMinusValue = strs[7];
			String versusItemChangeOddsMinusRatio = strs[8];
			String versusItemChangeOddsMin = strs[9];
			String versusItemChangeOddsMax = strs[10];
			
			NewGuessVersusItem versusItem = new NewGuessVersusItem();
			versusItem.setName(versusItemName);
			versusItem.setFixedOdds(Double.parseDouble(versusItemOdds));
			versusItem.setChangeOdds(Double.parseDouble(versusItemOdds));
			versusItem.setUseFixedOdds(Boolean.parseBoolean(versusItemUseFixedOdds));
			versusItem.setChangeOddsPlusRatio(Double.parseDouble(versusItemChangeOddsPlusRatio));
			versusItem.setChangeOddsPlusValue(Double.parseDouble(versusItemChangeOddsPlusValue));
			versusItem.setChangeOddsPlusStrategy(Integer.parseInt(versusItemChangeOddsPlusStrategy));
			versusItem.setChangeOddsMinusRatio(Double.parseDouble(versusItemChangeOddsMinusRatio));
			versusItem.setChangeOddsMinusValue(Double.parseDouble(versusItemChangeOddsMinusValue));
			versusItem.setChangeOddsMinusStrategy(Integer.parseInt(versusItemChangeOddsMinusStrategy));
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
			                         Integer versusId,
			                         Integer itemId,
			                         NewGuessVersusStatus status,
			                         @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTimeStart,
			                         @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTimeEnd) {
		QueryCondition qc = new QueryCondition();
		qc.addCondition("superVersusId", "=", 0);
		if(versusId != null) {
			qc.addCondition("id", "=", versusId);
		}
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
	
	//返回真实赔率
	@RequestMapping("/getRealOdds")
	public ResponseObject getRealOdds(HttpServletRequest req) {
		String[] versusItemIds = req.getParameterValues("versusItemIds[]");
		if(versusItemIds != null && versusItemIds.length > 0) {
			int[] versusItemIdsInt = new int[versusItemIds.length];
			for(int i=0; i<versusItemIds.length; i++) {
				versusItemIdsInt[i] = Integer.parseInt(versusItemIds[i]);
			}
			JsonResultMap[] result = ngvs.getVersusItemStatusToDatabaseReturnArray(versusItemIdsInt);
			return new ResponseObject(100, "返回成功", result);
		} else {
			return new ResponseObject(101, "versusItemId为空");
		}
	}
	
	//竞猜项修改
	@RequestMapping("/versusItemUpdate")
	public ResponseObject versusItemUpdate(@RequestParam int id,
                                           @RequestParam String name,
                                           @RequestParam boolean useFixedOdds,
                                           @RequestParam double fixedOdds,
                                           @RequestParam double changeOdds,
                                           @RequestParam int changeOddsPlusStrategy,
                                           @RequestParam double changeOddsPlusVal,
                                           @RequestParam int changeOddsMinusStrategy,
                                           @RequestParam double changeOddsMinusVal,
                                           @RequestParam double changeOddsMin,
                                           @RequestParam double changeOddsMax) {
		NewGuessVersusItem versusItem = ngvis.findById(id);
		if(versusItem == null) {
			return new ResponseObject(101, "竞猜项不存在");
		}
		versusItem.setName(name);
		versusItem.setUseFixedOdds(useFixedOdds);
		if(useFixedOdds) {
			versusItem.setFixedOdds(fixedOdds);
		} else {
			versusItem.setChangeOdds(changeOdds);
		}

		versusItem.setChangeOddsPlusStrategy(changeOddsPlusStrategy);
		if(changeOddsPlusStrategy > 0) {
			versusItem.setChangeOddsPlusValue(changeOddsPlusVal);
		} else if(changeOddsPlusStrategy < 0) {
			versusItem.setChangeOddsPlusRatio(changeOddsPlusVal);
		}
		
		versusItem.setChangeOddsMinusStrategy(changeOddsMinusStrategy);
		if(changeOddsMinusStrategy > 0) {
			versusItem.setChangeOddsMinusValue(changeOddsMinusVal);
		} else if(changeOddsMinusStrategy < 0) {
			versusItem.setChangeOddsMinusRatio(changeOddsMinusVal);
		}
		
		versusItem.setChangeOddsMin(changeOddsMin);
		versusItem.setChangeOddsMax(changeOddsMax);
		ngvis.update(versusItem);
		return new ResponseObject(100, "修改成功");
	}
	
	//修改某个versus下的所有竞猜项
	@RequestMapping("/versusItemUpdateByVersusId")
	public ResponseObject versusItemUpdateByVersusId(@RequestParam int versusId,
                                                     Boolean useFixedOdds,
                                                     Integer changeOddsPlusStrategy,
                                                     Double changeOddsPlusVal,
                                                     Integer changeOddsMinusStrategy,
                                                     Double changeOddsMinusVal,
                                                     Double changeOddsMin,
                                                     Double changeOddsMax) {
		List<NewGuessVersusItem> versusItemList = new ArrayList<NewGuessVersusItem>();
		List<Integer> versusItemIdList = ngvis.getVersusItemIdList(versusId);
		for(int versusItemId : versusItemIdList) {
			NewGuessVersusItem versusItem = ngvis.findById(versusItemId);
			if(versusItem != null) {
				if(useFixedOdds != null) {
					versusItem.setUseFixedOdds(useFixedOdds);
				}
				
				if(changeOddsPlusStrategy != null) {
					versusItem.setChangeOddsPlusStrategy(changeOddsPlusStrategy);
					if(changeOddsPlusVal != null) {
						if(changeOddsPlusStrategy > 0) {
							versusItem.setChangeOddsPlusValue(changeOddsPlusVal);
						} else if(changeOddsPlusStrategy < 0) {
							versusItem.setChangeOddsPlusRatio(changeOddsPlusVal);
						}
					}
				}
				
				if(changeOddsMinusStrategy != null) {
					versusItem.setChangeOddsMinusStrategy(changeOddsMinusStrategy);
					if(changeOddsMinusVal != null) {
						if(changeOddsMinusStrategy > 0) {
							versusItem.setChangeOddsMinusValue(changeOddsMinusVal);
						} else if(changeOddsMinusStrategy < 0) {
							versusItem.setChangeOddsMinusRatio(changeOddsMinusVal);
						}
					}
				}

				if(changeOddsMin != null) {
					versusItem.setChangeOddsMin(changeOddsMin);
				}
				if(changeOddsMax != null) {
					versusItem.setChangeOddsMax(changeOddsMax);
				}
				versusItemList.add(versusItem);
			}
		}
		ngvis.update(versusItemList);
		return new ResponseObject(100, "修改成功");
	}
	
	//删除某个竞猜项
	@RequestMapping("/versusItemDelete")
	public ResponseObject versusItemDelete(@RequestParam int versusItemId) {
		ngvis.delete(versusItemId);
		return new ResponseObject(100, "删除成功");
	}
	
	//修改versus
	@RequestMapping("/versusUpdate")
	public ResponseObject versusUpdate(@RequestParam int versusId,
                                       @RequestParam String name,
                                       @RequestParam double returnRate,
                                       @RequestParam double betAmountMin,
                                       @RequestParam double betAmountMax,
                                       @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") @RequestParam Date startTime) {
		NewGuessVersus versus = ngvs.findById(versusId);
		versus.setName(name);
		versus.setReturnRate(returnRate);
		versus.setBetAmountMin(betAmountMin);
		versus.setBetAmountMax(betAmountMax);
		versus.setStartTime(startTime);
		ngvs.update(name, returnRate, betAmountMin, betAmountMax, startTime, versusId);
		return new ResponseObject(100, "修改成功");
	}
	
	//重置versus
	@RequestMapping("/versusReset")
	public ResponseObject versusReset(@RequestParam int versusId) {
		ngvs.reset(versusId);
		return new ResponseObject(100, "重置成功");
	}
	
	//设置versus结果
	@RequestMapping("/versusSetResult")
	public ResponseObject versusSetResult(@RequestParam int resultItemId, @RequestParam int versusId) {
		ResponseObject ro = ngvs.updateResult(resultItemId, versusId);
		new Thread(new BetSettlementRunnable(versusId)).start();//开一个线程结算
		return ro;
	}
	
	@RequestMapping("/getVersusNamesByVersusIds")
	public ResponseObject getVersusNamesByVersusIds(HttpServletRequest req) {
		String[] versusIds = req.getParameterValues("versusIds[]");
		if(versusIds != null && versusIds.length > 0) {
			int[] versusIdsInt = new int[versusIds.length];
			for(int i=0; i<versusIds.length; i++) {
				versusIdsInt[i] = Integer.parseInt(versusIds[i]);
			}
			return new ResponseObject(100, "返回成功", ngvs.getVersusNamesByVersusIds(versusIdsInt));
		} else {
			return new ResponseObject(101, "versusIds为空");
		}
	}
	@RequestMapping("/getVersusItemNamesByVersusItemIds")
	public ResponseObject getVersusItemNamesByVersusItemIds(HttpServletRequest req) {
		String[] versusItemIds = req.getParameterValues("versusItemIds[]");
		if(versusItemIds != null && versusItemIds.length > 0) {
			int[] versusItemIdsInt = new int[versusItemIds.length];
			for(int i=0; i<versusItemIds.length; i++) {
				versusItemIdsInt[i] = Integer.parseInt(versusItemIds[i]);
			}
			return new ResponseObject(100, "返回成功", ngvis.getVersusItemNamesByVersusItemIds(versusItemIdsInt));
		} else {
			return new ResponseObject(101, "versusItemIds为空");
		}
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
	
	//bet结算线程类
	private class BetSettlementRunnable implements Runnable {
		private int versusId;
		BetSettlementRunnable(int versusId) {
			this.versusId = versusId;
		}
		@Override
		public void run() {
			List<Integer> betIdList = ngbs.getBetIdList(versusId, NewGuessBetStatus.未结算);
			for(int betId : betIdList) {
				ngbs.settlement(betId);//结算
			}
		}
	}
}