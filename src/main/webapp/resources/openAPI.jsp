<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%



String openAPI="http://apis.data.go.kr/1470000/MdcinGrnIdntfcInfoService/getMdcinGrnIdntfcInfoList?ServiceKey=jCzKvytIICvWIZFTlKCmLtCc5KQyMOavD92RVF75UK%2Fn2QaTW7Ju%2BZk3DMvRZE8ks1OLNNTX%2BMJUbiYGGUD58w%3D%3D&numOfRows=100&pageNo=1";
	
	//numOfRows=100&pageNo=209 마지막페이지
	
		Document doc = Jsoup.connect(openAPI).get();
		Elements elements = doc.select("item");
		//out.println(elements.size() + "개읽음");
		
		List<String> item_names = new ArrayList<String>();
		for(Element e : elements){
			Elements e2 = e.select("ITEM_NAME");
			item_names.add(e2.get(0).text());
		}
	
	
	/* Gson gson = new Gson();
	out.println(gson.toJson(item_names)); */
	
	String data = request.getParameter("value");	
	ArrayList<String> list = new ArrayList<String>();
	for(String s : item_names){
		if(s.contains(data)) list.add(s);
	}
	
	Gson gson = new Gson();
	out.println(gson.toJson(list));
%>

