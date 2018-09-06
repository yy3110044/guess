package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.yy.guess.mapper.MatchVersusMapper;
import com.yy.guess.mapper.PlayTypeMapper;
import com.yy.guess.po.PlayType;
import com.yy.guess.service.PlayTypeService;
import com.yy.fast4j.QueryCondition;

@Repository("playTypeService")
@Transactional
public class PlayTypeServiceImpl implements PlayTypeService {
    @Autowired
    private PlayTypeMapper mapper;
    
    @Autowired
    private MatchVersusMapper mvm;

    @Override
    public void add(PlayType obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
    	PlayType pt = mapper.findById(id);
        mapper.delete(id);
        if(pt != null) {
        	mvm.plusPlayTypeCount(-1, pt.getVersusId());//更新versus中的玩法数
        }
    }

    @Override
    public void update(PlayType obj) {
        mapper.update(obj);
    }

    @Override
    public PlayType find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public PlayType findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<PlayType> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

	@Override
	public void addList(List<PlayType> ptList, int versusId) {
		mapper.addList(ptList);
		mvm.plusPlayTypeCount(ptList.size(), versusId);//更新versus中的玩法数
	}

	@Override
	public void updateFixedOdds(boolean fixedOdds, double leftOdds, double rightOdds, int playTypeId) {
		mapper.updateFixedOdds(fixedOdds, leftOdds, rightOdds, playTypeId);
	}
}
