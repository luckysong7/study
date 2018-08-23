package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class TimerFilter implements Filter{

	private FilterConfig config;
	
	@Override
	public void destroy() {
		
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		
		long before = System.currentTimeMillis(); // ���۽ð�
		
		chain.doFilter(req, resp); // �������� ������ ���� 
		
		long after = System.currentTimeMillis(); // ����ð�

		String uri; 
		
		if(req instanceof HttpServletRequest){
			
			HttpServletRequest request = (HttpServletRequest)req;  // ����ȯ
			
			uri = request.getRequestURI();
			
			config.getServletContext().log(uri + "  : " + (after-before) + "ms");
			
			
			
			
		}
		
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		this.config = config;
		
	}

	
	
	
}
