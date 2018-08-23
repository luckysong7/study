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
		
		long before = System.currentTimeMillis(); // 시작시간
		
		chain.doFilter(req, resp); // 목적지로 데이터 전송 
		
		long after = System.currentTimeMillis(); // 종료시간

		String uri; 
		
		if(req instanceof HttpServletRequest){
			
			HttpServletRequest request = (HttpServletRequest)req;  // 형변환
			
			uri = request.getRequestURI();
			
			config.getServletContext().log(uri + "  : " + (after-before) + "ms");
			
			
			
			
		}
		
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		this.config = config;
		
	}

	
	
	
}
