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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/movie")
public class GetMovieDetailApi {
	
	
	/**
	 * elem 하위의 len개의 tagName을 찾아서 textContent를 문자열로 리턴
	 * 
	 * @param tagName
	 * @param elem
	 * @return
	 */
	// tag값의 정보를 가져오는 메소드
	//getTagValues -> 복수건 처리가능하게 메소드 변경
	private static String getTagValues(String tagName, Element elem) {
		//getElementsByTagName -> 직속자식뿐만 아니라 자식태그 탐색가능
		NodeList nodeList = elem.getElementsByTagName(tagName);
		int len = nodeList.getLength(); //검색한 태그의 글자 수 
		
		if(len == 0) return null; //NodeList의 글자수가 0개일시 null을 리턴.
		
		String[] tagArr = new String[len]; //태그 글자를 배열에 담음
		for(int i = 0; i < len; i++) {
			Node tagNameNode = nodeList.item(i); // tagName에 해당하는 node객체
			NodeList nList = tagNameNode.getChildNodes(); // tagName의 자식 컨텐츠
			Node contentNode = nList.item(0); // 텍스트노드
//			System.out.println(contentNode.getNodeType() == Element.TEXT_NODE); // true
			tagArr[i] = contentNode.getTextContent(); // 텍스트노드의 텍스트컨텐트를 tagarr에 담음.
		}
		
		return String.join(",", tagArr);
	}

	// 영화 상세정보API
	@GetMapping("/movieDetail?movieCd={movieCode}")
	public void getMovieDetailApi(@PathVariable String movieCode, Model model) {
		List<Object> list = new ArrayList<>();
		try {

			// parsing할 url 지정(API 키 포함해서)
			// 영화상세api
			String url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml"
					+ "?key=2707c14a032dacdea9d8b690c3f99d19" 
					+ "&movieCd="+ movieCode;

			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(url);

			doc.getDocumentElement().normalize();

			System.out.println("Root element : " + doc.getDocumentElement().getNodeName());

			Map<String, Object> map = new HashMap<>();
			
			NodeList nList = doc.getElementsByTagName("movieInfo");
			Node movieInfoNode = nList.item(0);
			//item(NodeList의 ) -> 컬렉션의 인덱스 항목을 반환합니다. index가 목록의 노드 수보다 크거나 같으면 null을 반환
			//log.debug("nList = {}",nList);

			// node가 tag element인 경우
			if (movieInfoNode.getNodeType() == Node.ELEMENT_NODE) {
				
				//getTagvalues메소드로 자식태그까지 탐색가능
				Element movieInfoElem = (Element) movieInfoNode;
				String movieCd = getTagValues("movieCd", movieInfoElem);
				String movieNm = getTagValues("movieNm", movieInfoElem);
				String openDt = getTagValues("openDt", movieInfoElem);
				String nationNm = getTagValues("nationNm", movieInfoElem);
				String genreNm = getTagValues("genreNm", movieInfoElem);
				
				System.out.println(nationNm); // 한국
				System.out.println(genreNm); // 사극, 드라마

				map.put("movieCd", movieCd);
				map.put("movieNm", movieNm);
				map.put("openDt", openDt);
				map.put("nation", nationNm);
				map.put("genreNm", genreNm);
				
				
				// 감독  directors > peopleNm
				NodeList directorsNodeList = movieInfoElem.getElementsByTagName("directors");
				Node directorsNode = directorsNodeList.item(0);
//				System.out.println(directorsNode.getNodeType() == Element.ELEMENT_NODE); // true
				Element directorsElem = (Element) directorsNode; // Element로 변환해야 탐색가능 getElementByXXX
				
				// 한줄 작성
//				Element directorsElem = (Element) movieInfoElem.getElementsByTagName("directors").item(0);
				String director = getTagValues("peopleNm", directorsElem);
				System.out.println(director);
				
				map.put("director",director);
				
				// 출연  actors > peopleNm
				Element actorsElem = (Element) movieInfoElem.getElementsByTagName("actors").item(0);
				String actors = getTagValues("peopleNm", actorsElem);
				System.out.println(actors);
				log.debug("map = {}" ,map);
				
				list.add(map);
				log.debug("list = {}" , list);
				model.addAttribute("list",list);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
