import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './login.html',
  styleUrl: './login.css'
})
export class Login {

  username = '';
  password = '';

  constructor(
  private http: HttpClient,
  private router: Router
) { }

  login() {

    console.log("Username:", this.username);
    console.log("Password:", this.password);

    const loginData = {
      userName: this.username,
      password: this.password
    };

    this.http.post(
      'https://localhost:7296/api/Auth/Login',
      loginData
    ).subscribe({
      next: (response: any) => {
        console.log("SUCCESS:", response);
        alert('Login Successful');
        this.router.navigate(['/dashboard']);
      },
      error: (error: any) => {
        console.log("ERROR:", error);
        alert('Invalid Username or Password');
      }
    });

  }
}