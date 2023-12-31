import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {environment} from "../../environements/env"
import { Todo } from '../Model/todo';
import {Store} from "@ngxs/store"
@Injectable({
  providedIn: 'root'
})
export class TodoServiceService {
   
  constructor(private _hhtp:HttpClient,private store:Store) { }

  getTodo(){
    return this._hhtp.get(`${environment.apiUrl}Todo/GetTodos`);
  }

  ChangerStatus(id:number){
    return this._hhtp.put(`${environment.apiUrl}Todo/updateStatus?id=`+id,null);
  }
  
  DeleteTodo(id:number){
    return this._hhtp.delete(`${environment.apiUrl}Todo/DeleteTodo?id=`+id);
  }

  AddTodoFn(todo:any){
    return this._hhtp.post(`${environment.apiUrl}Todo/AddTodo`,todo);
  }

  getTodoById(id:any){
    return this._hhtp.get(`${environment.apiUrl}Todo/getTodo?id=`+id);
  }

  UpdatetTodoFn(todo:any,id:number){
    return this._hhtp.put(`${environment.apiUrl}Todo/UpdateTodo?id=`+id,todo);
  }
}
