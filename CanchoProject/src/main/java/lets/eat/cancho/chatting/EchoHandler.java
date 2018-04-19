package lets.eat.cancho.chatting;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler{

	
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class); 
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	//클라이언트 연결 이후 실행되는 메소드
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		logger.info("{} 연결됨",session.getId());
		//super.afterConnectionEstablished(session);
	}
	
	//클라이언트가 웹소켓서버로 메시지를 전송했을 때 실행되는 메소드
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("{} 로부터 {} 받음",session.getId(),message.getPayload());
		for (WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(session.getId() + ": "+message.getPayload()));
		}
		//여기도 안 되면 new TextMessage(session.getId()로 원상복구)
		//super.handleTextMessage(session, message);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		logger.info("{} 연결 끊김",session.getId());
		//super.afterConnectionClosed(session, status);
	}
	
}
