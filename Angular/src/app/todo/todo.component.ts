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
  todos:any=[];

  isCard:boolean=false;

  getTodo(){
    this.todoServ.getTodo().subscribe((res:any)=>{
      this.todos=res;
    },(error)=>{
    })
  }

}
