import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.css']
})
export class IndexComponent implements OnInit {
  bookingStatus: string = '';
  selectedHotelName: string = '';
  selectedRoomType: string = '';
  selectedRoomPrice: number = 0;
  region: string = '';
  selectedHotel: string = '';
  selectedRoom: string = '';
  startDate: string = '';
  endDate: string = '';
  complaint: string = '';
  currentStep: number = 0;
  userChoice: string = '';
  hotels: any[] = [];
  rooms: any[] = [];
  bookingNumber: string = '';
  countdownActive: boolean = false;
  days: number = 0;

  messages: {
    sender: any;
    text: string;
    value?: string;
  }[] = [];

  constructor(private http: HttpClient) {}

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
        text: 'You selected Complaints/Inquiry. Please enter your complaint or inquiry.',
        sender: undefined
      });
      this.currentStep = 4;
    }
  }

  nextStep() {
    console.log('Current Step:', this.currentStep);

    switch (this.currentStep) {
      case 1:
        if (this.region) {
          console.log(this.startDate + " " + this.endDate);
          this.messages.push({
            text: 'Please select the start and end date',
            sender: undefined
          });
          this.currentStep = 2;
        }
        break;
      case 2:
        if (this.startDate && this.endDate) {
          this.fetchHotels();
          this.currentStep = 3;
        }
        break;
      case 3:
        this.fetchRooms();
        this.currentStep = 4;
        break;
      case 4:
          this.generateBookingNumber();
          this.currentStep = 5;
          this.messages.push({
            text: 'Please review your booking details.',
            sender: 'bot'
          });
        break;
    }

    console.log('New Step:', this.currentStep);
  }

  fetchHotels() {
    const regionId = encodeURIComponent(this.region);
    const startDate = new Date(this.startDate);
    const endDate = new Date(this.endDate);

  // Calculate the interval in days
  const timeDifference = endDate.getTime() - startDate.getTime();
  const daysDifference = Math.round(timeDifference / (1000 * 3600 * 24));
  const interval = encodeURIComponent(daysDifference);

  this.days = daysDifference;

    this.http.get(`http://localhost:3000/hotel?region_id=${regionId}&duration=${interval}`).subscribe(
      (response: any) => {
        if (response.status) {
          this.hotels = response.data;
          if (this.hotels.length > 0) {
            this.messages.push({
              text: 'Please select a hotel from the list:',
              sender: 'bot'
            });
            this.currentStep = 3;
          } else {
            this.messages.push({
              text: 'No hotels available in this region.',
              sender: 'bot'
            });
          }
        } else {
          this.messages.push({
            text: 'Failed to fetch hotels. Please try again later.',
            sender: 'bot'
          });
        }
      },
      error => {
        console.error('API Error:', error);
        this.messages.push({
          text: 'An error occurred while fetching hotels. Please try again later.',
          sender: 'bot'
        });
      }
    );
  }

  fetchRooms() {
    this.http.get(`http://localhost:3000/rooms?hotel_id=${this.selectedHotel}`).subscribe(
      (response: any) => {
        if (response.status) {
          this.rooms = response.data;
          this.messages.push({
            text: 'Please select a room type:',
            sender: 'bot'
          });
          this.currentStep = 4;
        } else {
          this.messages.push({
            text: 'Failed to fetch rooms. Please try again later.',
            sender: 'bot'
          });
        }
      },
      error => {
        console.error('API Error:', error);
        this.messages.push({
          text: 'An error occurred while fetching rooms. Please try again later.',
          sender: 'bot'
        });
      }
    );
  }

  selectHotel(hotelId: string) {
    this.selectedHotel = hotelId;
    const selectedHotel = this.hotels.find(h => h.id === hotelId);
    this.selectedHotelName = selectedHotel ? selectedHotel.name : '';
    this.messages.push({
      text: `Hotel selected: ${this.selectedHotelName}`,
      sender: 'user'
    });
    this.nextStep();
  }

  selectRoom(roomId: string) {
    this.selectedRoom = roomId;
    const selectedRoom = this.rooms.find(r => r.id === roomId);
    if (selectedRoom) {
      this.selectedRoomType = selectedRoom.type;
      this.selectedRoomPrice = selectedRoom.price;
      this.messages.push({
        text: `Room selected: ${this.selectedRoomType} - $${this.selectedRoomPrice}`,
        sender: 'user'
      });
    }
    this.nextStep();
  }

  generateBookingNumber() {
    const randomNum = Math.floor(Math.random() * 10000) + 1;
    this.bookingNumber = `BK${randomNum}`;
  }

  bookRoom() {
    this.http.post(`http://localhost:3000/booking/create`, {
      room: this.selectedRoom,
      duration: this.days,
      hotel_id: this.selectedHotel,
      region_id: this.region,
      book_no: this.bookingNumber,
      start_date: this.startDate,
      end_date: this.endDate
    }).subscribe((response: any) => {
      if (response.status) {
        this.bookingStatus = 'success';
        this.messages.push({
          text: `Booking confirmed at ${this.selectedHotelName}. Your booking number is ${this.bookingNumber}.`,
          sender: 'bot'
        });
      } else {
        this.bookingStatus = 'failed';
        this.messages.push({
          text: 'Booking failed. Please try again.',
          sender: 'bot'
        });
      }
      this.startCountdown(); // Start the countdown
    }, error => {
      console.error('Booking error:', error);
      this.bookingStatus = 'error';
      this.messages.push({
        text: 'An error occurred while booking. Please try again later.',
        sender: 'bot'
      });
      this.startCountdown(); // Start the countdown
    });
  }

  submitComplaint() {
    this.http.post(`http://localhost:3000/complaint/create`, { complaint: this.complaint }).subscribe((response: any) => {
      if (response.status) {
        this.messages.push({
          text: response.message,
          sender: 'bot'
        });
        this.startCountdown(); // Start the countdown
      }
    });
  }

  startCountdown() {
    this.countdownActive = true;
    // Set a timeout for 15 seconds (15000 milliseconds)
    setTimeout(() => {
      this.resetChat();
    }, 15000);
  }

  resetChat() {
    this.currentStep = 0;
    this.region = '';
    this.selectedHotel = '';
    this.selectedRoom = '';
    this.startDate = '';
    this.endDate = '';
    this.complaint = '';
    this.userChoice = '';
    this.hotels = [];
    this.rooms = [];
    this.bookingNumber = '';
    this.bookingStatus = ''; // Reset booking status
    this.countdownActive = false;
    this.days = 0;
    this.messages = [{
      text: 'Welcome! Please choose an option to proceed.',
      sender: undefined
    }];
  }
}
