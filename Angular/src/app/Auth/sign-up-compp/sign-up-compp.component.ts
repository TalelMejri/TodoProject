import { Component } from '@angular/core';
import { FormGroup,FormBuilder, FormControl, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { RegisterService } from 'src/app/services/register.service';


@Component({
  selector: 'app-sign-up-compp',
  templateUrl: './sign-up-compp.component.html',
  styleUrls: ['./sign-up-compp.component.scss']
})
export class SignUpComppComponent {

  constructor(private formBuilder:FormBuilder,private RegisterService:RegisterService,
    private Router:Router){
    this.loginForm=this.formBuilder.group({
      nom:this.nomForm,
      email:this.emailForm,
      password:this.passwordForm,
    });
  }

  nomForm=new FormControl('',[Validators.required]);
  emailForm=new FormControl('',[Validators.required,Validators.email]);
  passwordForm=new FormControl('',[Validators.required]);
  imageError:String=""
  image:String="";

  onFileChanged(event: any) {
    const file = event.target.files[0];
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => {
      this.image = reader.result as string;
    };
    if(this.image.length>0){
      this.imageError="";
    }
  }

  loginForm:FormGroup;
  hidden=false;
  SignUp(){
    if(this.loginForm.valid){
      if(this.image.length==0){
        this.imageError="Image Required";
      }
        this.RegisterService.RegisterUser({
          nom:this.loginForm.value['nom'],
          password:this.loginForm.value['password'],
          email:this.loginForm.value['email'],
          imageProfile:this.image
        }).subscribe((res:any)=>{
            console.log(res);
            this.Router.navigate(['login'],{queryParams:{message:"Register Successful"}});
        },(error)=>{
           console.log(error);
        });
    }else{
      this.loginForm.markAllAsTouched();
    }
  }
}
