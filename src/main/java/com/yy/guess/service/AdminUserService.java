package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.AdminUser;
import com.yy.fast4j.QueryCondition;

public interface AdminUserService {
    void add(AdminUser obj);
    void delete(int id);
    void update(AdminUser obj);
    AdminUser find(QueryCondition qc);
    AdminUser findById(int id);
    List<AdminUser> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
