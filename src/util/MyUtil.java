package util;

public class MyUtil {

	// 페이징 처리
	
	//전체 페이지 수
	public int getPageCount (int numPerPage, int dataCount){
		int pageCount = 0 ;
		pageCount = dataCount / numPerPage;
		
		if(dataCount % numPerPage != 0){
			pageCount ++;
		}
		return pageCount; // 전체 페이지 수 
	}
	
	//페이징처리 메소드
	// currentPage : 현재 표시할 페이지
	// totalPage : 전체 페이시수
	// listUrl : 링크를 설정할 url
	
	public String pageIndexList(int currentPage, int totalPage, String listUrl){
		
		int numPerBlock = 5;
		
		int currentPageSetup; // 표시할 첫페이지 -1
		
		int page ;
		
		StringBuffer sb = new StringBuffer();
		
		if(currentPage == 0 || totalPage ==0){
			return "";
		}
		
		// list.jsp 
		// list.jsp?searchKey=subject&sarchValue='수지' 에 담겨온다(get방식으로)
		
		if(listUrl.indexOf("?") != -1){
			listUrl = listUrl+ "&";
		}else{
			listUrl = listUrl+ "?";
		}
		
		//표시할 페이지에 -1한값
		currentPageSetup = (currentPage/numPerBlock) * numPerBlock ;
		
		if(currentPage % numPerBlock ==0){
			currentPageSetup = currentPageSetup - numPerBlock;
		}
		
		//◀이전
		
		if(totalPage > numPerBlock && currentPageSetup > 0){
			
			sb.append("<a href=\"" + listUrl + "pageNum=" + currentPageSetup + "\">◀이전</a>&nbsp;");
			
		}
		
		//바로가기 페이지
		page = currentPageSetup +1;
		while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
			
			if(page == currentPage){
				sb.append("<font color =\"Fuchsia\">" + page + "</font>&nbsp;");
				// <font color ="Fuchsia">page</font>&nbsp;
				
			}else{
				sb.append("<a href=\"" + listUrl + "pageNum="+page+"\">" + page + "</a>&nbsp;");
				
			}
//			System.out.println(sb.toString());
			page++;
			
		}
		
		// ▶다음
		
		if(totalPage-currentPageSetup > numPerBlock){
			sb.append("<a href=\"" + listUrl + "pageNum=" + page + "\">▶다음</a>&nbsp;");
			
			
		}
	
		return sb.toString();
	}
	
}
