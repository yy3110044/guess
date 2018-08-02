package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.TeamMapper;
import com.yy.guess.po.Team;
import com.yy.guess.service.TeamService;
import com.yy.fast4j.QueryCondition;

@Repository("teamService")
@Transactional
public class TeamServiceImpl implements TeamService {
    @Autowired
    private TeamMapper mapper;

    @Override
    public void add(Team obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(Team obj) {
        mapper.update(obj);
    }

    @Override
    public Team find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public Team findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<Team> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
