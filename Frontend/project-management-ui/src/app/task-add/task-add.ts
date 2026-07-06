import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-task-add',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    HttpClientModule,
    RouterModule
  ],
  templateUrl: './task-add.html',
  styleUrls: ['./task-add.css']
})
export class TaskAddComponent implements OnInit {

  projects: any[] = [];
  users: any[] = [];

  task = {
    taskId: 0,
    projectId: 0,
    assignedUserId: 0,
    taskName: '',
    description: '',
    priority: '',
    status: '',
    dueDate: '',
    createdBy: 'Admin'
  };

  constructor(
    private http: HttpClient,
    private router: Router
  ) { }
  ngOnInit(): void {

  this.loadProjects();
  this.loadUsers();

}


loadProjects() {

  this.http.get<any[]>(
    'https://localhost:7296/api/Project/GetAll'
  ).subscribe({

    next: (response) => {

      this.projects = response;

    },

    error: (error) => {

      console.log(error);

    }

  });

}

loadUsers() {

  this.http.get<any[]>(
    'https://localhost:7296/api/User/GetAll'
  ).subscribe({

    next: (response) => {

      this.users = response;

    },

    error: (error) => {

      console.log(error);

    }

  });

}

  saveTask() {

    this.http.post(
      'https://localhost:7296/api/Task/Save',
      this.task,
      { responseType: 'text' }
    ).subscribe({

      next: (response) => {

        alert(response);

        this.router.navigate(['/task']);

      },

      error: (error) => {

        console.log(error);

        alert(error.error);

      }

    });

  }

}