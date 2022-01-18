package com.project.nadaum.culture.show.controller;

import java.util.Date;

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
public class GetTag {

    // tag값의 정보를 가져오는 메소드
	private static String getTagValue(String tag, Element eElement) {
		//
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}
	
	@GetMapping("/getTagValue.do")
	public void getTag(Model model) {
		int page = 1;
			try {
				
			while(true){
				// parsing할 url 지정(API 키 포함해서)
				String url = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period"
						+ "?serviceKey=p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D"
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
						String title = getTagValue("title", eElement);
						String startDate = getTagValue("startDate", eElement);
						String endDate = getTagValue("endDate", eElement);
						String area = getTagValue("area", eElement);
						String place = getTagValue("place", eElement);
						String thumbnail = getTagValue("thumbnail", eElement);
						String realmName = getTagValue("realmName", eElement);
						String gpsX = getTagValue("gpsX", eElement);
						String gpsY = getTagValue("gpsY", eElement);
						
						
//						log.debug("title = {}", title);
//						log.debug("starDate = {}", startDate);
//						log.debug("endDate = {}", endDate);
//						log.debug("area = {}", area);
//						log.debug("place = {}", place);
//						log.debug("thumbnail = {}", thumbnail);
//						log.debug("realmName = {}", realmName);
//						log.debug("gpsX = {}", gpsX);
//						log.debug("gpsY = {}", gpsY);
						
						model.addAttribute("title",title);
						model.addAttribute("startDate",startDate);
						model.addAttribute("endDate",endDate);
						model.addAttribute("area",area);
						model.addAttribute("place",place);
						model.addAttribute("thumbnail",thumbnail);
						model.addAttribute("realmName",realmName);
						model.addAttribute("gpsX",gpsX);
						model.addAttribute("startDate",startDate);
						
						System.out.println(model);
					}	// for end
				}	// if end
				
				page += 1;
				System.out.println("page number : "+page);
				if(page > 3){	
					break;
				}
			}	// while end
			
			} catch (Exception e){	
			e.printStackTrace();
		}	// try~catch end
	}
}
	

