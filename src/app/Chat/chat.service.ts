import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { map, Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ChatService {

  private apiURL = "http://localhost:3000";

  httpOptions = {
    Headers: new HttpHeaders ({
      'Content-type': 'application/json'
    })
  };


  constructor(private httpClient: HttpClient) { }

  
}
