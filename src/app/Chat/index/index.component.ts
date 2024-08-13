import { CommonModule, NgFor } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule,NgFor,FormsModule],
  templateUrl: './index.component.html',
  styleUrl: './index.component.css'
})
export class IndexComponent implements OnInit {
  region: string = '';
  checkInDate: string = '';
  checkOutDate: string = '';
  location: string = '';
  complaint: string = '';
  currentStep: number = 0;
  userChoice: string = '';

  messages: {
sender: any; text: string
}[] = [];

  ngOnInit() {
    this.messages.push({
      text: 'Welcome! Please choose an option to proceed.',
      sender: undefined
    });
  }

  chooseOption(option: string) {
    this.userChoice = option;
    this.messages=[];
    if (option === 'Booking') {
      this.messages.push({
        text: 'You selected Booking. Please enter your region to start.',
        sender: undefined
      });
      this.currentStep = 1;
    } else if (option === 'Complaints/Inquiry') {
      this.messages.push({
        text: 'You selected Complaints/Inquiry. Please enter your complaint or inquiry.',
        sender: undefined
      });
      this.currentStep = 5;
    }
  }

  nextStep() {
    if (this.currentStep === 1 && this.region) {
      this.messages.push({
        text: `Region: ${this.region}`,
        sender: undefined
      });
      this.currentStep++;
    } else if (this.currentStep === 2 && this.checkInDate) {
      this.messages.push({
        text: `Check-in date: ${this.checkInDate}`,
        sender: undefined
      });
      this.currentStep++;
    }  else if(this.currentStep === 3 && this.checkOutDate) {
      this.messages.push({
        text: `Check-out date: ${this.checkOutDate}`,
        sender: undefined
      });
      this.bookRoom();
      this.currentStep++;
    }
  }

  bookRoom() {
    this.messages.push({
      text: `Booking room at ${this.checkInDate}, ${this.checkOutDate}, ${this.region}`,
      sender: undefined
    });
    this.messages.push({
      text: 'Thank you for booking with us!',
      sender: undefined
    });
  }

  submitComplaint() {
    this.messages.push({
      text: `Complaint: ${this.complaint}`,
      sender: undefined
    });
    this.resetChat();
  }

  resetChat() {
    this.currentStep = 0;
    this.region = '';
    this.checkInDate = '';
    this.checkOutDate = '';
    this.location = '';
    this.complaint = '';
    this.userChoice = '';
  }
}
