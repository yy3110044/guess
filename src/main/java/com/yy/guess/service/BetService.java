package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.Bet;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.po.enums.BetStatus;
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
    
    Bet bet(int playTypeId, int userId, String userName, BetDirection betDirection, double betAmount);//下注
    
    void settlementOrRefund(int betId); //结算
    void settlement(int betId, PlayType playType); //结算
    void refund(int betId, String description); //退款
    List<Integer> getBetIdList(BetStatus status);
}