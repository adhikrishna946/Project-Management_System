import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-user',
  standalone: true,
  imports: [
    CommonModule,
    HttpClientModule,
    RouterModule
  ],
  templateUrl: './user.html',
  styleUrls: ['./user.css']
})
export class UserComponent implements OnInit {

  users: any[] = [];

  constructor(
    private http: HttpClient,
    private cdr: ChangeDetectorRef
  ) { }

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers(): void {

    this.http.get<any[]>('https://localhost:7296/api/User/GetAll')
      .subscribe({

        next: (response) => {

          console.log(response);
          this.users = response;
          this.cdr.detectChanges();

        },

        error: (error) => {

          console.log(error);

        }

      });

  }

  deleteUser(id: number): void {

    if (confirm('Are you sure you want to delete this user?')) {

      this.http.delete(
  'https://localhost:7296/api/User/Delete/' + id,
  { responseType: 'text' }
)
        .subscribe({

          next: (response) => {

            alert('User Deleted Successfully');

            this.loadUsers();

          },

          error: (error) => {

            console.log(error);

            alert('Unable to delete user.');

          }

        });

    }

  }

}