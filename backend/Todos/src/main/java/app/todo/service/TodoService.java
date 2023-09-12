package app.todo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import app.todo.Reposiory.TodoRepo;
import app.todo.entity.Todo;
import app.todo.payload.todopayload;

@Service
public class TodoService {
 
	@Autowired
	TodoRepo todorep;
	
	public List<Todo> getTodo(){
	     return todorep.findAll();
	}
	
	public void DeleteTodo(int id) throws Exception {
		Todo todo=todorep.GetTodo(id);
		if(todo != null) {
			todorep.delete(todo);
		}else {
			 throw new Exception("Todo Not Found");
		}
	}
	
	public void AddTodoServ(todopayload todo)throws Exception {
		if(todorep.GetNameTodo(todo.getName()) != null) {
			 throw new Exception("Todo Already Exist");
		}else {
			Todo todo_new=new Todo();
			todo_new.setName(todo.getName());
			todo_new.setDue_Date(todo.getDue_date());
			todo_new.setDescription(todo.getDescription());
			todo_new.setIsdone(false);
			todorep.save(todo_new);
		}
	}
	
	public void UpdateTodoServ(todopayload todo_updated,int id) throws Exception {
		Todo todo =todorep.GetTodo(id);
		if(todo != null) {
			todo.setDescription(todo_updated.getDescription());
			todo.setDue_Date(todo_updated.getDue_date());
			todo.setName(todo_updated.getName());
			todorep.save(todo);
		}else {
			 throw new Exception("Todo Not Found");
		}
	}
	
	public void updateStatus(int id)throws Exception {
		Todo todo =todorep.GetTodo(id);
		if(todo != null) {
			todo.setIsdone(!todo.isIsdone());
			todorep.save(todo);
		}else {
			 throw new Exception("Todo Not Found");
		}
	}
	
	
	
}
