package com.yy.guess.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.yy.guess.service.BetService;

/**
 * 下注相关
 * @author 49803
 *
 */
@CrossOrigin
@RestController
@RequestMapping(value="/user", method=RequestMethod.POST)
public class BetController {
	@Autowired
	private BetService bs;
	
}