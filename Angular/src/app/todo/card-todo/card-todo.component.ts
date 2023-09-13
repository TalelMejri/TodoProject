import { Component,Input } from '@angular/core';
import { Todo } from 'src/app/Model/todo';

@Component({
  selector: 'app-card-todo',
  templateUrl: './card-todo.component.html',
  styleUrls: ['./card-todo.component.scss']
})
export class CardTodoComponent {
  @Input() public item:any;
}
