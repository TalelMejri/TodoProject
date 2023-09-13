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
import { FormsModule } from "@angular/forms";
@NgModule({
  declarations: [
    AppComponent,
    TodoComponent,
    ListTodoComponent,
    CardTodoComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialModule,
    HttpClientModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
