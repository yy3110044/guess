package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.UserWithdrawal;
import com.yy.fast4j.QueryCondition;

public interface UserWithdrawalService {
    void add(UserWithdrawal obj);
    void delete(int id);
    void update(UserWithdrawal obj);
    UserWithdrawal find(QueryCondition qc);
    UserWithdrawal findById(int id);
    List<UserWithdrawal> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    void withdrawal(UserWithdrawal obj);
}
