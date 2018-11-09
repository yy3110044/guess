package com.yy.guess.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.NewGuessVersusItemMapper;
import com.yy.guess.mapper.NewGuessVersusMapper;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.guess.po.enums.NewGuessVersusStatus;
import com.yy.guess.service.NewGuessVersusService;
import com.yy.guess.util.CachePre;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.ResponseObject;

@Repository("newGuessVersusService")
@Transactional
public class NewGuessVersusServiceImpl implements NewGuessVersusService {
	private static final Logger logger = LogManager.getLogger(NewGuessVersusServiceImpl.class);
    @Autowired
    private NewGuessVersusMapper mapper;
    
    @Autowired
    private NewGuessVersusItemMapper ngvim;
    
    @Override
    public NewGuessVersus find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public NewGuessVersus findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<NewGuessVersus> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

    @Override
    @PostConstruct
    public void initCacheMap() {
    	CachePre.versusMap.clear();
    	CachePre.versusItemMap.clear();
    	List<NewGuessVersus> versusList = mapper.getAllUnEndVersus();
    	for(NewGuessVersus versus : versusList) {
    		CachePre.versusMap.put(versus.getId(), versus);
    		List<NewGuessVersusItem> versusItemList = ngvim.query(new QueryCondition().addCondition("versusId", "=", versus.getId()));
    		for(NewGuessVersusItem versusItem : versusItemList) {
    			CachePre.versusItemMap.put(versusItem.getId(), versusItem);
    		}
    	}
    	logger.info("初始化缓存，versus：" + CachePre.versusMap.size() + "，versusItem：" + CachePre.versusItemMap.size());
    }
    
    @Override
	public void addVersus(NewGuessVersus versus, List<NewGuessVersusItem> versusItemList) {
		mapper.add(versus);
		if(versus.getSuperVersusId() > 0) {
			mapper.plusChildVersusCount(1, versus.getSuperVersusId());
		}
		for(NewGuessVersusItem versusItem : versusItemList) {
			versusItem.setVersusId(versus.getId());
		}
		ngvim.addList(versusItemList);
		
		//设置缓存
		versus = mapper.findById(versus.getId());
		versusItemList = ngvim.query(new QueryCondition().addCondition("versusId", "=", versus.getId()));
		CachePre.versusMap.put(versus.getId(), versus);
		for(NewGuessVersusItem versusItem : versusItemList) {
			CachePre.versusItemMap.put(versusItem.getId(), versusItem);
		}
    }
    
    @Override
	public void deleteVersus(int versusId) {
    	List<NewGuessVersus> childVersusList = mapper.query(new QueryCondition().addCondition("superVersusId", "=", versusId));//取出子对阵列表
    	for(NewGuessVersus childVersus : childVersusList) {
    		deleteVersus(childVersus.getId()); //递归删除子对阵
    	}
    	
    	NewGuessVersus versus = mapper.findById(versusId);//取出对阵对象

    	this.cleanCache(versusId); //先清除对阵缓存
    	mapper.delete(versusId); //删除对阵
		mapper.deleteBySuperVersusId(versusId); //删除对阵下的子对阵

		if(versus != null) {
			mapper.plusChildVersusCount(-1, versus.getSuperVersusId()); //把父对阵的子对阵数量减一
			
			NewGuessVersus superVersus = CachePre.versusMap.get(versus.getSuperVersusId());
			if(superVersus != null) {//更新缓存
				superVersus.setChildVersusCount(superVersus.getChildVersusCount() - 1);
			}
		}
		ngvim.deleteByVersusId(versusId);//删除竞猜项
	}

	@Override
	public void checkStart(NewGuessVersus versus) {
		if(versus.getStartTime() != null) {
			long current = System.currentTimeMillis();
			if(versus.getStatus() == NewGuessVersusStatus.未开始 && current >= versus.getStartTime().getTime()) {
				mapper.updateStatusAndBetPause(NewGuessVersusStatus.进行中, false, versus.getId());
				//更改缓存
				versus = CachePre.versusMap.get(versus.getId());
				if(versus != null) {
					versus.setBetPause(false);
					versus.setStatus(NewGuessVersusStatus.进行中);
				}
			}
		}
	}

