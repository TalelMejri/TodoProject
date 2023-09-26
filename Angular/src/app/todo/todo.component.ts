import { Component } from '@angular/core';
import { TodoServiceService } from '../services/todo-service.service';
import {Store} from "@ngxs/store"
import { Logout } from 'src/Store/state';
import { Router } from '@angular/router';

@Component({
  selector: 'app-todo',
  templateUrl: './todo.component.html',
  styleUrls: ['./todo.component.scss']
})
export class TodoComponent {
  
  user:any;
  constructor(private todoServ:TodoServiceService,private Store:Store,private Router:Router){
      this.getTodo();
      this.user=this.Store.selectSnapshot(s=>s.AuthStore?.User);
      console.log(this.user);
  }
  todos:any=[];

  isCard:boolean=false;

  getTodo(){
    this.todoServ.getTodo().subscribe((res:any)=>{
      this.todos=res;
    },(error)=>{
    })
  }

  Logout(){
    this.Store.dispatch([
      new Logout()
    ]);
    this.Router.navigate(['']);
  }

}
