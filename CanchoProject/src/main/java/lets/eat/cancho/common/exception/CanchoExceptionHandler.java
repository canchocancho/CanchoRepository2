package lets.eat.cancho.common.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class CanchoExceptionHandler {

	@ExceptionHandler (Exception.class)
	public String errorHandler(Exception e){
		e.printStackTrace();
		return "/error";
	}
}
