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
		
		@GetMapping("/getTagValue.do")
		public void getTag(Model model) {
			Map<String, Object> map = new HashMap();
			List<Map<Object, String>> list = new ArrayList();
			int page = 1;			
//			int itemPerPage = 10;			
				try {
					
				while(true){
					// parsing할 url 지정(API 키 포함해서)
					String url = "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.xml?"
							+ "key=2707c14a032dacdea9d8b690c3f99d19&itemPerPage=10";
//							+ "&curPage=" + page;
					
					DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
					DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
					Document doc = dBuilder.parse(url);
					
					// root tag 
					doc.getDocumentElement().normalize();
//					System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
					//최상위tag값
					//result - products - product - baseinfo
					
					// 파싱할 tag
					NodeList nList = doc.getElementsByTagName("movie");
//					System.out.println("파싱할 리스트 수 : "+ nList.getLength());
					
					for(int temp = 0; temp < nList.getLength(); temp++){
						Node nNode = nList.item(temp);
						if(nNode.getNodeType() == Node.ELEMENT_NODE){
							
							Element eElement = (Element) nNode;
							System.out.println("######################");
							
//							System.out.println(eElement.getTextContent());
							String movieCd = getTagValue("movieCd", eElement);
							String movieNm = getTagValue("movieNm", eElement);
							String prdtYear = getTagValue("prdtYear", eElement);
							String openDt = getTagValue("openDt", eElement);
							String typeNm = getTagValue("typeNm", eElement);
							String nationAlt = getTagValue("nationAlt", eElement);
							String genreAlt = getTagValue("genreAlt", eElement);
							String peopleNm = getTagValue("peopleNm", eElement);
										
							map.put("movieCd", movieCd);
							map.put("movieNm", movieNm);
							map.put("prdtYear", prdtYear);
							map.put("openDt", openDt);
							map.put("typeNm", typeNm);
							map.put("nationAlt", nationAlt);
							map.put("genreAlt", genreAlt);
							map.put("peopleNm", peopleNm);
							
//							list.add(map);
							
							System.out.println(map);
//							log.debug("movieCd = {}", movieCd);
//							log.debug("movieNm = {}", movieNm);
//							log.debug("prdtYear = {}", prdtYear);
//							log.debug("openDt = {}", openDt);
//							log.debug("typeNm = {}", typeNm);
//							log.debug("nationAlt = {}", nationAlt);
//							log.debug("genreAlt = {}", genreAlt);
//							log.debug("peopleNm = {}", peopleNm);
							
//							model.addAttribute("movieNm",movieNm);
//							model.addAttribute("prdtYear",prdtYear);
//							model.addAttribute("openDt",openDt);
//							model.addAttribute("typeNm",typeNm);
//							model.addAttribute("nationAlt",nationAlt);
//							model.addAttribute("genreAlt",genreAlt);
//							model.addAttribute("peopleNm",peopleNm);
							
							
						}	// for end
					}	// if end
					
					model.addAttribute("list",list);
//					page += 1;
//					System.out.println("page number : "+page);
//					if(page > 5){	
//						break;
//					}
				}	// while end
				
				} catch (Exception e){	
				e.printStackTrace();
			}	// try~catch end
		}
	}