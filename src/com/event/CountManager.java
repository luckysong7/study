package com.event;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;


// ������ ����������Ŭ �Ӽ�

// HttpSessionListener : ������ ���� , ����� ��
// ServletContextListener : ������ ����, ������ ��




public class CountManager implements HttpSessionListener{ // ������
	
	private static CountManager countManager;
	
	private static int count;
	
	public CountManager() {
		countManager = this;
		
	}

	
	public static synchronized CountManager getInstance() throws Exception{
		if(countManager == null){
			countManager = new CountManager();
		}
		
		return countManager;
	}
	
	public static int getCount(){
		return count;
	}
	@Override
	public void sessionCreated(HttpSessionEvent evt) {
		HttpSession session = evt.getSession();
		
		session.setMaxInactiveInterval(10*60); // 10��
	
		count ++ ;
		
		System.out.print(session.getId() + "���� ����, ");
		System.out.println("�����ڼ� : " + count);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent evt) {
		HttpSession session = evt.getSession();
		
		count--;
		
		System.out.print(session.getId() + "���� �Ҹ�, ");
		System.out.println("�����ڼ� : " + count);
	}
	
	
	
	
	

}







