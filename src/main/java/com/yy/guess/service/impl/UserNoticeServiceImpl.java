package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.UserNoticeMapper;
import com.yy.guess.po.UserNotice;
import com.yy.guess.service.UserNoticeService;
import com.yy.fast4j.QueryCondition;

@Repository("userNoticeService")
@Transactional
public class UserNoticeServiceImpl implements UserNoticeService {
    @Autowired
    private UserNoticeMapper mapper;

    @Override
    public void add(UserNotice obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(UserNotice obj) {
        mapper.update(obj);
    }

    @Override
    public UserNotice find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public UserNotice findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<UserNotice> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
