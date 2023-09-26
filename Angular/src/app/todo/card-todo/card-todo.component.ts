import { Component,Input } from '@angular/core';
import { TodoServiceService } from 'src/app/services/todo-service.service';
import {MatSnackBar} from "@angular/material/snack-bar"

@Component({
  selector: 'app-card-todo',
  templateUrl: './card-todo.component.html',
  styleUrls: ['./card-todo.component.scss']
})
export class CardTodoComponent {
  @Input() public item:any;
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

   DeleteTodo(id:number){
    this.todoServ.DeleteTodo(id).subscribe((res)=>{
      this.MatSnackBar.open("Delete Todo",'close',{
        duration:3000
      })
    })
   }
}
