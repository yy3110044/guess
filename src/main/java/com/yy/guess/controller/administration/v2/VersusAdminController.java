package com.yy.guess.controller.administration.v2;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.guess.service.NewGuessVersusItemService;
import com.yy.guess.service.NewGuessVersusService;

@CrossOrigin
@RestController
@RequestMapping(value="/administration/v2/versusAdmin", method=RequestMethod.POST)
public class VersusAdminController {
	@Autowired
	private NewGuessVersusService ngvs;
	
	@RequestMapping("/versusAdd")
	public ResponseObject versusAdd(@RequestParam String name,
                                    @RequestParam String logoUrl,
                                    @RequestParam int itemId,
                                    @RequestParam String itemName,
                                    @RequestParam double returnRate,
                                    @RequestParam double betAmountMin,
                                    @RequestParam double betAmountMax,
                                    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTime,
                                    @RequestParam int superVersusId,
                                    HttpServletRequest req) {
		String[] versusItems = req.getParameterValues("versusItems[]");
		if(versusItems == null || versusItems.length < 2) {
			return new ResponseObject(101, "必须至少添加两个竞猜项");
		}
		
		if(superVersusId > 0 && ngvs.findById(superVersusId) == null) {
			return new ResponseObject(102, "父对阵不存在");
		}
		
		//生成versus对象
		NewGuessVersus versus = new NewGuessVersus();
		versus.setName(name);
		versus.setLogoUrl(logoUrl);
		versus.setItemId(itemId);
		versus.setItemName(itemName);
		versus.setReturnRate(returnRate);
		versus.setBetAmountMin(betAmountMin);
		versus.setBetAmountMax(betAmountMax);
		versus.setStartTime(startTime == null ? new Date() : startTime);
		versus.setBetPause(true);
		versus.setSuperVersusId(superVersusId);

		//生成versusItem对象列表
		List<NewGuessVersusItem> versusItemList = new ArrayList<NewGuessVersusItem>();
		for(String item : versusItems) {
			String[] strs = item.split("\\|");
			String versusItemName = strs[0];
			String versusItemOdds = strs[1];
			String versusItemFixedOdds = strs[2];
			String versusItemChangeOddsMin = strs[3];
			String versusItemChangeOddsMax = strs[4];
			NewGuessVersusItem versusItem = new NewGuessVersusItem();
			versusItem.setName(versusItemName);
			versusItem.setFixedOdds(Boolean.parseBoolean(versusItemFixedOdds));
			versusItem.setOdds(Double.parseDouble(versusItemOdds));
			versusItem.setChangeOddsMin(Double.parseDouble(versusItemChangeOddsMin));
			versusItem.setChangeOddsMax(Double.parseDouble(versusItemChangeOddsMax));
			versusItemList.add(versusItem);
		}
		ngvs.addVersus(versus, versusItemList);
		ngvs.checkStart(versus);
		return new ResponseObject(100, "添加成功");
	}
}