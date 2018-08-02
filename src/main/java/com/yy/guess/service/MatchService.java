package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.Match;
import com.yy.fast4j.QueryCondition;

public interface MatchService {
    void add(Match obj);
    void delete(int id);
    void update(Match obj);
    Match find(QueryCondition qc);
    Match findById(int id);
    List<Match> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
