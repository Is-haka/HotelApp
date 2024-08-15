import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule, FormBuilder, FormGroup, Validators, AbstractControl } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.css']
})
export class IndexComponent implements OnInit {
  userForm!: FormGroup;



  bookingStatus: string = '';
  selectedHotelName: string = '';
  selectedRoomType: string = '';
  selectedRoomPrice: number = 0;
  region: string = '';
  selectedHotel: string = '';
  selectedRoom: number = 0;
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
  regionName: string = '';

  messages: {
    sender: any;
    text: string;
    value?: string;
  }[] = [];

  constructor(private http: HttpClient, private user_form: FormBuilder) {}

  ngOnInit() {
    this.userForm = this.user_form.group({
      region: ['', [Validators.required, Validators.minLength(4)]],
      startDate: ['', [Validators.required, this.dateValidator()]],
      endDate: ['', [Validators.required, this.dateValidator()]]
    });
  }

  dateValidator() {
    return (control: AbstractControl): {[key: string]: any} | null => {
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      const inputDate = new Date(control.value);
      inputDate.setHours(0, 0, 0, 0);

      if (inputDate < today) {
        return { 'pastDate': true };
      }
      return null;
    };
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
        if (this.userForm.get('region')?.valid) {
          // Proceed to next step
          console.log('Region is valid:', this.userForm.get('region')?.value);
          this.currentStep = 2; // Move to Step 2
          this.messages.push({
            text: 'Please enter the start and end date.',
            sender: 'bot'
          });
        } else {
          // Show error message
          console.log('Please enter a valid region');
          this.messages.push({
            text: 'Please enter a valid region before proceeding.',
            sender: 'bot'
          });
        }
        break;

      case 2:
        // Retrieve date values from form controls
        const startDate = this.userForm.get('startDate')?.value;
        const endDate = this.userForm.get('endDate')?.value;

        if (startDate && endDate) {
          this.startDate = startDate; // Set class properties
          this.endDate = endDate;

          if (this.userForm.get('startDate')?.valid && this.userForm.get('endDate')?.valid) {
            this.calculateDays();
            this.fetchHotels();
            this.currentStep = 3; // Move to Step 3
          } else {
            console.log('Please enter valid dates');
            this.messages.push({
              text: 'Please enter valid start and end dates before proceeding.',
              sender: 'bot'
            });
          }
        } else {
          console.log('Start date and end date are required');
          this.messages.push({
            text: 'Start date and end date are required.',
            sender: 'bot'
          });
        }
        break;

      case 3:
        if (this.selectedHotel) {
          this.fetchRooms(); // Fetch rooms for the selected hotel
          this.currentStep = 4; // Move to Step 4
        } else {
          console.log('Please select a hotel');
          this.messages.push({
            text: 'Please select a hotel before proceeding.',
            sender: 'bot'
          });
        }
        break;

      case 4:
        this.generateBookingNumber();
        this.messages.push({
          text: 'Please review your booking details.',
          sender: 'bot'
        });
        this.currentStep = 5; // Move to Step 5
        break;
    }

