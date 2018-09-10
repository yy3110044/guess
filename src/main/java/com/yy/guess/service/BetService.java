package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.Bet;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.enums.BetDirection;
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
    
    boolean bet(int playTypeId, int userId, String userName, BetDirection betDirection, double betAmount);//下注
    
    void settlementOrRefund(Bet bet); //结算
    void settlement(Bet bet, MatchVersus versus, List<MatchVersusBo> boList); //结算
    void refund(Bet bet, String description); //退款
}