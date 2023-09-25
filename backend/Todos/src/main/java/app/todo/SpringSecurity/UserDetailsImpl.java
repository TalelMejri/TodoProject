package app.todo.SpringSecurity;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import app.todo.Reposiory.UserRepo;
import app.todo.entity.User;


@Service
public class UserDetailsImpl implements UserDetailsService {

	@Autowired
	UserRepo UserRepo;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Optional<User> User= UserRepo.findByEmail(username);
		if(User==null) {
				throw new UsernameNotFoundException("User Not Found");
		}
		return User.map(MyUserDetails::new).get();
	}

}
