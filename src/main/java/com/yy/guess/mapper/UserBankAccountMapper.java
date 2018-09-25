package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.UserBankAccount;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface UserBankAccountMapper {
    void add(UserBankAccount obj);
    void delete(int id);
    void update(UserBankAccount obj);
    UserBankAccount find(QueryCondition qc);
    UserBankAccount findById(int id);
    List<UserBankAccount> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
