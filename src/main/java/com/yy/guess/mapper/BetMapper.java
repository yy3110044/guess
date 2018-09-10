package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;
import com.yy.guess.po.Bet;
import com.yy.guess.po.enums.BetStatus;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface BetMapper {
    void add(Bet obj);
    void delete(int id);
    void update(Bet obj);
    Bet find(QueryCondition qc);
    Bet findById(int id);
    List<Bet> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/

    @Update("update guess_bet set status = #{status} where id = #{betId}")
    void updateStatus(BetStatus status, int betId); //更改状态

    @Update("update guess_bet set status = #{status}, realPayBonus = #{realPayBonus} where id = #{betId}")
    void updateStatusAndRealPayBonus(BetStatus status, double realPayBonus, int betId);
}