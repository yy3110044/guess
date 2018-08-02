package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.MatchVersusBo;
import com.yy.fast4j.QueryCondition;

public interface MatchVersusBoService {
    void add(MatchVersusBo obj);
    void delete(int id);
    void update(MatchVersusBo obj);
    MatchVersusBo find(QueryCondition qc);
    MatchVersusBo findById(int id);
    List<MatchVersusBo> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
