package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.User;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface UserMapper {
    void add(User obj);
    void delete(int id);
    void update(User obj);
    User find(QueryCondition qc);
    User findById(int id);
    List<User> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
