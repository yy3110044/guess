package com.yy.guess.mapper;

import java.util.Date;
import java.util.List;
import java.util.Set;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.enums.MatchStatus;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface MatchVersusMapper {
    void add(MatchVersus obj);
    void delete(int id);
    void update(MatchVersus obj);
    MatchVersus find(QueryCondition qc);
    MatchVersus findById(int id);
    List<MatchVersus> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    
    @Select("select distinct(name) from guess_match_versus where matchId = #{matchId}")
    List<String> getDistinctName(int matchId);
    
    @Update("update guess_match_versus set playTypeCount = playTypeCount + #{plus} where id = #{versusId}")
    void plusPlayTypeCount(int plus, int versusId);
    
    @Update("update guess_match_versus set status = #{status} where id = #{versusId}")
    void updateStatus(MatchStatus status, int versusId);
    
    @Update("update guess_match_versus set autoSwitchStatus = #{autoSwitchStatus} where id = #{versusId}")
    void updateAutoSwitchStatus(boolean autoSwitchStatus, int versusId);

    
    List<MatchVersus> queryInSportId(@Param("sportIdList") List<Integer> sportIdList,
                                     @Param("status") int status,
                                     @Param("startTime") Date startTime,
                                     @Param("endTime") Date endTime,
                                     @Param("page") Page page);
    
    int queryInSportIdCount(@Param("sportIdList") List<Integer> sportIdList,
    						@Param("status") int status,
    						@Param("startTime") Date startTime,
    						@Param("endTime") Date endTime);
    
    List<MatchVersus> queryInId(@Param("versusIdSet") Set<Integer> versusIdSet);
}