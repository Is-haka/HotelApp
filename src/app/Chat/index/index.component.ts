import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.css'],
})
export class IndexComponent implements OnInit {
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
  firstname: string = '';
  lastname: string = '';
  email: string = '';
  regionId: number = 0;

  messages: {
    sender: 'bot' | 'user' | undefined;
    text: string;
  }[] = [];

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.messages.push({
      text: 'Welcome! Please choose an option to proceed.',
      sender: 'bot',
    });
  }

  chooseOption(option: string) {
    this.userChoice = option;
    this.messages = [];

    if (option === 'Booking') {
      this.messages.push({
        text: 'You selected Booking. Please enter your region to start.',
        sender: 'bot',
      });
      this.currentStep = 1;
    } else if (option === 'Complaints/Inquiry') {
      this.messages.push({
        text: 'You selected Complaints/Inquiry. Please enter your complaint or inquiry.',
        sender: 'bot',
      });
      this.currentStep = 1;
    }
  }

  nextStep() {
    switch (this.currentStep) {
      case 1:
        if (this.region) {
          this.messages.push({
            text: 'Please select the start and end date.',
            sender: 'bot',
          });
          this.currentStep = 2;
        }
        break;
      case 2:
        if (this.startDate && this.endDate) {
          this.calculateDays();
          this.fetchHotels();
        } else {
          this.messages.push({
            text: 'Please enter both start and end dates.',
            sender: 'bot',
          });
        }
        break;
      case 3:
        if (this.selectedHotel) {
          this.fetchRooms();
        } else {
          this.messages.push({
            text: 'Please select a hotel first.',
            sender: 'bot',
          });
        }
        break;
      case 4:
        if (this.selectedRoom) {
          this.currentStep = 5; // Move to the personal details step
        } else {
          this.messages.push({
            text: 'Please select a room type.',
            sender: 'bot',
          });
        }
        break;
      case 5:
        if (this.firstname && this.lastname && this.email) {
          this.generateBookingNumber();
          this.messages.push({
            text: 'Please review your booking details.',
            sender: 'bot',
          });
          this.currentStep = 6; // Move to the review step
        } else {
          this.messages.push({
            text: 'Please fill in all your personal details before proceeding.',
            sender: 'bot',
          });
        }
        break;
      default:
        this.messages.push({
          text: 'Something went wrong. Please try again.',
          sender: 'bot',
        });
    }
  }

  calculateDays() {
    const startDate = new Date(this.startDate);
    const endDate = new Date(this.endDate);
    const timeDifference = endDate.getTime() - startDate.getTime();
    this.days = Math.round(timeDifference / (1000 * 3600 * 24));
  }

  fetchHotels() {
    const startDate = encodeURIComponent(this.startDate);
    const endDate = encodeURIComponent(this.endDate);
    const regionName = encodeURIComponent(this.region); // Ensure regionName is set

    // Fetch the region ID based on the region name
    this.http
      .get(`http://localhost:3000/region/id?name=${regionName}`)
      .subscribe(
        (response: any) => {
          if (response.status) {
            this.regionId = response.data;
            this.regionName = response.name;

            // Now fetch available hotels based on the start date, end date, and region ID
            this.http
              .get(`http://localhost:3000/available?region_id=${this.regionId}`)
              .subscribe(
                (response: any) => {
                  if (response.status) {
                    this.hotels = this.groupRoomsByHotel(response.data);
                    if (this.hotels.length > 0) {
                      this.messages.push({
                        text: 'Please select a hotel from the list:',
                        sender: 'bot',
                      });
                      this.currentStep = 3; // Move to the hotel selection step
                    } else {
                      this.messages.push({
                        text: 'No hotels available for the selected dates. You will be redirected shortly.',
                        sender: 'bot',
                      });
                      this.startCountdown(5000); // Start countdown for 5 seconds
                    }
                  } else {
                    this.messages.push({
                      text: 'Failed to fetch hotels. Please try again later.',
                      sender: 'bot',
                    });
                  }
                },
                (error) => {
                  console.error('HTTP error:', error);
                  this.messages.push({
                    text: 'An error occurred while fetching hotels. Please try again later.',
                    sender: 'bot',
                  });
                }
              );
          } else {
            this.messages.push({
              text: 'Failed to fetch region data. Please try again later.',
              sender: 'bot',
            });
          }
        },
        (error) => {
          console.error('HTTP error:', error);
          this.messages.push({
            text: 'An error occurred while fetching region data. Please try again later.',
            sender: 'bot',
          });
        }
      );
  }

  fetchRooms() {
    if (!this.selectedHotel) return;

    this.http
      .get(`http://localhost:3000/rooms?hotel_id=${this.selectedHotel}`)
      .subscribe(
        (response: any) => {
          if (response.status) {
            this.rooms = response.data;
            this.messages.push({
              text: 'Please select a room type:',
              sender: 'bot',
            });
            this.currentStep = 4; // Move to the room selection step
          } else {
            this.messages.push({
              text: 'Failed to fetch rooms. Please try again later.',
              sender: 'bot',
            });
          }
        },
        (error) => {
          this.messages.push({
            text: 'An error occurred while fetching rooms. Please try again later.',
            sender: 'bot',
          });
        }
      );
  }

  groupRoomsByHotel(data: any[]) {
    const groupedHotels: any[] = [];
    data.forEach((item) => {
      let hotel = groupedHotels.find((h) => h.hotel_id === item.hotel_id);
      if (!hotel) {
        hotel = {
          hotel_id: item.hotel_id,
          hotel_name: item.hotel_name,
          rooms: [],
        };
        groupedHotels.push(hotel);
      }
      hotel.rooms.push({
        id: item.room_id,
        type: item.room_type,
        price: item.room_price,
        available_rooms: item.available_rooms,
      });
    });
    return groupedHotels;
  }

  selectHotel(hotelId: string) {
    this.selectedHotel = hotelId;
    const selectedHotel = this.hotels.find((h) => h.hotel_id === hotelId);
    this.selectedHotelName = selectedHotel ? selectedHotel.hotel_name : '';
    this.messages.push({
      text: `Hotel selected: ${this.selectedHotelName}`,
      sender: 'user',
    });
    this.nextStep(); // Proceed to the next step
  }

  selectRoom(roomId: number) {
    const selectedHotel = this.hotels.find(
      (h) => h.hotel_id === this.selectedHotel
    );
    const selectedRoom = selectedHotel?.rooms.find(
      (r: { id: number }) => r.id === roomId
    );
    if (selectedRoom) {
      this.selectedRoom = selectedRoom.id;
      this.selectedRoomType = selectedRoom.type;
      this.selectedRoomPrice = selectedRoom.price;
      this.messages.push({
        text: `Room selected: ${this.selectedRoomType} - $${this.selectedRoomPrice}`,
        sender: 'user',
      });
      this.nextStep(); // Proceed to personal details step
    }
  }

  generateBookingNumber() {
    const randomNum = Math.floor(Math.random() * 10000) + 1;
    this.bookingNumber = `BK${randomNum}`;
  }

  bookRoom() {
    this.http
      .get(`http://localhost:3000/region/id?name=${this.region}`)
      .subscribe(
        (response: any) => {
          if (response.status) {
            this.regionId = response.data;
            this.regionName = response.name;

            this.http
              .post(`http://localhost:3000/booking/create`, {
                firstname: this.firstname,
                lastname: this.lastname,
                email: this.email,
                room: this.selectedRoom,
                duration: this.days,
                hotel_id: this.selectedHotel,
                region_id: this.regionId,
                book_no: this.bookingNumber,
                start_date: this.startDate,
                end_date: this.endDate,
              })
              .subscribe(
                (response: any) => {
                  if (response.status) {
                    this.bookingStatus = 'success';
                    this.messages.push({
                      text: `Booking confirmed at ${this.selectedHotelName}. Your booking number is ${this.bookingNumber}.`,
                      sender: 'bot',
                    });
                  } else {
                    this.bookingStatus = 'failed';
                    this.messages.push({
                      text: 'Booking failed. Please try again.',
                      sender: 'bot',
                    });
                  }

                },
                (error) => {
                  this.messages.push({
                    text: 'An error occurred while booking. Please try again later.',
                    sender: 'bot',
                  });
                }
              );
          } else {
            this.messages.push({
              text: 'Region not found. Please try again.',
              sender: 'bot',
            });
          }
        },
        (error) => {
          this.messages.push({
            text: 'An error occurred while fetching region data. Please try again later.',
            sender: 'bot',
          });
        }
      );
  }

  startCountdown(duration: number) {
    this.countdownActive = true;
    setTimeout(() => {
      this.resetChat();
    }, duration);
  }

  submitComplaint() {
    if (this.complaint) {
      this.http
        .post('http://localhost:3000/complaints', {
          complaint: this.complaint,
          email: this.email,
        })
        .subscribe(
          (response: any) => {
            if (response.status) {
              this.messages.push({
                text: 'Your complaint has been submitted successfully.',
                sender: 'bot',
              });
              this.complaint = ''; // Clear the complaint field
            } else {
              this.messages.push({
                text: 'Failed to submit your complaint. Please try again later.',
                sender: 'bot',
              });
            }
          },
          (error) => {
            this.messages.push({
              text: 'An error occurred while submitting your complaint. Please try again later.',
              sender: 'bot',
            });
          }
        );
    } else {
      this.messages.push({
        text: 'Please enter a complaint before submitting.',
        sender: 'bot',
      });
    }
  }

  resetChat() {
    this.currentStep = 0;
    this.userChoice = '';
    this.bookingStatus = '';
    this.selectedHotel = '';
    this.selectedRoom = 0;
    this.region = '';
    this.startDate = '';
    this.endDate = '';
    this.firstname = '';
    this.lastname = '';
    this.email = '';
    this.messages = [
      {
        text: 'Welcome! Please choose an option to proceed.',
        sender: 'bot',
      },
    ];
  }
}
