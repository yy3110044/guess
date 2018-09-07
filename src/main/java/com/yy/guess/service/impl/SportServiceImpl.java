package com.yy.guess.service.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.SportMapper;
import com.yy.guess.po.Sport;
import com.yy.guess.service.SportService;
import com.yy.fast4j.QueryCondition;

@Repository("sportService")
@Transactional
public class SportServiceImpl implements SportService {
    @Autowired
    private SportMapper mapper;

    @Override
    public void add(Sport obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(Sport obj) {
        mapper.update(obj);
    }

    @Override
    public Sport find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public Sport findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<Sport> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

	@Override
	public List<Sport> queryInSportId(List<Integer> ids) {
		if(ids != null && ids.size() > 0) {
			return mapper.queryInSportId(ids);
		} else {
			return new ArrayList<Sport>();
		}
	}
}
