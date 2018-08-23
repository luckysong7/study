package util;

public class MyUtil {

	// ����¡ ó��
	
	//��ü ������ ��
	public int getPageCount (int numPerPage, int dataCount){
		int pageCount = 0 ;
		pageCount = dataCount / numPerPage;
		
		if(dataCount % numPerPage != 0){
			pageCount ++;
		}
		return pageCount; // ��ü ������ �� 
	}
	
	//����¡ó�� �޼ҵ�
	// currentPage : ���� ǥ���� ������
	// totalPage : ��ü ���̽ü�
	// listUrl : ��ũ�� ������ url
	
	public String pageIndexList(int currentPage, int totalPage, String listUrl){
		
		int numPerBlock = 5;
		
		int currentPageSetup; // ǥ���� ù������ -1
		
		int page ;
		
		StringBuffer sb = new StringBuffer();
		
		if(currentPage == 0 || totalPage ==0){
			return "";
		}
		
		// list.jsp 
		// list.jsp?searchKey=subject&sarchValue='����' �� ��ܿ´�(get�������)
		
		if(listUrl.indexOf("?") != -1){
			listUrl = listUrl+ "&";
		}else{
			listUrl = listUrl+ "?";
		}
		
		//ǥ���� �������� -1�Ѱ�
		currentPageSetup = (currentPage/numPerBlock) * numPerBlock ;
		
		if(currentPage % numPerBlock ==0){
			currentPageSetup = currentPageSetup - numPerBlock;
		}
		
		//������
		
		if(totalPage > numPerBlock && currentPageSetup > 0){
			
			sb.append("<a href=\"" + listUrl + "pageNum=" + currentPageSetup + "\">������</a>&nbsp;");
			
		}
		
		//�ٷΰ��� ������
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
		
		// ������
		
		if(totalPage-currentPageSetup > numPerBlock){
			sb.append("<a href=\"" + listUrl + "pageNum=" + page + "\">������</a>&nbsp;");
			
			
		}
	
		return sb.toString();
	}
	
}