package app.todo.payload;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@AllArgsConstructor@NoArgsConstructor
public class todopayload {
	String name;
	String description;
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSS")
	LocalDateTime   due_date;
}
