package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.NewGuessBet;
import com.yy.guess.po.enums.NewGuessBetStatus;
import com.yy.fast4j.QueryCondition;

public interface NewGuessBetService {
    void add(NewGuessBet obj);
    void delete(int id);
    void update(NewGuessBet obj);
    NewGuessBet find(QueryCondition qc);
    NewGuessBet findById(int id);
    List<NewGuessBet> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    List<Integer> getBetIdList(int versusId, NewGuessBetStatus status);
    void settlement(int betId); //结算
    void refund(String description, int betId); //退款
}
