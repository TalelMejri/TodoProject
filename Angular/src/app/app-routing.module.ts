import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { TodoComponent } from './todo/todo.component';
import { AddTodoComponent } from './todo/add-todo/add-todo.component';
import { UpdateTodoComponent } from './todo/update-todo/update-todo.component';
import { LayoutComponent } from './layout/layout.component';
import { LoginCompComponent } from './Auth/login-comp/login-comp.component';
import { SignUpComppComponent } from './Auth/sign-up-compp/sign-up-compp.component';

const routes: Routes = [
  {path:"",component:LayoutComponent},
  {path:"todo",component:TodoComponent},
  {path:"Add",component:AddTodoComponent},
  {path:"update/:id",component:UpdateTodoComponent},
  {path:"login",component:LoginCompComponent},
  {path:"signup",component:SignUpComppComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
