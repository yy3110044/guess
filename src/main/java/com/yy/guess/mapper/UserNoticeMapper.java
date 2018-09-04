package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.UserNotice;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface UserNoticeMapper {
    void add(UserNotice obj);
    void delete(int id);
    void update(UserNotice obj);
    UserNotice find(QueryCondition qc);
    UserNotice findById(int id);
    List<UserNotice> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
