package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.NewGuessVersusItemMapper;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.guess.service.NewGuessVersusItemService;
import com.yy.fast4j.QueryCondition;

@Repository("newGuessVersusItemService")
@Transactional
public class NewGuessVersusItemServiceImpl implements NewGuessVersusItemService {
    @Autowired
    private NewGuessVersusItemMapper mapper;

    @Override
    public void add(NewGuessVersusItem obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(NewGuessVersusItem obj) {
        mapper.update(obj);
    }

    @Override
    public NewGuessVersusItem find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public NewGuessVersusItem findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<NewGuessVersusItem> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
