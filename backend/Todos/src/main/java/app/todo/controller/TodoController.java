package app.todo.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import app.todo.entity.Todo;
import app.todo.payload.todopayload;
import app.todo.service.TodoService;


@RequestMapping("Todo")
@RestController
public class TodoController {
 
	@Autowired
	TodoService TodoServ;
	
	
	@GetMapping("GetTodos")
	public ResponseEntity<?> getTodos(){
		List<Todo> todos=TodoServ.getTodo();
		return ResponseEntity.ok().body(todos);
	}
	
	@DeleteMapping("DeleteTodo")
	public ResponseEntity<?> DeleteTodo(@RequestParam("id") int id){
		try {
			TodoServ.DeleteTodo(id);
			return ResponseEntity.ok().body("Todo deletd");
		}catch(Exception e) {
			return new ResponseEntity<String>(e.getMessage(),HttpStatus.CONFLICT);
		}
	}
	
	@PostMapping("AddTodo")
	public ResponseEntity<?> AddTodo(@RequestBody todopayload todo){
		try {
			TodoServ.AddTodoServ(todo);
			return ResponseEntity.ok().body("Todo Added");
		}catch (Exception e) {
			return new ResponseEntity<String>(e.getMessage(),HttpStatus.CONFLICT);
		}
	}
	
	
	@PutMapping("UpdateTodo")
	public ResponseEntity<?> UpdateTodo(@RequestBody todopayload todo,@RequestParam("id") int id){
		try {
			TodoServ.UpdateTodoServ(todo, id);
			return ResponseEntity.ok().body("Todo Updated");
		}catch (Exception e) {
			return new ResponseEntity<String>(e.getMessage(),HttpStatus.CONFLICT);
		}
	}
	
	@PutMapping("updateStatus")
	public ResponseEntity<?> UpdateTodoStatus(@RequestParam("id") int id){
		try {
			TodoServ.updateStatus(id);
			return ResponseEntity.ok().body("Todo Status Updated");
		}catch (Exception e) {
			return new ResponseEntity<String>(e.getMessage(),HttpStatus.CONFLICT);
		}
	}
}