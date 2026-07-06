import { Routes } from '@angular/router';

import { Login } from './login/login';
import { LayoutComponent } from './layout/layout';

import { DashboardComponent } from './dashboard/dashboard';

import { UserComponent } from './user/user';
import { UserAddComponent } from './user/user-add/user-add';
import { UserEditComponent } from './user-edit/user-edit';

import { ProjectComponent } from './project/project';
import { ProjectAddComponent } from './project-add/project-add';
import { ProjectEditComponent } from './project-edit/project-edit';

import { TaskComponent } from './task/task';
import { TaskAddComponent } from './task-add/task-add';
import { TaskEditComponent } from './task-edit/task-edit';

export const routes: Routes = [

  // Login Page
  {
    path: '',
    component: Login
  },

  // Main Layout
  {
    path: '',
    component: LayoutComponent,
    children: [

      {
        path: 'dashboard',
        component: DashboardComponent
      },

      // User
      {
        path: 'user',
        component: UserComponent
      },
      {
        path: 'user-add',
        component: UserAddComponent
      },
      {
        path: 'user-edit/:id',
        component: UserEditComponent
      },

      // Project
      {
        path: 'project',
        component: ProjectComponent
      },
      {
        path: 'project-add',
        component: ProjectAddComponent
      },
      {
        path: 'project-edit/:id',
        component: ProjectEditComponent
      },

      // Task
      {
        path: 'task',
        component: TaskComponent
      },
      {
        path: 'task-add',
        component: TaskAddComponent
      },
      {
        path: 'task-edit/:id',
        component: TaskEditComponent
      }

    ]
  }

];