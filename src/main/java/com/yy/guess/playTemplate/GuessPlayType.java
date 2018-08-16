package com.yy.guess.playTemplate;

public enum GuessPlayType {
	胜负,
	第一局胜负,
	第二局胜负,
	第三局胜负,
	第四局胜负,
	第五局胜负,
	
	第一局首杀,
	第一局首杀时间,
	第一局十杀,
	第一局十杀时间,
	
	第二局首杀,
	第二局首杀时间,
	第二局十杀,
	第二局十杀时间,
	
	第三局首杀,
	第三局首杀时间,
	第三局十杀,
	第三局十杀时间,
	
	第四局首杀,
	第四局首杀时间,
	第四局十杀,
	第四局十杀时间,
	
	第五局首杀,
	第五局首杀时间,
	第五局十杀,
	第五局十杀时间,
	
	总局数; //总局数

	@Override
	public String toString() {
		switch(this) {
		case 第一局首杀: return "第一局首杀(一血)";
		case 第二局首杀: return "第二局首杀(一血)";
		case 第三局首杀: return "第三局首杀(一血)";
		case 第四局首杀: return "第四局首杀(一血)";
		case 第五局首杀: return "第五局首杀(一血)";
		default: return super.toString();
		}
	}
	
	//返回此玩法对应的玩法模版
	public GuessPlayTemplate getPlayTemplate() {
		switch(this) {
		case 胜负:
		case 第一局胜负:
		case 第二局胜负:
		case 第三局胜负:
		case 第四局胜负:
		case 第五局胜负:
			return GuessPlayTemplateFactory.getGuessPlayTemplate(WinnerGuessPlayTemplate.class);
		case 第一局首杀:
		case 第二局首杀:
		case 第三局首杀:
		case 第四局首杀:
		case 第五局首杀:
		case 第一局十杀:
		case 第二局十杀:
		case 第三局十杀:
		case 第四局十杀:
		case 第五局十杀:
			return GuessPlayTemplateFactory.getGuessPlayTemplate(KillerGuessPlayTemplate.class);
		default: return null;
		}
	}
	
	//返回此玩法对应的比赛场次，零代表总对阵，-1代表没有
	public int getBo() {
		switch(this) {
		case 胜负: return 0;
		case 第一局胜负: return 1;
		case 第二局胜负: return 2;
		case 第三局胜负: return 3;
		case 第四局胜负: return 4;
		case 第五局胜负: return 5;
		default: return -1;
		}
	}
}