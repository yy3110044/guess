package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.NewGuessVersusMapper;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.service.NewGuessVersusService;
import com.yy.fast4j.QueryCondition;

@Repository("newGuessVersusService")
@Transactional
public class NewGuessVersusServiceImpl implements NewGuessVersusService {
    @Autowired
    private NewGuessVersusMapper mapper;

    @Override
    public void add(NewGuessVersus obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(NewGuessVersus obj) {
        mapper.update(obj);
    }

    @Override
    public NewGuessVersus find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public NewGuessVersus findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<NewGuessVersus> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
