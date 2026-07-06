import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-user-edit',
  standalone: true,
  imports: [
  CommonModule,
  FormsModule,
  HttpClientModule,
  RouterModule
],
  templateUrl: './user-edit.html',
  styleUrls: ['./user-edit.css']
})
export class UserEditComponent implements OnInit {

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
    private route: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit(): void {

    const id = Number(this.route.snapshot.paramMap.get('id'));

    this.http.get<any>('https://localhost:7296/api/User/GetById/' + id)
      .subscribe({

        next: (response) => {

          console.log(response);
          this.user = response;

        },

        error: (error) => {

          console.log(error);
          alert('Unable to load user details');

        }

      });

  }

  updateUser() {

    this.http.post<any>(
      'https://localhost:7296/api/User/Save',
      this.user
    ).subscribe({

      next: (response) => {

        console.log('Update Response:', response);

        alert(response.text);

        this.router.navigate(['/user']);

      },

      error: (error) => {

        console.log('Update Error:', error);

        if (typeof error.error === 'string') {
          alert(error.error);
        }
        else if (error.error?.text) {
          alert(error.error.text);
        }
        else if (error.error?.message) {
          alert(error.error.message);
        }
        else {
          alert('Something went wrong');
        }

      }

    });

  }

}