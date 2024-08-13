import { CommonModule, NgFor } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule, NgFor, FormsModule],
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.css']
})
export class IndexComponent implements OnInit {
  region: string = '';
  checkInDate: string = '';
  checkOutDate: string = '';
  location: string = '';
  complaint: string = '';
  currentStep: number = 0;
  userChoice: string = '';
  isInquiry: boolean = false;
  inquiryText: string = '';
  bookingNumber: string = '';
  additionalDetails: string = '';

  messages: { sender: any; text: string }[] = [];

  ngOnInit() {
    this.messages.push({
      text: 'Welcome! Please choose an option to proceed.',
      sender: undefined
    });
  }

  chooseOption(option: string) {
    this.userChoice = option;
    this.messages = [];
    if (option === 'Booking') {
      this.messages.push({
        text: 'You selected Booking. Please enter your region to start.',
        sender: undefined
      });
      this.currentStep = 1;
    } else if (option === 'Complaints/Inquiry') {
      this.messages.push({
        text: 'You selected Complaints/Inquiry. Click "Yes" for inquiry or "No" for complaints.',
        sender: undefined
      });
      this.currentStep = 5;
    }
  }

  handleYesNo(choice: string) {
    if (this.currentStep === 5) {
      this.isInquiry = choice === 'Yes';
      this.messages.push({
        text: this.isInquiry ? 'Please enter your inquiry.' : 'Please enter your booking number.',
        sender: undefined
      });
      this.currentStep = 6;
    }
  }

  yesNo(choice: string) {
    if (this.currentStep === 7) {
      if (this.isInquiry) {
        this.messages.push({
          text: choice === 'Yes' ? 'Please provide more details about your inquiry.' : 'Thank you for your prompt response.',
          sender: undefined
        });
      } else {
        this.messages.push({
          text: choice === 'Yes' ? 'Please provide more details about your complaint.' : 'Thank you for your prompt response.',
          sender: undefined
        });
      }
      this.currentStep = 8; // Move to the next step after handling additional details
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
    } else if (this.currentStep === 3 && this.checkOutDate) {
      this.messages.push({
        text: `Check-out date: ${this.checkOutDate}`,
        sender: undefined
      });
      this.bookRoom();
      this.currentStep++;
    } else if (this.currentStep === 6) {
      if (this.isInquiry && this.inquiryText) {
        this.currentStep = 7; // Proceed to the next step if inquiry is entered
      } else if (!this.isInquiry && this.bookingNumber) {
        this.currentStep = 7; // Proceed to the next step if booking number is entered
      }
    } else if (this.currentStep === 8) {
      if (this.isInquiry && this.inquiryText) {
        this.submitInquiry();
      } else if (!this.isInquiry && this.bookingNumber) {
        this.submitComplaint();
      }
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

  submitInquiry() {
    this.messages.push({
      text: `Your inquiry: ${this.inquiryText}`,
      sender: undefined
    });
    this.messages.push({
      text: 'Thank you for your inquiry. We will respond shortly.',
      sender: undefined
    });
    this.resetChat();
  }

  submitComplaint() {
    this.messages.push({
      text: `Your booking number: ${this.bookingNumber}`,
      sender: undefined
    });
    this.messages.push({
      text: 'Thank you for your complaint. We will investigate and get back to you soon.',
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
    this.isInquiry = false;
    this.inquiryText = '';
    this.bookingNumber = '';
    this.additionalDetails = '';
  }
}