	@Override
	public void cleanCache(int versusId) {
		CachePre.versusMap.remove(versusId);
		List<Integer> versusItemIdList = ngvim.getVersusItemIdList(versusId);
		for(Integer versusItemId : versusItemIdList) {
			CachePre.versusItemMap.remove(versusItemId);
		}
	}

	@Override
	public void updateBetPause(boolean betPause, int versusId) {
		NewGuessVersus versus = mapper.findById(versusId);
		if(versus != null) {
			if(versus.getStatus() == NewGuessVersusStatus.未开始 || versus.getStatus() == NewGuessVersusStatus.进行中) {
				mapper.updateBetPause(betPause, versusId);
				versus = CachePre.versusMap.get(versusId);
				if(versus != null) {
					versus.setBetPause(betPause);
				}
			}
		}
	}

	@Override
	public NewGuessVersus getVersusCache(int versusId) {
		NewGuessVersus versus = CachePre.versusMap.get(versusId);
		return versus;
	}

	@Override
	public List<NewGuessVersusItem> getVersusItemCacheByVersusId(int versusId) {
		List<Integer> versusItemIdList = ngvim.getVersusItemIdList(versusId);
		List<NewGuessVersusItem> versusItemList = new ArrayList<NewGuessVersusItem>();
		for(Integer versusItemId : versusItemIdList) {
			NewGuessVersusItem versusItem = CachePre.versusItemMap.get(versusItemId);
			if(versusItem != null) {
				versusItemList.add(versusItem);
			}
		}
		return versusItemList;
	}

	@Override
	public NewGuessVersusItem getVersusItemCache(int versusItemId) {
		NewGuessVersusItem versusItem = CachePre.versusItemMap.get(versusItemId);
		return versusItem;
	}

	@Override
	public JsonResultMap getVersusItemStatusToCache(int versusItemId) {
		NewGuessVersusItem versusItem = CachePre.versusItemMap.get(versusItemId);
		if(versusItem != null) {
			JsonResultMap result = new JsonResultMap();
			NewGuessVersus versus = CachePre.versusMap.get(versusItem.getVersusId());
			result.put("pause", versus.isBetPause());
			result.put("odds", versusItem.isUseFixedOdds() ? versusItem.getFixedOdds() * versus.getReturnRate() : versusItem.getChangeOdds() * versus.getReturnRate());
			return result;
		} else {
			return null;
		}
	}

	@Override
	public JsonResultMap getVersusItemStatusToCache(int[] versusItemIds) {
		JsonResultMap map = new JsonResultMap();
		for(int versusItemId : versusItemIds) {
			map.put(String.valueOf(versusItemId), this.getVersusItemStatusToCache(versusItemId));
		}
		return map;
	}

	@Override
	public JsonResultMap[] getVersusItemStatusToCacheReturnArray(int[] versusItemIds) {
		JsonResultMap[] result = new JsonResultMap[versusItemIds.length];
		for(int i=0; i<versusItemIds.length; i++) {
			result[i] = this.getVersusItemStatusToCache(versusItemIds[i]);
		}
		return result;
	}

	@Override
	public JsonResultMap getVersusItemStatusToDatabase(int versusItemId) {
		NewGuessVersusItem versusItem = ngvim.findById(versusItemId);
		if(versusItem != null) {
			JsonResultMap result = new JsonResultMap();
			NewGuessVersus versus = mapper.findById(versusItem.getVersusId());
			result.put("pause", versus.isBetPause());
			result.put("odds", versusItem.isUseFixedOdds() ? versusItem.getFixedOdds() * versus.getReturnRate() : versusItem.getChangeOdds() * versus.getReturnRate());
			return result;
		} else {
			return null;
		}
	}

