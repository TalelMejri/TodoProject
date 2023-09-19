package app.todo.entity;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor

public class Todo  {
	
	 @Id
	 @GeneratedValue(strategy=GenerationType.AUTO)
	 private int id;
	 
	 private String name;
	 
	 private String description;
	 
	 private boolean isdone;
	 
	 private LocalDate due_Date;
	 
	 @ManyToOne
	 @JoinColumn(name="UserId")
	 private User user;
	 
}
