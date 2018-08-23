package com.imageTest;

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

import com.fileTest.FileTestDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import util.DBCPConn;
import util.FileManager;
import util.MyUtil;

public class ImageTestServlet extends HttpServlet {

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
		ImageTestDAO dao = new ImageTestDAO(conn);

		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		String url;
		

		// 파일 업로드 필요 코딩 시작-------------------------------------------

		// 파일 저장할 경로
		// 생략 가능 String root = pageContext.getServletContext().getRealPath("/");
		String root = getServletContext().getRealPath("/");
		String path = root + File.separator + "pds" + File.separator
				+ "imageFile";

		File f = new File(path);
		if (!f.exists()) {
			f.mkdirs();
		}

		// 파일 업로드 필요 코딩 끝--------------------------------------------

		// 파일 업로드
		String encType = "UTF-8";
		int maxSize = 10 * 1024 * 1024;

		if (uri.indexOf("write.do") != -1) {
			url = "/imageTest/write.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("write_ok.do") != -1) {

			MultipartRequest mr = new MultipartRequest(req, path, maxSize,
					encType, new DefaultFileRenamePolicy());

			// DB에 파일 정보 저장
			if (mr.getFile("upload") != null) {
				ImageTestDTO dto = new ImageTestDTO();

				int maxNum = dao.getMaxNum();
				
				dto.setNum(maxNum + 1);
				dto.setSubject(mr.getParameter("subject"));
				dto.setSaveFileName(mr.getFilesystemName("upload"));

				dao.insertData(dto);
			}

			url = cp + "/image/list.do";
			resp.sendRedirect(url);

		} else if (uri.indexOf("list.do") != -1) {
			MyUtil myUtil = new MyUtil();

			// client로부터 넘어온 페이지 번호
			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			// 처음 실행시 null
			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);

			}

			// 전체 데이터 개수 구하기
			int numPerPage = 9;

			int dataCount = dao.getDataCount();

			int totalPage = myUtil.getPageCount(numPerPage, dataCount);

			// 삭제로 전체페이지수보다 표시할 페이지가 큰 경우
			if (currentPage > totalPage) {
				currentPage = totalPage;
			}

			// 데이터의 시작과 끝
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			List<ImageTestDTO> lists = dao.getList(start, end);

			String deletePath = cp + "/image/delete.do";

			String listUrl = cp + "/image/list.do";

			String pageIndexList = myUtil.pageIndexList(currentPage, totalPage,
					listUrl);

			String imagePath = cp + "/pds/imageFile";
			req.setAttribute("imagePath", imagePath);

			int articleNum = dao.getDataCount();
			
			// 포워딩 페이지에 데이터 전송
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("totalPageNum", totalPage);
			req.setAttribute("pageNum", currentPage);
			req.setAttribute("articleNum", articleNum);
			req.setAttribute("deletePath", deletePath);

			url = "/imageTest/list.jsp";
			forward(req, resp, url);
		} else if (uri.indexOf("delete.do") != -1) {
			int num = Integer.parseInt(req.getParameter("num"));

			ImageTestDTO dto = dao.getReadData(num);

			// 파일삭제
			FileManager.doFileDelete(dto.getSaveFileName(), path);

			// 테이블 삭제
			dao.deleteData(num);
			url = cp + "/image/list.do";
			resp.sendRedirect(url);

		}

	}
}
