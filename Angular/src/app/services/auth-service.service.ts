import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, tap } from 'rxjs';
import { environment } from 'src/environements/env';
@Injectable({
  providedIn: 'root'
})
export class AuthServiceService {
 
  private logintest=new BehaviorSubject<Boolean>(false);
  isLogin=this.logintest.asObservable();
  
  constructor(private http:HttpClient) {
    const user=localStorage.getItem("User");
    this.logintest.next(!!user);
   }

   login(data:any){
      return this.http.post(`${environment.apiUrl}Auth/Login`,data).pipe(
        tap((res:any)=>{
          this.logintest.next(true);
        })
      ) 
   }
}
