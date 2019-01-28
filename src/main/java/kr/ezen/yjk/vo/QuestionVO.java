package kr.ezen.yjk.vo;

import java.util.Date;

import lombok.Data;

@Data
public class QuestionVO {

	private int idx;
	private int fidx;
	private String qmemo;
	private Date qdate;
	private String temp1;
	
	//사람정보
	private String name;
	private String id;
	
	//Answer담기
	private int aidx; //본래값:answer의 idx
	private String amemo;
	private Date adate;
	
}
