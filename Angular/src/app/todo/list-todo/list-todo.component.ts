import { Component, Input } from '@angular/core';
import { TodoServiceService } from 'src/app/services/todo-service.service';
import {MatSnackBar} from "@angular/material/snack-bar"
@Component({
  selector: 'app-list-todo',
  templateUrl: './list-todo.component.html',
  styleUrls: ['./list-todo.component.scss']
})
export class ListTodoComponent {
 @Input() public todos:any;
  constructor(private todoServ:TodoServiceService,private MatSnackBar:MatSnackBar){

  }
 changeStatus(id:number){
  this.todoServ.ChangerStatus(id).subscribe((res)=>{
    this.MatSnackBar.open("Status Changed",'close',{
      duration:3000
    })
  },((error)=>{
    this.MatSnackBar.open("Status Changed",'close',{
      duration:3000
    })
  }));
 }

 deleteTodo(id:number){
      this.todoServ.DeleteTodo(id).subscribe((res:any) => {
        this.MatSnackBar.open("Status Changed", 'close', {
          duration: 3000
        });
      });
    }
}
