package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.UserLoginLog;
import com.yy.fast4j.QueryCondition;

public interface UserLoginLogService {
    void add(UserLoginLog obj);
    void delete(int id);
    void update(UserLoginLog obj);
    UserLoginLog find(QueryCondition qc);
    UserLoginLog findById(int id);
    List<UserLoginLog> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/

    void addLog(UserLoginLog log);
}
