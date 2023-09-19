package app.todo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import app.todo.Reposiory.UserRepo;
import app.todo.SpringSecurity.SecurityConfig;
import app.todo.SpringSecurity.UserDetailsServiceImpl;
import app.todo.entity.User;
import app.todo.payload.AuhPayload;
import net.minidev.json.JSONObject;

@RestController
@RequestMapping("/Auth")
public class AuthController {
 
	@Autowired
	SecurityConfig securityConfig;
	
	
	@Autowired
	AuthenticationManager authManager;
	
	@Autowired
	UserRepo userRepo;
	
	@Autowired
	UserDetailsServiceImpl userdet;
	
	@PostMapping("Create")
	public ResponseEntity<?> SignUp(@RequestBody User user){
			User user_new=new User();
			user_new.setEmail(user.getEmail());
			user_new.setImageProfile(user.getImageProfile());
			user_new.setNom(user.getNom());
			user_new.setImageProfile("no");
			user_new.setPassword(securityConfig.passwordEncoder().encode(user.getPassword()));
			userRepo.save(user_new);
			return new ResponseEntity<>(user_new,HttpStatus.OK);		
	}
	
	@PostMapping("login")
	public ResponseEntity<?> Login(@RequestBody AuhPayload user){
		try {
			if(userRepo.findByEmail(user.getEmail())==null) {
				 return new ResponseEntity<String>("USER_NOT_FOUND",HttpStatus.CONFLICT);
			}
			Authentication authUser=authManager.authenticate(new UsernamePasswordAuthenticationToken(user.getEmail(),user.getPassword()));
		}catch (Exception e) {
			return new ResponseEntity<String>("INVALID_CREDENTIALS",HttpStatus.CONFLICT);
		}
		UserDetails user_det=userdet.loadUserByUsername(user.getEmail());
		User user_filter=userRepo.getUserByemail(user.getEmail());
		JSONObject res=new JSONObject();
		res.appendField("user", user_filter);
		return ResponseEntity.ok().body(res);
	}
	
}
