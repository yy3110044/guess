package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.TradeFlow;
import com.yy.guess.po.enums.TradeType;
import com.yy.fast4j.QueryCondition;

public interface TradeFlowService {
    void add(TradeFlow obj);
    void delete(int id);
    void update(TradeFlow obj);
    TradeFlow find(QueryCondition qc);
    TradeFlow findById(int id);
    List<TradeFlow> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/

    //更改用户余额，返回是执行信息[0]为int代表返回代码，[1]为返回信息
    Object[] updateBalance(double amount, TradeType type, String description, int userId);
}
