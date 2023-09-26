import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environements/env';
@Injectable({
  providedIn: 'root'
})
export class RegisterService {

  constructor(private http:HttpClient) {}

   RegisterUser(User:any){
    return this.http.post(`${environment.apiUrl}Auth/SignUp`,User);
  }
}
