package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.yy.guess.po.SystemNotice;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface SystemNoticeMapper {
    void add(SystemNotice obj);
    void delete(int id);
    void update(SystemNotice obj);
    SystemNotice find(QueryCondition qc);
    SystemNotice findById(int id);
    List<SystemNotice> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    
    @Select("select max(top) from guess_system_notice")
    Integer getMaxTop();
    
    @Update("update guess_system_notice set top = #{top} where id = #{systemNoticeId}")
    void setTop(int top, int systemNoticeId);
}