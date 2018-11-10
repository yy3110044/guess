package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import com.yy.guess.po.NewGuessBet;
import com.yy.guess.po.enums.NewGuessBetStatus;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface NewGuessBetMapper {
    void add(NewGuessBet obj);
    void delete(int id);
    void update(NewGuessBet obj);
    NewGuessBet find(QueryCondition qc);
    NewGuessBet findById(int id);
    List<NewGuessBet> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/

    @Select("select id from new_guess_bet where versusId = #{versusId} and status = #{status}")
    List<Integer> getBetIdList(int versusId, NewGuessBetStatus status);
    
    @Update("update new_guess_bet set status = #{status}, payBonus = #{payBonus} where id = #{betId}")
    void updateStatusAndPayBonus(NewGuessBetStatus status, double payBonus, int betId);
    
    @Update("update new_guess_bet set status = #{status} where id = #{betId}")
    void updateStatus(NewGuessBetStatus status, int betId);
}
