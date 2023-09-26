package app.todo.service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import app.todo.Reposiory.UserRepo;
import app.todo.entity.User;
import app.todo.jwt.jwtUtil;



@Service
public class UserService {
	
	
	@Autowired
	jwtUtil jwtTokenUtil;
	@Autowired
	UserRepo UserRepo;
   public User userAuth(HttpServletRequest request) {
	   String jwtToken="";
	  Cookie[] cookies = request.getCookies();
	   for (Cookie cookie : cookies) {
           if ("Token".equals(cookie.getName())) {
               jwtToken = cookie.getValue();
               break;
           }
       }
	   String username = jwtTokenUtil.getUsernameFromToken(jwtToken);
	   return UserRepo.getUserByemail(username);
   }
}
