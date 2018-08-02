package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.MatchVersusMapper;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.service.MatchVersusService;
import com.yy.fast4j.QueryCondition;

@Repository("matchVersusService")
@Transactional
public class MatchVersusServiceImpl implements MatchVersusService {
    @Autowired
    private MatchVersusMapper mapper;

    @Override
    public void add(MatchVersus obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(MatchVersus obj) {
        mapper.update(obj);
    }

    @Override
    public MatchVersus find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public MatchVersus findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<MatchVersus> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
