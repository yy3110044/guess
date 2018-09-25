package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.UserBankAccountMapper;
import com.yy.guess.po.UserBankAccount;
import com.yy.guess.service.UserBankAccountService;
import com.yy.fast4j.QueryCondition;

@Repository("userBankAccountService")
@Transactional
public class UserBankAccountServiceImpl implements UserBankAccountService {
    @Autowired
    private UserBankAccountMapper mapper;

    @Override
    public void add(UserBankAccount obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(UserBankAccount obj) {
        mapper.update(obj);
    }

    @Override
    public UserBankAccount find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public UserBankAccount findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<UserBankAccount> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
