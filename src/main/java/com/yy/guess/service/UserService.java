package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.User;
import com.yy.fast4j.QueryCondition;

public interface UserService {
    void add(User obj);
    void delete(int id);
    void update(User obj);
    User find(QueryCondition qc);
    User findById(int id);
    List<User> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