	@Override
	public JsonResultMap getVersusItemStatusToDatabase(int[] versusItemIds) {
		JsonResultMap map = new JsonResultMap();
		for(int versusItemId : versusItemIds) {
			map.put(String.valueOf(versusItemId), this.getVersusItemStatusToDatabase(versusItemId));
		}
		return map;
	}

	@Override
	public JsonResultMap[] getVersusItemStatusToDatabaseReturnArray(int[] versusItemIds) {
		JsonResultMap[] result = new JsonResultMap[versusItemIds.length];
		for(int i=0; i<versusItemIds.length; i++) {
			result[i] = this.getVersusItemStatusToDatabase(versusItemIds[i]);
		}
		return result;
	}

	@Override
	public void update(String name, double returnRate, double betAmountMin, double betAmountMax, Date startTime, int versusId) {
		mapper.updateVersus(name, returnRate, betAmountMin, betAmountMax, startTime, versusId);
		NewGuessVersus versus = CachePre.versusMap.get(versusId);
		if(versus != null) { //更改缓存
			versus.setName(name);
			versus.setReturnRate(returnRate);
			versus.setBetAmountMin(betAmountMin);
			versus.setBetAmountMax(betAmountMax);
			versus.setStartTime(startTime);
		}
	}

	@Override
	public String getVersusNameByVersusId(int versusId) {
		return mapper.getVersusNameByVersusId(versusId);
	}

	@Override
	public String[] getVersusNamesByVersusIds(int[] versusIds) {
		String[] result = new String[versusIds.length];
		for(int i=0; i<versusIds.length; i++) {
			result[i] = mapper.getVersusNameByVersusId(versusIds[i]);
		}
		return result;
	}

	@Override
	public JsonResultMap[] getVersusNamesByVersusIdsReturnMap(int[] versusIds) {
		JsonResultMap[] result = new JsonResultMap[versusIds.length];
		for(int i=0; i<versusIds.length; i++) {
			result[i] = new JsonResultMap();
			result[i].put(String.valueOf(versusIds[i]), mapper.getVersusNameByVersusId(versusIds[i]));
		}
		return result;
	}

	@Override
	public ResponseObject updateResult(int resultItemId, int versusId) {
		NewGuessVersus versus = mapper.findById(versusId);
		if(versus == null) {
			return new ResponseObject(101, "竞猜不存在");
		}
		if(versus.getStatus() == NewGuessVersusStatus.已结束 || versus.getStatus() == NewGuessVersusStatus.流局) {
			return new ResponseObject(102, "竞猜已结束，不能更改结果");
		}
		if(resultItemId == 0) {
			return new ResponseObject(103, "结果不能为零");
		}
		if(resultItemId > 0) { //有结果
			NewGuessVersusItem versusItem = ngvim.find(new QueryCondition().addCondition("id", "=", resultItemId).addCondition("versusId", "=", versusId));
			if(versusItem == null) {
				return new ResponseObject(104, "结果不存在");
			}
			mapper.updateVersusResult(new Date(), true, resultItemId, versusItem.getName(), NewGuessVersusStatus.已结束, versusId);
		} else if(resultItemId < 0) {//流局
			mapper.updateVersusResult(new Date(), true, resultItemId, "流局", NewGuessVersusStatus.流局, versusId);
		}
		this.cleanCache(versusId);//清除缓存
		return new ResponseObject(100, "修改成功");
	}

	@Override
	public void reset(int versusId) {
		mapper.reset(versusId);
		ngvim.reset(versusId);
		NewGuessVersus versus = mapper.findById(versusId);
		List<NewGuessVersusItem> versusItemList = ngvim.query(new QueryCondition().addCondition("versusId", "=", versusId));
		CachePre.versusMap.put(versus.getId(), versus);
		for(NewGuessVersusItem versusItem : versusItemList) {
			CachePre.versusItemMap.put(versusItem.getId(), versusItem);
		}
	}
}