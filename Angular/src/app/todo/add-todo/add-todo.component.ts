import { Component } from '@angular/core';
import {FormGroup,FormBuilder,FormControl,Validators} from "@angular/forms"
import { Router } from '@angular/router';
import { TodoServiceService } from 'src/app/services/todo-service.service';


@Component({
  selector: 'app-add-todo',
  templateUrl: './add-todo.component.html',
  styleUrls: ['./add-todo.component.scss']
})
export class AddTodoComponent {

   constructor(private Router:Router,private formbuilder:FormBuilder,private TodoServiceService:TodoServiceService){
    this.todoFrom=this.formbuilder.group({
      name:this.nameRegister,
      description:this.descriptionRegister,
      due_Date:this.due_DateRegister
    });
   }

   todoFrom:FormGroup;

   nameRegister=new FormControl('',[Validators.required,Validators.minLength(3),Validators.maxLength(7)]);
   descriptionRegister=new FormControl('',[Validators.required,Validators.minLength(4),Validators.maxLength(12)]);
   due_DateRegister=new FormControl('',[Validators.required]);
  
  AddForm(){
    if(this.todoFrom.valid){
      this.TodoServiceService.AddTodoFn(this.todoFrom.value).subscribe((res)=>{
        this.Router.navigate(['']);
      },(error)=>{
        this.Router.navigate(['']);
      });
    }else{
      this.todoFrom.markAllAsTouched();
    }
  }
}
