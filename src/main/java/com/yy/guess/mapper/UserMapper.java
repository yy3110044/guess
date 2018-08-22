package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
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

    @Select("select balance from guess_user where id = #{userId}")
    Double getBalance(int userId);
    
    @Update("update guess_user set balance = balance + #{amount} where id = #{userId}")
    void plusBalance(double amount, int userId);//加余额
    
    @Update("update guess_user set nickName = #{nickName}, qq = #{qq}, phone = #{phone}, email = #{email} where id = #{userId}")
    void updateInfo(String nickName, String qq, String phone, String email, int userId);

    @Update("update guess_user set rebateRate = #{rebateRate} where id = #{userId}")
    void updateRebateRate(double rebateRate, int userId);
    
    //根据rebateRate修改下级默认返点，一般根updateRebateRate()方法一起用
    @Update("update guess_user set subordinateDefaultRebateRate = #{rebateRate} where id = #{userId} and subordinateDefaultRebateRate > #{rebateRate}")
    void updateSubordinateDefaultRebateRate(double rebateRate, int userId);
}