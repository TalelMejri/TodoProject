import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import {Store} from "@ngxs/store"
@Injectable({
  providedIn: 'root'
})

export class InterceptorGlobaleService implements HttpInterceptor {

  constructor(private Store:Store) { }
  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>>{
    var user=this.Store.selectSnapshot(s=>s.AuthStore?.User);
    let final_request;
    if(user){
      final_request=req.clone(
        {
           withCredentials: true 
        }
      );
    }else{
      final_request=req.clone(
        {
          setHeaders: {
            "Content-Type": "application/json"
          },
         withCredentials: true 
        }
      );
    }
  
    return next.handle(final_request);
  }
}
