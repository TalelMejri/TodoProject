package app.todo.Reposiory;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import app.todo.entity.User;

public interface UserRepo  extends JpaRepository<User,Integer>{
	@Query(value = "Select * from user where email=:email",nativeQuery = true)
	Optional<User> findByEmail(String email);
	
	@Query(value="select * from user where email=:email",nativeQuery=true)
	User getUserByemail(String email);
}
