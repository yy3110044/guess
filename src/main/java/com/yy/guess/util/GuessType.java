package com.yy.guess.util;

/**
 * 竞猜类型
 * @author yy
 *
 */
public enum GuessType {
	WINNER,
	WINNER1,
	WINNER2,
	WINNER3,
	WINNER4,
	WINNER5,
	
	FIRSTKILLTEAM1,
	FIRSTKILLTIME1,
	TENTHKILLTEAM1,
	TENTHKILLTIME1,
	
	FIRSTKILLTEAM2,
	FIRSTKILLTIME2,
	TENTHKILLTEAM2,
	TENTHKILLTIME2,
	
	FIRSTKILLTEAM3,
	FIRSTKILLTIME3,
	TENTHKILLTEAM3,
	TENTHKILLTIME3,
	
	FIRSTKILLTEAM4,
	FIRSTKILLTIME4,
	TENTHKILLTEAM4,
	TENTHKILLTIME4,
	
	FIRSTKILLTEAM5,
	FIRSTKILLTIME5,
	TENTHKILLTEAM5,
	TENTHKILLTIME5,
	
	ALLCOUNT; //总局数

	@Override
	public String toString() {
		switch(this) {
		case WINNER: return "胜者";
		case WINNER1: return "第一局胜者";
		case WINNER2: return "第二局胜者";
		case WINNER3: return "第三局胜者";
		case WINNER4: return "第四局胜者";
		case WINNER5: return "第五局胜者";
		
		case FIRSTKILLTEAM1: return "第一局首杀(一血)";
		case FIRSTKILLTIME1: return "第一局首杀(一血)时间";
		case TENTHKILLTEAM1: return "第一局十杀";
		case TENTHKILLTIME1: return "第一局十杀时间";
		
		case FIRSTKILLTEAM2: return "第二局局首杀(一血)";
		case FIRSTKILLTIME2: return "第二局首杀(一血)时间";
		case TENTHKILLTEAM2: return "第二局十杀";
		case TENTHKILLTIME2: return "第二局十杀时间";
		
		case FIRSTKILLTEAM3: return "第三局首杀(一血)";
		case FIRSTKILLTIME3: return "第三局首杀(一血)时间";
		case TENTHKILLTEAM3: return "第三局十杀";
		case TENTHKILLTIME3: return "第三局十杀时间";
		
		case FIRSTKILLTEAM4: return "第四局首杀(一血)";
		case FIRSTKILLTIME4: return "第四局首杀(一血)时间";
		case TENTHKILLTEAM4: return "第四局十杀";
		case TENTHKILLTIME4: return "第四局十杀时间";
		
		case FIRSTKILLTEAM5: return "第五局首杀(一血)";
		case FIRSTKILLTIME5: return "第五局首杀(一血)时间";
		case TENTHKILLTEAM5: return "第五局十杀";
		case TENTHKILLTIME5: return "第五局十杀时间";
		
		case ALLCOUNT: return "总局数";

		default: throw new RuntimeException("无效的enum");
		}
	}
}