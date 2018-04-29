package lets.eat.cancho.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//로그인을 체크하는 인터셉터 -> 로그인 체크 -> 세션이 필요 -> request.getSession
		//세션정보 읽기
		HttpSession session = request.getSession();
		String loginId = (String)session.getAttribute("loginId"); //오브젝트로 나오기 때문에 형변환 필요
				
		//로그인 되지 않은 경우 로그인 페이지로 이동
		if(loginId == null){
			//서블릿에서 페이지 보내줄 경우 -> 컨트롤러가 아니더라도 원하는 곳으로 가려면 서블릿 개념을 잘 알아야한다.
					
			//루트 경로를 구하는 방법(절대경로)
			String path = request.getContextPath();
					
			response.sendRedirect(path + "/user/loginPage"); //로그인컨트롤러의 리퀘스트맵핑 value 값
			//이때 상대경로로 해놓으면 안된다. -> 여기서는 무조건 절대경로로 해야한다. 요청하는 경로가 매우 다양하기 때문에
			return false; //원래 가려는 곳에 못 가도록 처리
		}
		
		return super.preHandle(request, response, handler); //의미 자체가 return true;
	}

	
	
	
	
	
}
