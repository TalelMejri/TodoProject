import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { TodoComponent } from './todo/todo.component';
import { MaterialModule } from './material/material.module';
import {HTTP_INTERCEPTORS, HttpClientModule} from '@angular/common/http';
import { ListTodoComponent } from './todo/list-todo/list-todo.component';
import { CardTodoComponent } from './todo/card-todo/card-todo.component'
import { FormsModule,ReactiveFormsModule } from "@angular/forms";
import { AddTodoComponent } from './todo/add-todo/add-todo.component';
import { UpdateTodoComponent } from './todo/update-todo/update-todo.component';
import { LayoutComponent } from './layout/layout.component';
import { LoginCompComponent } from './Auth/login-comp/login-comp.component';
import { SignUpComppComponent } from './Auth/sign-up-compp/sign-up-compp.component';
import { CookieService } from 'ngx-cookie-service';
import { NgxsStoragePluginModule } from '@ngxs/storage-plugin';
import { NgxsModule } from '@ngxs/store';
import { AuthStore } from 'src/Store/actions';
import { InterceptorGlobaleService } from './interceptor-globale.service';

@NgModule({
  declarations: [
    AppComponent,
    TodoComponent,
    ListTodoComponent,
    CardTodoComponent,
    AddTodoComponent,
    UpdateTodoComponent,
    LayoutComponent,
    LoginCompComponent,
    SignUpComppComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    NgxsStoragePluginModule.forRoot(),
    NgxsModule.forRoot([AuthStore]),
    MaterialModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule
  ],
  providers: [
    {
      provide:HTTP_INTERCEPTORS,
      useClass:InterceptorGlobaleService,
      multi:true
    },
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
