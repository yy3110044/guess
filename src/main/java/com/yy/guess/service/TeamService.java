package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.Team;
import com.yy.fast4j.QueryCondition;

public interface TeamService {
    void add(Team obj);
    void delete(int id);
    void update(Team obj);
    Team find(QueryCondition qc);
    Team findById(int id);
    List<Team> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
