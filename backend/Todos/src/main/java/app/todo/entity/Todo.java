package app.todo.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Todo {
	 @Id
	 @GeneratedValue(strategy=GenerationType.AUTO)
	 int id;
}
