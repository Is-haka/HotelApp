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
  hotel: string = '';
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
      this.currentStep = 4;
    }
  }

  nextStep() {
    if (this.currentStep === 1 && this.region) {
      this.messages.push({
        text: `Region: ${this.region}`,
        sender: undefined
      });
      this.currentStep++;
    } else if (this.currentStep === 2 && this.hotel) {
      this.messages.push({
        text: `Hotel: ${this.hotel}`,
        sender: undefined
      });
      this.currentStep++;
    } else if (this.currentStep === 3 && this.location) {
      this.messages.push({
        text: `Location: ${this.location}`,
        sender: undefined
      });
      this.bookRoom();
      this.currentStep++;
    } else if (this.currentStep === 4 && this.complaint) {
      this.submitComplaint();
    }
  }

  bookRoom() {
    this.messages.push({
      text: `Booking room at ${this.hotel}, ${this.location}, ${this.region}`,
      sender: undefined
    });
    this.messages.push({
      text: 'Do you have any complaints or comments?',
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
    this.hotel = '';
    this.location = '';
    this.complaint = '';
    this.userChoice = '';
  }
}
