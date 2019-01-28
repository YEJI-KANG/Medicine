package kr.ezen.yjk.vo;

import java.util.Date;

import lombok.Data;

@Data
public class WithdrawalVO {

	private int idx;
	private Date wdate;
	private int fidx;
	private int personidx;
	private String password;
	private String phone;
	private String temp1;

}
