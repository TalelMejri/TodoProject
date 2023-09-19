package app.todo.SpringSecurity;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import app.todo.Reposiory.UserRepo;
import app.todo.entity.User;


public class UserDetailsServiceImpl implements UserDetailsService {
		
	@Autowired
	UserRepo Userrepo;
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Optional<User> user=Userrepo.findByEmail(username);
		if(user==null) {
			throw new UsernameNotFoundException("User Not Founf");
		}
		// TODO Auto-generated method stub
		return user.map(MyUserDetails::new).get();
	}
	
}
