package app.todo.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
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
	 
	 private LocalDateTime due_Date;
	 
	 @ManyToOne( fetch = FetchType.EAGER,cascade = CascadeType.REMOVE)
	 @JoinColumn(name="idUser")
	 private User user;
	
	 
}
