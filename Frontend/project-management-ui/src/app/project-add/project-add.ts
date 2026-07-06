import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Router } from '@angular/router';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-project-add',
  standalone: true,
  imports: [
  CommonModule,
  FormsModule,
  HttpClientModule,
  RouterModule
],
  templateUrl: './project-add.html',
  styleUrls: ['./project-add.css']
})
export class ProjectAddComponent {

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
    private router: Router
  ) { }

  saveProject() {

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