    console.log('New Step:', this.currentStep);
  }



  calculateDays() {
    const startDate = new Date(this.startDate);
    const endDate = new Date(this.endDate);

    // Calculate the interval in days
    const timeDifference = endDate.getTime() - startDate.getTime();
    this.days = Math.round(timeDifference / (1000 * 3600 * 24));
  }

  fetchHotels() {
    const startDate = encodeURIComponent(this.startDate);
    const endDate = encodeURIComponent(this.endDate);

    this.http.get(`http://localhost:3000/available?start_date=${startDate}&end_date=${endDate}`).subscribe(
      (response: any) => {
        console.log('API Response:', response); // Log the entire response
        if (response.status) {
          // Transform the response data
          this.hotels = this.groupRoomsByHotel(response.data);
          console.log('Transformed Hotels:', this.hotels); // Log the transformed hotels
          if (this.hotels.length > 0) {
            this.messages.push({
              text: 'Please select a hotel from the list:',
              sender: 'bot'
            });
          } else {
            this.messages.push({
              text: 'No hotels available for the selected dates.',
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
    if (!this.selectedHotel) return;

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


groupRoomsByHotel(data: any[]) {
  const groupedHotels: any[] = [];
  console.log("Data zetu", data);
  data.forEach(item => {
    let hotel = groupedHotels.find(h => h.hotel_id === item.hotel_id);
    if (!hotel) {
      hotel = {

        hotel_id: item.hotel_id,
        hotel_name: item.hotel_name,
        rooms: []
      };
      groupedHotels.push(hotel);
    }
    hotel.rooms.push({
      id: item.room_id, // room id for specific hotel
      type: item.room_type,
      price: item.room_price,
      available_rooms: item.available_rooms
    });
  });

  return groupedHotels;
}


  selectHotel(hotelId: string) {
    this.selectedHotel = hotelId;
    const selectedHotel = this.hotels.find(h => h.hotel_id === hotelId);
    this.selectedHotelName = selectedHotel ? selectedHotel.hotel_name : '';
    this.messages.push({
      text: `Hotel selected: ${this.selectedHotelName}`,
      sender: 'user'
    });
    this.nextStep(); // Proceed to next step after selecting hotel
  }

  selectRoom(roomId: number) {
    if (!this.selectedHotel) {
      console.error('No hotel selected.');
      return;
    }

    // Find the selected hotel
    const selectedHotel = this.hotels.find(h => h.hotel_id === this.selectedHotel);
    if (!selectedHotel) {
      console.error('Selected hotel not found.');
      return;
    }

    // Find the selected room
    const selectedRoom = selectedHotel.rooms.find((r: { id: number; }) => r.id === roomId); // Ensure the ID matches the property
    if (selectedRoom) {
      this.selectedRoom = selectedRoom.id;
      this.selectedRoomType = selectedRoom.type;
      this.selectedRoomPrice = selectedRoom.price;

      console.log('Selected Room:', selectedRoom.id); // Debugging line

      this.messages.push({
        text: `Room selected: ${this.selectedRoomType} - $${this.selectedRoomPrice}`,
        sender: 'user'
      });

      this.nextStep(); // Proceed to the next step
    } else {
      console.error('Room not found.');
    }
  }






  generateBookingNumber() {
    const randomNum = Math.floor(Math.random() * 10000) + 1;
    this.bookingNumber = `BK${randomNum}`;
  }

  bookRoom() {
    console.log('Booking Details:', {
      room: this.selectedRoom,
      duration: this.days,
      hotel_id: this.selectedHotel,
      region_id: this.regionName, // Ensure this is correct
      book_no: this.bookingNumber,
      start_date: this.startDate,
      end_date: this.endDate
    });

    this.http.get(`http://localhost:3000/region/id?name=${this.region}`).subscribe((response: any) => {
      console.log(this.region);
      if (response.status) {
        const regionId = response.data;
        this.regionName = response.name;
        console.log(this.regionName);

        this.http.post(`http://localhost:3000/booking/create`, {
          room: this.selectedRoom,
          duration: this.days,
          hotel_id: this.selectedHotel,
          region_id: regionId,
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
          this.startCountdown();
        }, error => {
          console.error('Booking error:', error);
          this.bookingStatus = 'error';
          this.messages.push({
            text: 'An error occurred while booking. Please try again later.',
            sender: 'bot'
          });
          this.startCountdown();
        });
      } else {
        console.error('Error fetching region ID:', response.message);
        this.bookingStatus = 'error';
        this.messages.push({
          text: 'Error fetching region ID. Please try again.',
          sender: 'bot'
        });
      }
    }, error => {
      console.error('Error fetching region ID:', error);
      this.bookingStatus = 'error';
      this.messages.push({
        text: 'An error occurred while fetching region ID. Please try again later.',
        sender: 'bot'
      });
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
    this.selectedRoom = 0;
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
