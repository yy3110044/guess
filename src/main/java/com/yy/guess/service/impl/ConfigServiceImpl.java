package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.ConfigMapper;
import com.yy.guess.po.Config;
import com.yy.guess.service.ConfigService;
import com.yy.fast4j.QueryCondition;

@Repository("configService")
@Transactional
public class ConfigServiceImpl implements ConfigService {
    @Autowired
    private ConfigMapper mapper;

    @Override
    public void add(Config obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(Config obj) {
        mapper.update(obj);
    }

    @Override
    public Config find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public Config findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<Config> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
