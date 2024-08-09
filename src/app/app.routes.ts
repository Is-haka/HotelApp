import { Routes } from '@angular/router';
import { IndexComponent } from './start/index/index.component';

export const routes: Routes = [
  {path: '', redirectTo: 'start/index', pathMatch: 'full'},
  {path: 'start/index', component: IndexComponent}
];
