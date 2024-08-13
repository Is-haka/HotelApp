import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class RegionService {
  private apiUrl = 'http://localhost:3001/api/regions';

  constructor(private http: HttpClient) { }

  // Get all regions
  getRegions(): Observable<any> {
    return this.http.get<any>(this.apiUrl);
  }

  // Insert a new region
  addRegion(region: { name: string }): Observable<any> {
    return this.http.post<any>(this.apiUrl, region);
  }
}
