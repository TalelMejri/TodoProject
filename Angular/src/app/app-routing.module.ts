import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { TodoComponent } from './todo/todo.component';
import { AddTodoComponent } from './todo/add-todo/add-todo.component';
import { UpdateTodoComponent } from './todo/update-todo/update-todo.component';

const routes: Routes = [
  {path:"",component:TodoComponent},
  {path:"Add",component:AddTodoComponent},
  {path:"update/:id",component:UpdateTodoComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
