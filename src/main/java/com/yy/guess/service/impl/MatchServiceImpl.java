package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.MatchMapper;
import com.yy.guess.po.Match;
import com.yy.guess.service.MatchService;
import com.yy.fast4j.QueryCondition;

@Repository("matchService")
@Transactional
public class MatchServiceImpl implements MatchService {
    @Autowired
    private MatchMapper mapper;

    @Override
    public void add(Match obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(Match obj) {
        mapper.update(obj);
    }

    @Override
    public Match find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public Match findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<Match> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
