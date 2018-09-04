package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.UserMapper;
import com.yy.guess.po.User;
import com.yy.guess.service.UserService;
import com.yy.fast4j.QueryCondition;

@Repository("userService")
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper mapper;

    @Override
    public void add(User obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(User obj) {
        mapper.update(obj);
    }

    @Override
    public User find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public User findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<User> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

	@Override
	public double getBalance(int userId) {
		Double balance = mapper.getBalance(userId);
		return balance != null ? balance : 0;
	}

	@Override
	public void updateInfo(String nickName, String qq, String phone, String email, int userId) {
		mapper.updateInfo(nickName, qq, phone, email, userId);
	}

	@Override
	public void updateRebateRate(double rebateRate, int userId) {
		mapper.updateRebateRate(rebateRate, userId);
		mapper.updateSubordinateDefaultRebateRate(rebateRate, userId);
	}

	@Override
	public int getUserIdByUserName(String userName) {
		Integer userId = mapper.getUserIdByUserName(userName);
		return userId == null ? 0 : userId;
	}
}
