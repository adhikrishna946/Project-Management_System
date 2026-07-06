import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [
    CommonModule,
    HttpClientModule,
    RouterModule
  ],
  templateUrl: './dashboard.html',
  styleUrls: ['./dashboard.css']
})
export class DashboardComponent implements OnInit {

  totalUsers = 0;
  totalProjects = 0;
  totalTasks = 0;
  completedTasks = 0;
  pendingTasks = 0;
  today = new Date();

 constructor(
  private http: HttpClient,
  private cdr: ChangeDetectorRef
) { }

  ngOnInit(): void {
    this.loadUsers();
    this.loadProjects();
    this.loadTasks();
  }

  loadUsers() {

    this.http.get<any[]>('https://localhost:7296/api/User/GetAll')
      .subscribe({

        next: (data) => {

          console.log('Users:', data);

          this.totalUsers = data.length;
this.cdr.detectChanges();
console.log('totalUsers =', this.totalUsers);

        },

        error: (err) => {

          console.error('User Error:', err);

        }

      });

  }

  loadProjects() {

    this.http.get<any[]>('https://localhost:7296/api/Project/GetAll')
      .subscribe({

        next: (data) => {

          console.log('Projects:', data);

          this.totalProjects = data.length;
this.cdr.detectChanges();
console.log('totalProjects =', this.totalProjects);

        },

        error: (err) => {

          console.error('Project Error:', err);

        }

      });

  }

  loadTasks() {

    this.http.get<any[]>('https://localhost:7296/api/Task/GetAll')
      .subscribe({

        next: (data) => {

          console.log('Tasks:', data);
this.totalTasks = data.length;

this.completedTasks =
  data.filter(x => x.status === 'Completed').length;

this.pendingTasks =
  data.filter(x => x.status !== 'Completed').length;

console.log('totalTasks =', this.totalTasks);
console.log('completedTasks =', this.completedTasks);
console.log('pendingTasks =', this.pendingTasks);
          this.completedTasks =
            data.filter(x => x.status === 'Completed').length;

          this.pendingTasks =
            data.filter(x => x.status !== 'Completed').length;

            this.cdr.detectChanges();

        },

        error: (err) => {

          console.error('Task Error:', err);

        }

      });

  }

}