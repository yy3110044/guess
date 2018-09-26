package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.UserBankAccount;
import com.yy.fast4j.QueryCondition;

public interface UserBankAccountService {
    void add(UserBankAccount obj);
    void delete(int id);
    void update(UserBankAccount obj);
    UserBankAccount find(QueryCondition qc);
    UserBankAccount findById(int id);
    List<UserBankAccount> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    int deleteAccount(int userBankAccountId, int userId);//删除一个银行帐号并返回剩余个数
}
