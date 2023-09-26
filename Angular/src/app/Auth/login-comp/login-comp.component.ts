import { Component,OnInit } from '@angular/core';
import { FormGroup,FormBuilder, FormControl, Validators } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthServiceService } from 'src/app/services/auth-service.service';
import { CookieService } from 'ngx-cookie-service';
import {Store} from "@ngxs/store"
import { Logout, SetIsAuth, SetUser } from 'src/Store/state';
@Component({
  selector: 'app-login-comp',
  templateUrl: './login-comp.component.html',
  styleUrls: ['./login-comp.component.scss']
})
export class LoginCompComponent implements OnInit{


constructor( private Store:Store,private CookieService:CookieService, private MatSnackBar:MatSnackBar, private AuthServiceService:AuthServiceService,   private ActivatedRoute:ActivatedRoute,private Router:Router,private formBuilder:FormBuilder){
    this.loginForm=this.formBuilder.group({
       email:this.emailForm,
       password:this.passwordForm
    });
  } 
  emailForm=new FormControl('',[Validators.required]);
  passwordForm=new FormControl('',[Validators.required]);

  getEmailError(){
    if(this.emailForm.touched){
      if(this.emailForm.hasError('required')){
        return "Email Reqruired";
      }
    }
    return '';
  }

  getPasswordError(){
    if(this.passwordForm.touched){
      if(this.passwordForm.hasError('required')){
        return "Password Reqruired";
      }
    }
    return '';
  }
  ngOnInit(): void {
    this.ActivatedRoute.queryParams.subscribe((res:any)=>{
       if(res['message']!=null){
          this.message=res['message'];
       }
    })
    setTimeout(()=>
    {
         this.Router.navigate(['login'],{queryParams:{message:null}});
         this.message="";
    }
      ,3000);
  }

  loginForm:FormGroup;
  message:String="";

  hidden:boolean=false;

  Login(){
    if(this.loginForm.valid){
          this.AuthServiceService.login(this.loginForm.value).subscribe((res:any)=>{
              this.Store.dispatch([
                new SetUser(res.user),
                new SetIsAuth(true),
              ]);
              this.Router.navigate(['todo']);
        },(error)=>{
              this.MatSnackBar.open(error.error,'close',{
                duration:3000
              });
        });
    }else{
      this.loginForm.markAllAsTouched();
    }
  }
}
