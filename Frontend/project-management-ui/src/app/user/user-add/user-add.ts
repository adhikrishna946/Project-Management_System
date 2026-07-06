import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Router } from '@angular/router';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-user-add',
  standalone: true,
  imports: [
  CommonModule,
  FormsModule,
  HttpClientModule,
  RouterModule
],
  templateUrl: './user-add.html',
  styleUrls: ['./user-add.css']
})
export class UserAddComponent {

  user = {
    userId: 0,
    userName: '',
    fullName: '',
    email: '',
    password: '',
    role: '',
    createdBy: 'Admin'
  };

  constructor(
    private http: HttpClient,
    private router: Router
  ) { }

  saveUser() {

    this.http.post(
      'https://localhost:7296/api/User/Save',
      this.user,
      { responseType: 'text' }      // ⭐ This is the important change
    )
    .subscribe({

      next: (response) => {

        alert(response);

        this.router.navigate(['/user']);

      },

      error: (error) => {

    console.log(error);

    alert(JSON.stringify(error));

}
    });

  }

}