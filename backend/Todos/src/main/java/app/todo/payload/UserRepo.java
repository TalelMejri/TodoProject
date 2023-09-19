package app.todo.payload;

import org.springframework.data.jpa.repository.JpaRepository;

import app.todo.entity.User;

public interface UserRepo extends JpaRepository<User,Integer> {

}
