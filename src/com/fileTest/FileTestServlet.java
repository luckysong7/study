package com.fileTest;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import util.DBCPConn;
import util.FileManager;
import util.MyUtil;

public class FileTestServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		doPost(req, resp);
	}

	protected void forward(HttpServletRequest req, HttpServletResponse resp,
			String url) throws ServletException, IOException {

		RequestDispatcher rd = req.getRequestDispatcher(url);

		rd.forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		Connection conn = DBCPConn.getConnection();
		FileTestDAO dao = new FileTestDAO(conn);

		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		String url;

		// 파일 업로드 필요 코딩 시작-------------------------------------------

		// 파일 저장할 경로
		// 생략 가능 String root = pageContext.getServletContext().getRealPath("/");
		String root = getServletContext().getRealPath("/");
		String path = root + File.separator + "pds" + File.separator
				+ "saveFile";

		File f = new File(path);
		if (!f.exists()) {
			f.mkdirs();
		}

		// 파일 업로드 필요 코딩 끝--------------------------------------------

		if (uri.indexOf("write.do") != -1) {

			url = "/fileTest/write.jsp";
			forward(req, resp, url);
			
		} else if (uri.indexOf("write_ok.do") != -1) {

			// 파일 업로드
			String encType = "UTF-8";
			int maxSize = 10 * 1024 * 1024;

			MultipartRequest mr = new MultipartRequest(req, path, maxSize,
					encType, new DefaultFileRenamePolicy());

			// DB에 파일 정보 저장
			if (mr.getFile("upload") != null) {

				FileTestDTO dto = new FileTestDTO();

				int maxNum = dao.getMaxNum();

				dto.setNum(maxNum + 1);
				dto.setSubject(mr.getParameter("subject"));
				dto.setSaveFileName(mr.getFilesystemName("upload"));
				dto.setOriginalFileName(mr.getOriginalFileName("upload"));

				dao.insertData(dto);

			}

			url = cp + "/file/list.do";
			resp.sendRedirect(url);

		} else if (uri.indexOf("list.do") != -1) {
			
			MyUtil myUtil = new MyUtil();

			// client로부터 넘어온 페이지 번호
			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

//			if(pageNum == null){
//				pageNum ="1";
//			}
			
			// 처음 실행시 null
			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);

			}

			// 전체 데이터 개수 구하기
			int numPerPage = 3;

			int dataCount = dao.getDataCount();

			int totalPage = myUtil.getPageCount(numPerPage, dataCount);

			// 삭제로 전체페이지수보다 표시할 페이지가 큰 경우
			if (currentPage > totalPage) {
				currentPage = totalPage;
			}

			// 데이터의 시작과 끝
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			List<FileTestDTO> lists = dao.getList(start, end);

			String downloadPath = cp + "/file/download.do";
			String deletePath = cp + "/file/delete.do";
			
			String listUrl = cp + "/file/list.do";

			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

			String imagePath = cp + "/pds/saveFile";
			req.setAttribute("imagePath", imagePath);
			
			
			// 포워딩 페이지에 데이터 전송
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("pageNum", currentPage);

			req.setAttribute("downloadPath", downloadPath);
			req.setAttribute("deletePath", deletePath);
			
			url = "/fileTest/list.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("delete_ok.do") != -1) {
			int num = Integer.parseInt(req.getParameter("num"));

			dao.deleteData(num);

			String pageNum = req.getParameter("pageNum");
			String params = "pageNum=" + pageNum;

			url = cp + "/file/list.do?" + params;
			resp.sendRedirect(url);

		} else if(uri.indexOf("download.do") != -1){
			int num = Integer.parseInt(req.getParameter("num"));

			FileTestDTO dto = dao.getReadData(num);
			
			if(dto == null){
				return;
			}
			
			boolean flag = FileManager.doFileDownload(resp, dto.getSaveFileName(), dto.getOriginalFileName(), path);
			
			// 내장객체 사용 
			if(flag == false){
				
				resp.setContentType("text/html;charset=UTF-8");
				
				PrintWriter out = resp.getWriter();
				
				out.print("<script type = 'text/javascript'>");
				out.print("alert('다운로드 실패 ㅠㅠ');");
				out.print("history.back();");
				out.print("</script>");
				
			}
			
		} else if(uri.indexOf("delete.do") != -1){
			int num = Integer.parseInt(req.getParameter("num"));
			
			FileTestDTO dto = dao.getReadData(num);
			
			// 파일삭제 
			FileManager.doFileDelete(dto.getSaveFileName(), path);
			
			// 테이블 삭제 
			dao.deleteData(num);
			url = cp + "/file/list.do";
			resp.sendRedirect(url);
			
			
			
		}

	}

}
