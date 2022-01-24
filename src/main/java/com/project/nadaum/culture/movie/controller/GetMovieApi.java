package com.project.nadaum.culture.movie.controller;

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
@RequestMapping("/movie")
public class GetMovieApi {

    // tag값의 정보를 가져오는 메소드
	private static String getTagValue(String tag, Element eElement) {
		//
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}
	
	
	//영화API
	@GetMapping("/movieList.do")
	public void getMovieApi(Model model) {
		int page = 1;

		List<Object> list = new ArrayList<>();
			try {
				
			while(true){
				// parsing할 url 지정(API 키 포함해서)
				
//				영화목록api
				String url = "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.xml"
						+ "?key=2707c14a032dacdea9d8b690c3f99d19"
						+ "&itemPerPage"
						+ "&curPage="+page;
				
								
				DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
				Document doc = dBuilder.parse(url);
				
				// root tag 
				doc.getDocumentElement().normalize();
//				System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
				//최상위tag값
				//result - products - product - baseinfo
				
				// 파싱할 tag
				NodeList nList = doc.getElementsByTagName("movie");
//				NodeList nList2 = doc.getElementsByTagName("director");
//				System.out.println("파싱할 리스트 수 : "+ nList.getLength());
				
				for(int temp = 0; temp < nList.getLength(); temp++){
					Node nNode = nList.item(temp);
					Node nnNode = nList.item(temp);
					
					//
					if(nNode.getNodeType() == Node.ELEMENT_NODE){
						
						Element eElement = (Element) nNode;
						Element eElementt = (Element) nnNode;
						System.out.println("######################");						
//						System.out.println(eElement.getTextContent());
						
						//영화목록 api
						String movieCd = getTagValue("movieCd", eElement);
						String movieNm = getTagValue("movieNm", eElement);
						String prdtYear = getTagValue("prdtYear", eElement);
						String typeNm = getTagValue("typeNm", eElement);
						String nationAlt = getTagValue("nationAlt", eElement);
						String genreAlt = getTagValue("genreAlt", eElement);
//						String peopleNm = getTagValue("peopleNm", eElementt);
												
						Map<String, Object> map = new HashMap<>();
						map.put("movieCd", movieCd);
						map.put("movieNm", movieNm);
						map.put("prdtYear", prdtYear);
						map.put("typeNm", typeNm);
						map.put("nationAlt", nationAlt);
						map.put("genreAlt", nationAlt);
//						map.put("peopleNm", peopleNm);
						
																
						list.add(map);
						
						log.debug("list = {}", list);
						System.out.println(list);
					}	// if end
					
				}	// for end
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
	

	
}
	