package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.NewGuessVersusItemMapper;
import com.yy.guess.mapper.NewGuessVersusMapper;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.guess.po.enums.NewGuessVersusStatus;
import com.yy.guess.service.NewGuessVersusService;
import com.yy.guess.util.CachePre;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.RedisUtil;

@Repository("newGuessVersusService")
@Transactional
public class NewGuessVersusServiceImpl implements NewGuessVersusService {
    @Autowired
    private NewGuessVersusMapper mapper;
    
    @Autowired
    private NewGuessVersusItemMapper ngvim;
    
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

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
		RedisUtil.set(redisTemplate, CachePre.NEW_GUESS_VERSUS, String.valueOf(versus.getId()), versus);
		for(NewGuessVersusItem versusItem : versusItemList) {
			RedisUtil.set(redisTemplate, CachePre.NEW_GUESS_VERSUS_ITEM, String.valueOf(versusItem.getId()), versusItem);
		}
    }
    
    @Override
	public void deleteVersus(int versusId) {
    	NewGuessVersus versus = mapper.findById(versusId);//取出对阵对象
    	List<NewGuessVersus> childVersusList = mapper.query(new QueryCondition().addCondition("superVersusId", "=", versus.getId()));//取出子对阵列表

    	for(NewGuessVersus childVersus : childVersusList) {
    		deleteVersus(childVersus.getId()); //递归删除子对阵
    	}
    	
    	this.cleanCache(versusId); //先清除对阵缓存
    	mapper.delete(versusId); //删除对阵
		mapper.deleteBySuperVersusId(versusId); //删除对阵下的子对阵
		if(versus != null) {
			mapper.plusChildVersusCount(-1, versus.getSuperVersusId()); //把父对阵的子对阵数量减一
			NewGuessVersus superVersus = mapper.findById(versus.getSuperVersusId());
			if(superVersus != null) {
				RedisUtil.set(redisTemplate, CachePre.NEW_GUESS_VERSUS, String.valueOf(superVersus.getId()), superVersus);//更新父对阵缓存
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
				versus = mapper.findById(versus.getId());
				RedisUtil.set(redisTemplate, CachePre.NEW_GUESS_VERSUS, String.valueOf(versus.getId()), versus);
			}
		}
	}

	@Override
	public void cleanCache(int versusId) {
		RedisUtil.delete(redisTemplate, CachePre.NEW_GUESS_VERSUS, String.valueOf(versusId));
		List<NewGuessVersusItem> versusItemList = ngvim.query(new QueryCondition().addCondition("versusId", "=", versusId));
		for(NewGuessVersusItem versusItem : versusItemList) {
			RedisUtil.delete(redisTemplate, CachePre.NEW_GUESS_VERSUS_ITEM, String.valueOf(versusItem.getId()));
		}
	}

	@Override
	public void reset(int versusId) {
		mapper.reset(versusId);//重设对阵数据库
		NewGuessVersus versus = mapper.findById(versusId);
		if(versus != null) {
			RedisUtil.set(redisTemplate, CachePre.NEW_GUESS_VERSUS, String.valueOf(versus.getId()), versus); //更新缓存
		}
		ngvim.resetByVersusId(versusId);//重设竞猜项数据库
		List<NewGuessVersusItem> versusItemList = ngvim.query(new QueryCondition().addCondition("versusId", "=", versusId));
		for(NewGuessVersusItem versusItem : versusItemList) {
			RedisUtil.set(redisTemplate, CachePre.NEW_GUESS_VERSUS_ITEM, String.valueOf(versusItem.getId()), versusItem);
		}
	}
}