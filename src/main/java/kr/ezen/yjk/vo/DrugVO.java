package kr.ezen.yjk.vo;

import lombok.Data;

@Data
public class DrugVO {

	private int idx;
	private int listidx;
	private String drugname;
	private String how;
	private String temp1;
	
	//추가
	private ApiVO druginfo;
}
