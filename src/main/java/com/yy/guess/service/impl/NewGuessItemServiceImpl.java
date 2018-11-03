package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.NewGuessItemMapper;
import com.yy.guess.po.NewGuessItem;
import com.yy.guess.service.NewGuessItemService;
import com.yy.fast4j.QueryCondition;

@Repository("newGuessItemService")
@Transactional
public class NewGuessItemServiceImpl implements NewGuessItemService {
    @Autowired
    private NewGuessItemMapper mapper;

    @Override
    public void add(NewGuessItem obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(NewGuessItem obj) {
        mapper.update(obj);
    }

    @Override
    public NewGuessItem find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public NewGuessItem findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<NewGuessItem> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
