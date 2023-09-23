package app.todo.Reposiory;

import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.web.cors.reactive.CorsConfigurationSource;

import app.todo.entity.Todo;

@EnableJpaRepositories
public interface TodoRepo extends JpaRepository<Todo, Integer> {
	@Query(value = "Select * from todo where id=:id",nativeQuery = true)
	Todo GetTodo(int id);
	
	@Query(value = "Select * from todo where name=:name",nativeQuery = true)
	Todo GetNameTodo(String name);
	
	
	List<Todo> findByName(String name);
	

}
