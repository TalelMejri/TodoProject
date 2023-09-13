import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {environment} from "../../environements/env"
import { Todo } from '../Model/todo';
@Injectable({
  providedIn: 'root'
})
export class TodoServiceService {
   
  constructor(private _hhtp:HttpClient) { }

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
}
