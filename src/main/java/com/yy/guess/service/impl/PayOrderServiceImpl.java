package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.PayOrderMapper;
import com.yy.guess.po.PayOrder;
import com.yy.guess.service.PayOrderService;
import com.yy.fast4j.QueryCondition;

@Repository("payOrderService")
@Transactional
public class PayOrderServiceImpl implements PayOrderService {
    @Autowired
    private PayOrderMapper mapper;

    @Override
    public void add(PayOrder obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(String id) {
        mapper.delete(id);
    }

    @Override
    public void update(PayOrder obj) {
        mapper.update(obj);
    }

    @Override
    public PayOrder find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public PayOrder findById(String id) {
        return mapper.findById(id);
    }

    @Override
    public List<PayOrder> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
