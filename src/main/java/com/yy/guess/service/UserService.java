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

    double getBalance(int userId);
    void updateInfo(String nickName, String qq, String phone, String email, int userId);
    void updateRebateRate(double rebateRate, int userId);
    int getUserIdByUserName(String userName); //返回用户id，0代表无
}
