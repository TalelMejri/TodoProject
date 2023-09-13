import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {environment} from "../../environements/env"
@Injectable({
  providedIn: 'root'
})
export class TodoServiceService {
   
  constructor(private _hhtp:HttpClient) { }

  getTodo(){
    return this._hhtp.get(`${environment.apiUrl}Todo/GetTodos`);
  }
}
