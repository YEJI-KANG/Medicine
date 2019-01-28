package kr.ezen.yjk.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class PrelistVO {

	private int idx;
	private int personidx;
	private Date predate;
	private String hospital;
	private int price;
	private String temp1; //수정,삭제시 idx 저장
	
	//추가
	private String name; //이름
	private String idnum1; //민번앞
	private String idnum2; //민번뒤
	private List<DrugVO> druglist;
	
}
