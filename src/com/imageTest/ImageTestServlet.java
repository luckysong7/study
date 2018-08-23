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
		

		// ���� ���ε� �ʿ� �ڵ� ����-------------------------------------------

		// ���� ������ ���
		// ���� ���� String root = pageContext.getServletContext().getRealPath("/");
		String root = getServletContext().getRealPath("/");
		String path = root + File.separator + "pds" + File.separator
				+ "imageFile";

		File f = new File(path);
		if (!f.exists()) {
			f.mkdirs();
		}

		// ���� ���ε� �ʿ� �ڵ� ��--------------------------------------------

		// ���� ���ε�
		String encType = "UTF-8";
		int maxSize = 10 * 1024 * 1024;

		if (uri.indexOf("write.do") != -1) {
			url = "/imageTest/write.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("write_ok.do") != -1) {

			MultipartRequest mr = new MultipartRequest(req, path, maxSize,
					encType, new DefaultFileRenamePolicy());

			// DB�� ���� ���� ����
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

			// client�κ��� �Ѿ�� ������ ��ȣ
			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			// ó�� ����� null
			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);

			}

			// ��ü ������ ���� ���ϱ�
			int numPerPage = 9;

			int dataCount = dao.getDataCount();

			int totalPage = myUtil.getPageCount(numPerPage, dataCount);

			// ������ ��ü������������ ǥ���� �������� ū ���
			if (currentPage > totalPage) {
				currentPage = totalPage;
			}

			// �������� ���۰� ��
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
			
			// ������ �������� ������ ����
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

			// ���ϻ���
			FileManager.doFileDelete(dto.getSaveFileName(), path);

			// ���̺� ����
			dao.deleteData(num);
			url = cp + "/image/list.do";
			resp.sendRedirect(url);

		}

	}
}
