import { Component,OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Todo } from 'src/app/Model/todo';
import { TodoServiceService } from 'src/app/services/todo-service.service';

@Component({
  selector: 'app-update-todo',
  templateUrl: './update-todo.component.html',
  styleUrls: ['./update-todo.component.scss']
})
export class UpdateTodoComponent implements OnInit {
  todo=new Todo();
  id:any;
  constructor(private Router:Router,private TodoServiceService:TodoServiceService,private ActivatedRoute:ActivatedRoute){
  }
ngOnInit(): void {
  this.ActivatedRoute.params.subscribe(param=>{
    this.id=param['id'];
    this.TodoServiceService.getTodoById(param['id']).subscribe((res:any)=>{
      this.todo=res;
      console.log(this.todo);
    })
  })
}

UpdateTodo(){
  this.TodoServiceService.UpdatetTodoFn(this.todo,this.id).subscribe((res)=>{
    this.Router.navigate(['todo']);
  },(error)=>{
    this.Router.navigate(['todo']);
  })
}
}
