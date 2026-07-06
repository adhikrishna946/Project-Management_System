import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-task',
  standalone: true,
  imports: [
    CommonModule,
    HttpClientModule,
    RouterModule
  ],
  templateUrl: './task.html',
  styleUrls: ['./task.css']
})
export class TaskComponent implements OnInit {

  tasks: any[] = [];

  constructor(
    private http: HttpClient,
    private cdr: ChangeDetectorRef
  ) { }

  ngOnInit(): void {
    this.loadTasks();
  }

  loadTasks(): void {

    this.http.get<any[]>('https://localhost:7296/api/Task/GetAll')
      .subscribe({

        next: (response) => {

          console.log(response);

          this.tasks = response;

          this.cdr.detectChanges();

        },

        error: (error) => {

          console.log(error);

          alert('Unable to load tasks');

        }

      });

  }

  deleteTask(id: number) {

    if (!confirm('Are you sure you want to delete this task?'))
      return;

    this.http.delete(
      'https://localhost:7296/api/Task/Delete/' + id,
      { responseType: 'text' }
    )
    .subscribe({

      next: (response) => {

        alert(response);

        this.loadTasks();

      },

      error: (error) => {

        console.log(error);

        alert('Unable to delete task');

      }

    });

  }

}