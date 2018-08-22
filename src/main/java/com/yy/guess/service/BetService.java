package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.Bet;
import com.yy.fast4j.QueryCondition;

public interface BetService {
    void add(Bet obj);
    void delete(int id);
    void update(Bet obj);
    Bet find(QueryCondition qc);
    Bet findById(int id);
    List<Bet> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
