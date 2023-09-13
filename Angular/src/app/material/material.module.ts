import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {MatSnackBarModule} from '@angular/material/snack-bar';

@NgModule({
  declarations: [],
  imports: [
    CommonModule,MatSnackBarModule
  ],
  exports:[
    MatSnackBarModule
  ]
})
export class MaterialModule { }
