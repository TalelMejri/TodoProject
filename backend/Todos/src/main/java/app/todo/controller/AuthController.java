package app.todo.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.oauth2.resource.OAuth2ResourceServerProperties.Jwt;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import app.todo.Reposiory.UserRepo;
import app.todo.SpringSecurity.SecurityConfig;
import app.todo.SpringSecurity.UserDetailsImpl;
import app.todo.entity.User;
import app.todo.jwt.jwtUtil;
import app.todo.payload.AuhPayload;
import io.jsonwebtoken.Claims;
import net.minidev.json.JSONObject;


@CrossOrigin(origins = "http://localhost:8081")
@RestController
@RequestMapping("/Auth")
public class AuthController {
	
	@Autowired
	jwtUtil jwtUtil;
	
	@Autowired
	SecurityConfig securityConfig;
	
	@Autowired
	UserRepo userRepo;
	
	@Autowired
	AuthenticationManager authManager;
	
	@Autowired
	UserDetailsImpl userDetImp;
	
	
	
	@PostMapping("/SignUp")
	public ResponseEntity<?> SignUp(@RequestBody User user){
		
		if(userRepo.getUserByemail(user.getEmail())!=null) {
			return new ResponseEntity<String>("Email Already Used",HttpStatus.FOUND);
		}
		
		User user_new=new User();
		user_new.setEmail(user.getEmail());
		user_new.setImageProfile(user.getImageProfile());
		user_new.setNom(user.getNom());
		user_new.setPassword(securityConfig.passwordEncoder().encode(user.getPassword()));
		userRepo.save(user_new);
		return  ResponseEntity.ok().body(user_new);
		
	}
	
	@PostMapping("/Login")
	public ResponseEntity<?> Login(@RequestBody AuhPayload user,HttpServletResponse response){
		try {
			if(userRepo.getUserByemail(user.getEmail())==null) {
				return new ResponseEntity<String>("User Not Found",HttpStatus.NOT_FOUND);
			}
			Authentication auth=authManager.authenticate(new UsernamePasswordAuthenticationToken(user.getEmail(), user.getPassword()));
		}catch (BadCredentialsException e) {
				return new ResponseEntity<String>("User Not Found",HttpStatus.NOT_FOUND);
		}
		User authUser=userRepo.getUserByemail(user.getEmail());
		UserDetails user_det=userDetImp.loadUserByUsername(user.getEmail());
		String token=jwtUtil.generateToken(user_det);
		JSONObject data=new JSONObject();
		data.appendField("UserDetails",user_det);
		data.appendField("User",authUser);
		data.appendField("token",token);
		
		/* add Cookie */
		Cookie cookie=new Cookie("Token",token);
		cookie.setHttpOnly(false);
		cookie.setSecure(false);
		response.addCookie(cookie); 
		return  ResponseEntity.ok().body(data);
	}
	
	
}
