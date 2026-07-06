import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-project-edit',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    HttpClientModule,
    RouterModule
  ],
  templateUrl: './project-edit.html',
  styleUrls: ['./project-edit.css']
})
export class ProjectEditComponent implements OnInit {

  project = {
    projectId: 0,
    projectCode: '',
    projectName: '',
    description: '',
    startDate: '',
    endDate: '',
    status: '',
    createdBy: 'Admin'
  };

  constructor(
    private http: HttpClient,
    private route: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit(): void {

    const id = Number(this.route.snapshot.paramMap.get('id'));

    this.http.get<any>(
      'https://localhost:7296/api/Project/GetById/' + id
    ).subscribe({

      next: (response) => {

        this.project = response;

      },

      error: (error) => {

        console.log(error);

        alert('Unable to load project.');

      }

    });

  }

  updateProject() {

    this.http.post(
      'https://localhost:7296/api/Project/Save',
      this.project,
      { responseType: 'text' }
    ).subscribe({

      next: (response) => {

        alert(response);

        this.router.navigate(['/project']);

      },

      error: (error) => {

        console.log(error);

        alert(error.error);

      }

    });

  }

}