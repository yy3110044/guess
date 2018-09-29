package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.PayOrder;
import com.yy.fast4j.QueryCondition;

public interface PayOrderService {
    void add(PayOrder obj);
    void delete(String id);
    void update(PayOrder obj);
    PayOrder find(QueryCondition qc);
    PayOrder findById(String id);
    List<PayOrder> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
