package com.board;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.http.HttpSession;

import com.join.CustomInfo;

import util.DBCPConn;
import util.MyUtil;

public class BoardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	// ���� ����ϴ� �޼ҵ� �����
	protected void forward(HttpServletRequest req, HttpServletResponse resp,
			String url) throws ServletException, IOException {

		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

//		req.setCharacterEncoding("UTF-8");
		String cp = req.getContextPath();

		Connection conn = DBCPConn.getConnection();
		BoardDAO dao = new BoardDAO(conn);

		MyUtil myUtil = new MyUtil();

		String url;

		String uri = req.getRequestURI();

		if (uri.indexOf("created.do") != -1) {

			HttpSession session = req.getSession();
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			
			if(info == null){
				url = "/member/login.jsp";
				forward(req, resp, url);
			}
			
			url = "/bbs/created.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("list.do") != -1) {

			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);

			}

			// �˻�
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchKey == null) {
				searchKey = "subject";
				searchValue = "";
			} else {
				if (req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}

			// ��ü �����Ͱ���
			int numPerPage = 5;

			int dataCount = dao.getDataCount(searchKey, searchValue);

			int totalPage = myUtil.getPageCount(numPerPage, dataCount);
			
			// ������ ��ü������������ ǥ���� �������� ū ��� 
			if(currentPage> totalPage){
				currentPage= totalPage;
			}
			
			// �������� ���۰� �� 
			int start = (currentPage-1)* numPerPage +1;
			int end = currentPage * numPerPage;
			
			List<BoardDTO> lists = dao.getLists(start, end, searchKey, searchValue);
			
			// ����¡ ó�� 
			String param = "";
			if(!searchValue.equals("")){
				param = "searchKey=" + searchKey;
				param += "&searchValue="+ URLEncoder.encode(searchValue, "UTF-8");
				
			}
			String listUrl = cp + "/sboard/list.do";
			
			if(!param.equals("")){
				listUrl = listUrl + "?" +param;
				
			}
			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			
			//�ۺ����ּ�
			String articleUrl = cp + "/sboard/article.do?pageNum=" + currentPage;
			
			if(!param.equals("")){
				articleUrl = articleUrl + "&" + param;
			}
			
			//������ �������� ������ ���� 
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("articleUrl", articleUrl);
			
			url = "/bbs/list.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("created_ok.do") != -1) {
			BoardDTO dto = new BoardDTO();
			int maxNum = dao.getMaxNum();
			dto.setNum(maxNum + 1);
			dto.setName(req.getParameter("name"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setEmail(req.getParameter("email"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setIpAddr(req.getRemoteAddr());

			dao.insertData(dto);

			url = cp + "/sboard/list.do";
			resp.sendRedirect(url);
		} else if (uri.indexOf("article.do") != -1) {
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchKey != null){
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
				
			}
			
			//��ȸ�� ����
			dao.updateHitCount(num);
			
			BoardDTO dto = dao.getReadData(num);
			
			if(dto == null){
				url = cp + "/sboard/list.do";
				resp.sendRedirect("url");
			}
			int lineSu = dto.getContent().split("\n").length;
			
			dto.setContent(dto.getContent().replaceAll("\n", "<br/>"));
			
			String param = "pageNum="+pageNum;
			if(searchKey != null){
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8"); 
			}
			
			req.setAttribute("dto", dto);
			
			req.setAttribute("params", param);
			
			req.setAttribute("lineSu", lineSu);
			
			req.setAttribute("pageNum", pageNum);
			
			
			
			url = "/bbs/article.jsp";
			forward(req, resp, url);
			
		}else if (uri.indexOf("update.do") != -1){
			int num = Integer.parseInt(req.getParameter("num"));
			
			String pageNum = req.getParameter("pageNum");
					
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");		
					
			if(searchKey != null){
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
				
			}
			
			BoardDTO dto = dao.getReadData(num);

			if(dto == null){
				url = cp + "/sboard/list.do";
				resp.sendRedirect("url");
			}
			String param = "pageNum="+pageNum;
			
			if(searchKey != null){
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8"); 
			}
			
			req.setAttribute("dto", dto);
			
			req.setAttribute("pageNum", pageNum);

			req.setAttribute("params", param);
			
			req.setAttribute("searchKey", searchKey);
			
			req.setAttribute("searchValue", searchValue);
			
			url = "/bbs/update.jsp";
			forward(req, resp, url);
					
		}else if (uri.indexOf("update_ok.do") != -1){
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			BoardDTO dto = new BoardDTO();
			
			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setName(req.getParameter("name"));
			dto.setEmail(req.getParameter("email"));
			dto.setContent(req.getParameter("content"));
			dto.setPwd(req.getParameter("pwd"));
						
			dao.updateData(dto);
			
			String params = "pageNum="+pageNum;
			
			if(searchKey != null){
				params += "&searchKey=" + searchKey;
				params += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8"); 
			}
			
			url = cp + "/sboard/list.do?"+params;
			resp.sendRedirect(url);
			
			
		}else if (uri.indexOf("delete.do") != -1){
			int num = Integer.parseInt(req.getParameter("num"));
			
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			dao.deleteData(num);
			
			String params = "pageNum="+pageNum;
			
			if(searchKey != null){
				params += "&searchKey=" + searchKey;
				params += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8"); 
			}
			
			url = cp + "/sboard/list.do?"+params;
			resp.sendRedirect(url);
			
			
			
		}
		
		
		
		// study/bbs/list.jsp ( ���� �ּ� )
		// study/sboard/list.do( ���� �������� �ʴ� �����ּ� ) - Ŭ���̾�Ʈ�� ���ּҷ� ����

	}

	// ������(�������� �����°� : �ּҸ� ���߸鼭)

}
