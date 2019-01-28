package kr.ezen.yjk.vo;

import lombok.Data;

@Data
public class FamilyVO {

	private int idx;
	private int personidx;
	private String id;
	private String password;
	private String phone;
	private String temp1; //로그인가능여부: 디폴트1 불가0
	
	//추가
	private String name; //이름
	private String idnum1; //민번앞
	private String idnum2; //민번뒤
	private int point; //민번뒤
	private int count;
}
