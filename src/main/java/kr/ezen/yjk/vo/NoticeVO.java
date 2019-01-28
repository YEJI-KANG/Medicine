package kr.ezen.yjk.vo;

import java.util.Date;
import lombok.Data;

@Data
public class NoticeVO {

	private int idx;
	private String title;
	private String context;
	private Date regdate;
	private int cnt;
	private String temp1;
	
	
}
