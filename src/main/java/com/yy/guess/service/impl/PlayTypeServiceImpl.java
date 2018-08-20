package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.PlayTypeMapper;
import com.yy.guess.po.PlayType;
import com.yy.guess.service.PlayTypeService;
import com.yy.fast4j.QueryCondition;

@Repository("playTypeService")
@Transactional
public class PlayTypeServiceImpl implements PlayTypeService {
    @Autowired
    private PlayTypeMapper mapper;

    @Override
    public void add(PlayType obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
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
	public void addList(List<PlayType> ptList) {
		mapper.addList(ptList);
	}
}
