package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import com.yy.guess.po.UserWithdrawal;
import com.yy.guess.po.enums.UserWithdrawalStatus;
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
    @Update("update guess_user_withdrawal set status = #{status}, remark = #{remark} where id = #{withdrawalId}")
    void updateStatus(UserWithdrawalStatus status, String remark, int withdrawalId);
}
