package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.UserNotice;
import com.yy.fast4j.QueryCondition;

public interface UserNoticeService {
    void add(UserNotice obj);
    void delete(int id);
    void update(UserNotice obj);
    UserNotice find(QueryCondition qc);
    UserNotice findById(int id);
    List<UserNotice> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
