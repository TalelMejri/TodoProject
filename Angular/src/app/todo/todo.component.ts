import { Component } from '@angular/core';
import { TodoServiceService } from '../services/todo-service.service';
import { Todo } from '../Model/todo';

@Component({
  selector: 'app-todo',
  templateUrl: './todo.component.html',
  styleUrls: ['./todo.component.scss']
})
export class TodoComponent {
  
  constructor(private todoServ:TodoServiceService){
      this.getTodo();
  }
  todo:any=[];

  getTodo(){
    this.todoServ.getTodo().subscribe((res:any)=>{
      console.log(res);
      this.todo=res;
    },(error)=>{

    })
  }

}
