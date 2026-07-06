import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-project',
  standalone: true,
  imports: [
    CommonModule,
    HttpClientModule,
    RouterModule
  ],
  templateUrl: './project.html',
  styleUrls: ['./project.css']
})
export class ProjectComponent implements OnInit {

  projects: any[] = [];

  constructor(
    private http: HttpClient,
    private cdr: ChangeDetectorRef
  ) { }

  ngOnInit(): void {
    this.loadProjects();
  }

  loadProjects(): void {

    this.http.get<any[]>(
      'https://localhost:7296/api/Project/GetAll'
    ).subscribe({

      next: (response) => {

        this.projects = response;

        this.cdr.detectChanges();

      },

      error: (error) => {

        console.log(error);

      }

    });

  }

  deleteProject(id: number) {

    if (!confirm('Are you sure you want to delete this project?')) {
      return;
    }

    this.http.delete(
      'https://localhost:7296/api/Project/Delete/' + id,
      { responseType: 'text' }
    ).subscribe({

      next: (response) => {

        alert(response);

        this.loadProjects();

      },

      error: (error) => {

        console.log(error);

        alert(error.error);

      }

    });

  }

}