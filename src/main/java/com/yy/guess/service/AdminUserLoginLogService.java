package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.AdminUserLoginLog;
import com.yy.fast4j.QueryCondition;

public interface AdminUserLoginLogService {
    void add(AdminUserLoginLog obj);
    void delete(int id);
    void update(AdminUserLoginLog obj);
    AdminUserLoginLog find(QueryCondition qc);
    AdminUserLoginLog findById(int id);
    List<AdminUserLoginLog> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/

    void addLog(AdminUserLoginLog log);
}
