package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.yy.guess.po.PlayType;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface PlayTypeMapper {
    void add(PlayType obj);
    void delete(int id);
    void update(PlayType obj);
    PlayType find(QueryCondition qc);
    PlayType findById(int id);
    List<PlayType> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    
    void deleteByVersusId(int versusId);
    void addList(@Param("ptList") List<PlayType> ptList);

    @Update("update guess_play_type set guessStart = #{guessStart} where id = #{playTypeId}")
    void updateGuessStartByPlayTypeId(boolean guessStart, int playTypeId);
    
    @Update("update guess_play_type set guessStart = #{guessStart} where versusId = #{versusId}")
    void updateGuessStartByVersusId(boolean guessStart, int versusId);
}
