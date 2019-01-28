package kr.ezen.yjk.vo;

import lombok.Data;

@Data
public class ApiVO {
	
	private String item_name; //약이름
	private String chart; //약생김새 서술
	private String item_image; //약이미지 링크
	private String class_name; //약 용도(분류)
		
}
