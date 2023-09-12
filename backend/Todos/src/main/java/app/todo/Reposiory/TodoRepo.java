package app.todo.Reposiory;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import app.todo.entity.Todo;

public interface TodoRepo extends JpaRepository<Todo, Integer> {
	@Query(value = "Select * from todo where id=:id",nativeQuery = true)
	Todo GetTodo(int id);
	
	@Query(value = "Select * from todo where name=:name",nativeQuery = true)
	Todo GetNameTodo(String name);
}