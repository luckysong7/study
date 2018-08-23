package com.score;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javafx.scene.control.Alert;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.DBCPConn;
import util.MyUtil;

import com.board.BoardDAO;

public class ScoreServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	// 자주 사용하는 메소드 만들기
	protected void foward(HttpServletRequest req, HttpServletResponse resp,
			String url) throws ServletException, IOException {

		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String cp = req.getContextPath();

		Connection conn = DBCPConn.getConnection();
		ScoreDAO dao = new ScoreDAO(conn);

		MyUtil myUtil = new MyUtil();

		String url;

		String uri = req.getRequestURI();
		if (uri.indexOf("list.do") != -1) {

			List<ScoreDTO> lists = dao.getList();

			req.setAttribute("lists", lists);
			url = "/sung/list.jsp";
			foward(req, resp, url);

		} else if (uri.indexOf("write.do") != -1) {

			url = "/sung/write.jsp";
			foward(req, resp, url);

		} else if (uri.indexOf("write_ok.do") != -1) {
			ScoreDTO dto = new ScoreDTO();
			
			dto.setHak(req.getParameter("hak"));
			dto.setName(req.getParameter("name"));
			dto.setKor(Integer.parseInt(req.getParameter("kor")));
			dto.setEng(Integer.parseInt(req.getParameter("eng")));
			dto.setMat(Integer.parseInt(req.getParameter("mat")));

			if(dao.insertData(dto) == 3){
				
				url = "/sscore/alert.do";
				foward(req, resp, url);
				return; 
				
			}
			
			url = cp + "/sscore/list.do";
			resp.sendRedirect(url);

		} else if(uri.indexOf("alert.do") != -1){
			url = "/sung/alert.jsp";
			foward(req, resp, url);
		}else if (uri.indexOf("update.do") != -1) {

			String hak = req.getParameter("hak");

			ScoreDTO dto = dao.getReadData(hak);
			
			if(dto == null){
				url = cp + "/sscore/list.do";
				resp.sendRedirect("url");
			}
			
			req.setAttribute("dto", dto);

			url = "/sung/update.jsp";
			foward(req, resp, url);

		} else if (uri.indexOf("update_ok.do") != -1) {
			
			ScoreDTO dto = new ScoreDTO();
			dto.setHak(req.getParameter("hak"));
//			dto.setName(req.getParameter("name"));
			dto.setKor(Integer.parseInt(req.getParameter("kor")));
			dto.setEng(Integer.parseInt(req.getParameter("eng")));
			dto.setMat(Integer.parseInt(req.getParameter("mat")));
			
			dao.updateData(dto);
			
			url = cp + "/sscore/list.do";
			resp.sendRedirect(url);
		
		}

		else if (uri.indexOf("delete_ok.do") != -1) {
	
			String hak = req.getParameter("hak");
			
			dao.deleteData(hak);

			url = cp + "/sscore/list.do";
			resp.sendRedirect(url);

		}

	}

}
