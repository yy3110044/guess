package com.yy.guess.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
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
import com.yy.fast4j.QueryCondition;

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

    public static final Map<Integer, NewGuessVersus> versusMap = new ConcurrentHashMap<>();
    public static final Map<Integer, NewGuessVersusItem> versusItemMap = new ConcurrentHashMap<>();
    
    @Override
    @PostConstruct
    public void initCacheMap() {
    	versusMap.clear();
    	versusItemMap.clear();
    	List<NewGuessVersus> versusList = mapper.getAllUnEndVersus();
    	for(NewGuessVersus versus : versusList) {
    		versusMap.put(versus.getId(), versus);
    		List<NewGuessVersusItem> versusItemList = ngvim.query(new QueryCondition().addCondition("versusId", "=", versus.getId()));
    		for(NewGuessVersusItem versusItem : versusItemList) {
    			versusItemMap.put(versusItem.getId(), versusItem);
    		}
    	}
    	logger.info("初始化缓存，versus：" + versusMap.size() + "，versusItem：" + versusItemMap.size());
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
		versusMap.put(versus.getId(), versus);
		for(NewGuessVersusItem versusItem : versusItemList) {
			versusItemMap.put(versusItem.getId(), versusItem);
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
			
			NewGuessVersus superVersus = versusMap.get(versus.getSuperVersusId());
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
				versus = versusMap.get(versus.getId());
				if(versus != null) {
					versus.setBetPause(false);
					versus.setStatus(NewGuessVersusStatus.进行中);
				}
			}
		}
	}

	@Override
	public void cleanCache(int versusId) {
		versusMap.remove(versusId);
		List<Integer> versusItemIdList = ngvim.getVersusItemIdList(versusId);
		for(Integer versusItemId : versusItemIdList) {
			versusItemMap.remove(versusItemId);
		}
	}

	@Override
	public void updateBetPause(boolean betPause, int versusId) {
		NewGuessVersus versus = mapper.findById(versusId);
		if(versus != null) {
			if(versus.getStatus() == NewGuessVersusStatus.未开始 || versus.getStatus() == NewGuessVersusStatus.进行中) {
				mapper.updateBetPause(betPause, versusId);
				versus = versusMap.get(versusId);
				if(versus != null) {
					versus.setBetPause(betPause);
				}
			}
		}
	}

	@Override
	public NewGuessVersus getVersusCache(int versusId) {
		NewGuessVersus versus = versusMap.get(versusId);
		return versus;
	}

	@Override
	public List<NewGuessVersusItem> getVersusItemCacheByVersusId(int versusId) {
		List<Integer> versusItemIdList = ngvim.getVersusItemIdList(versusId);
		List<NewGuessVersusItem> versusItemList = new ArrayList<NewGuessVersusItem>();
		for(Integer versusItemId : versusItemIdList) {
			NewGuessVersusItem versusItem = versusItemMap.get(versusItemId);
			if(versusItem != null) {
				versusItemList.add(versusItem);
			}
		}
		return versusItemList;
	}

	@Override
	public NewGuessVersusItem getVersusItemCache(int versusItemId) {
		NewGuessVersusItem versusItem = versusItemMap.get(versusItemId);
		return versusItem;
	}
}