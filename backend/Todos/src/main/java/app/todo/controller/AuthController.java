package app.todo.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import app.todo.entity.User;

@RestController
@RequestMapping("/Auth")
public class AuthController {
 
	@PostMapping("Create")
	public ResponseEntity<?> SignUp(@RequestBody User user){
			User user_new=new User();
			user_new.setEmail(user.getEmail());
			user_new.setImageProfile(user.getImageProfile());
			user_new.setNom(user.getNom());
			
			return ResponseEntity.ok().body("hi");
	}
	
	@PostMapping("login")
	public ResponseEntity<?> Login(@RequestBody User user){
		return ResponseEntity.ok().body("hi");
	}
	
}