import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { TodoComponent } from './todo/todo.component';
import { MaterialModule } from './material/material.module';
import {HttpClientModule} from '@angular/common/http';
import { ListTodoComponent } from './todo/list-todo/list-todo.component';
import { CardTodoComponent } from './todo/card-todo/card-todo.component'
import { FormsModule,ReactiveFormsModule } from "@angular/forms";
import { AddTodoComponent } from './todo/add-todo/add-todo.component';
import { UpdateTodoComponent } from './todo/update-todo/update-todo.component';
import { LayoutComponent } from './layout/layout.component';

@NgModule({
  declarations: [
    AppComponent,
    TodoComponent,
    ListTodoComponent,
    CardTodoComponent,
    AddTodoComponent,
    UpdateTodoComponent,
    LayoutComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
