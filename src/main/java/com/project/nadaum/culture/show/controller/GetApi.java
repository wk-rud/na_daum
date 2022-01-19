package com.project.nadaum.culture.show.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/culture")
public class GetApi {

    // tag값의 정보를 가져오는 메소드
	private static String getTagValue(String tag, Element eElement) {
		//
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}
	
	
	//문화생활API
	@GetMapping("/cultureBoardList.do")
	public void getCultureApi(Model model) {
		int page = 1;

		List<Object> list = new ArrayList<>();
			try {
				
			while(true){
				// parsing할 url 지정(API 키 포함해서)
				String url = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period"
						+ "?serviceKey=p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D"
						+ "&rows=9"
						+ "&cPage="+page;
				
				DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
				Document doc = dBuilder.parse(url);
				
				// root tag 
				doc.getDocumentElement().normalize();
//				System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
				//최상위tag값
				//result - products - product - baseinfo
				
				// 파싱할 tag
				NodeList nList = doc.getElementsByTagName("perforList");
//				System.out.println("파싱할 리스트 수 : "+ nList.getLength());
				
				for(int temp = 0; temp < nList.getLength(); temp++){
					Node nNode = nList.item(temp);
					if(nNode.getNodeType() == Node.ELEMENT_NODE){
						
						Element eElement = (Element) nNode;
						System.out.println("######################");
						
//						System.out.println(eElement.getTextContent());
						String seq = getTagValue("seq", eElement);
						String title = getTagValue("title", eElement);
						String startDate = getTagValue("startDate", eElement);
						String endDate = getTagValue("endDate", eElement);
						String area = getTagValue("area", eElement);
						String place = getTagValue("place", eElement);
						String thumbnail = getTagValue("thumbnail", eElement);
						String realmName = getTagValue("realmName", eElement);
						String gpsX = getTagValue("gpsX", eElement);
						String gpsY = getTagValue("gpsY", eElement);
						
						Map<String, Object> map = new HashMap<>();
						map.put("seq", seq);
						map.put("title", title);
						map.put("startDate", startDate);
						map.put("endDate", endDate);
						map.put("area", area);
						map.put("place", place);
						map.put("thumbnail", thumbnail);
						map.put("realmName", realmName);
						map.put("gpsX", gpsX);
						map.put("gpsY", gpsY);
						
						
						list.add(map);
						
						System.out.println(list);
					}	// for end
					
				}	// if end
				model.addAttribute("list",list);
				page += 1;
				System.out.println("page number : "+page);
	
				if(page > 1){	
					break;
				}
			}	// while end
			
			} catch (Exception e){	
			e.printStackTrace();
		}	// try~catch end
	}
	
	//문화 상세정보API
	@GetMapping("/CultureDetail.do")
	public void getCultureDetailApi(Model model) {
			try {
				
				// parsing할 url 지정(API 키 포함해서)
				String url = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/"
						+ "?serviceKey=p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D"
						+ "&seq=173550";
				
				DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
				Document doc = dBuilder.parse(url);
				
				  doc.getDocumentElement().normalize();
				 
				  System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
				  
				  NodeList nList = doc.getElementsByTagName("perforInfo");
				  System.out.println(nList);
				  System.out.println("-----------------------");
				 
				  for (int temp = 0; temp < nList.getLength(); temp++) {
				 
				     Node nNode = nList.item(temp);
				     if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				 
				        Element eElement = (Element) nNode;
				 
				        System.out.println("title: " + getTagValue("title", eElement));
				 
				     }
				  }
				   } catch (Exception e) {
				  e.printStackTrace();
				   }
				  
				  
	}
}
	

