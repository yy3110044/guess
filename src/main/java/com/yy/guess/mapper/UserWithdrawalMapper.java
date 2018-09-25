package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.UserWithdrawal;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface UserWithdrawalMapper {
    void add(UserWithdrawal obj);
    void delete(int id);
    void update(UserWithdrawal obj);
    UserWithdrawal find(QueryCondition qc);
    UserWithdrawal findById(int id);
    List<UserWithdrawal> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
