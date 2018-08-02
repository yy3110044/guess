package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.AdminUser;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface AdminUserMapper {
    void add(AdminUser obj);
    void delete(int id);
    void update(AdminUser obj);
    AdminUser find(QueryCondition qc);
    AdminUser findById(int id);
    List<AdminUser> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
