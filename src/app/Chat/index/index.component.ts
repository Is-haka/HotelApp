import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule, FormBuilder, FormGroup, Validators, AbstractControl, ReactiveFormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { last } from 'rxjs';
import { response } from 'express';
import { error } from 'node:console';


@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.css'],
})
export class IndexComponent implements OnInit {

userForm!: FormGroup;

  additionalDetails: string = '';
  isInquiry: any;
  inquiryText: string = '';
  choice: string = '';
  fullname: string = '';
  phone: string = '';


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
  currentComplainStep: number = 0;
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
  filteredRegions: any[] = [];
  filterdBookNo: any[] = [];
  returnedBookingDetails: any[] = [];
  minDate: string = '';
  minEndDate: string = '';
  maxEndDate: string = '';
  // place to handle or hold token here
  bookingTokens: number = 0; // To track the number of bookings
  lastBookingTime: Date | null = null; // To track the time of the last booking


  typeOfComplain: any [] = [];
  typeOfInquiry: any [] = [];
  typeId: number = 0;
  type_complain: string = '';
  relatedComplain: any[] = [];
  type_inquiry: string = '';
  selectedType: string = '';
  selectedInquiryType: string = '';
  selectedReletedComplainType: string = '';
  selectedReletedType: string = '';
  answer: any[] = [];
  relatedCompAnswer: any[] =[];
  botAnswer: string = '';



  messages: {
    sender: 'bot' | 'user' | undefined;
    text: string;
  }[] = [];
  noRegion: number = 0;


  constructor(private http: HttpClient, private user_form: FormBuilder) {}

  ngOnInit() {
    this.currentStep;
    this.currentComplainStep;
    this.setMinDate();
    this.createForm();
    this.listenToStartDateChanges();
  }

  /*
    * Date validator methods that validate dates
    * and check if they are valid and are of current
    *
  */

  createForm() {
    this.userForm = this.user_form.group({
     	region: ['', [Validators.required, Validators.minLength(4)]],
      firstname: ['', [Validators.required, Validators.minLength(4)]],
      lastname: ['', [Validators.required, Validators.minLength(4)]],
      email: ['', [Validators.required, Validators.email]],
      startDate: ['', [Validators.required, this.dateValidator('start')]],
      endDate: ['', [Validators.required, this.dateValidator('end')]],
      inquiryText: ['', [Validators.required, Validators.minLength(8)]],
      additionalDetails: ['', [Validators.required, Validators.minLength(10)]],
      fullname: ['', [Validators.required, Validators.minLength(4)]],
      phone: ['', [Validators.required, Validators.minLength(10)]],
      bookingNumber: ['', [Validators.required, Validators.minLength(5)]],
      myValue: ['', [Validators.nullValidator]]
    }, { validators: this.dateRangeValidator });
  }

  // Date validator method
  dateValidator(type: 'start' | 'end') {
    return (control: AbstractControl): { [key: string]: any } | null => {
      if (!control.value) {
        return null;  // Don't validate empty values to allow optional controls
      }
      const inputDate = new Date(control.value);
      if (type === 'start') {
        const minDate = new Date(this.minDate);
        if (inputDate < minDate) {
          return { pastDate: true };
        }
      } else if (type === 'end') {
        const minEndDate = new Date(this.minEndDate);
        const maxEndDate = new Date(this.maxEndDate);
        if (inputDate < minEndDate) {
          return { pastDate: true };
        }
        if (inputDate > maxEndDate) {
          return { futureDate: true };
        }
      }
      return null;
    };
  }

  // Date range validator method
  dateRangeValidator(formGroup: FormGroup): { [key: string]: any } | null {
    const startDate = formGroup.get('startDate')?.value;
    const endDate = formGroup.get('endDate')?.value;
    if (startDate && endDate && new Date(startDate) >= new Date(endDate)) {
      return { dateRangeInvalid: true };
    }
    return null;
  }

  // Method for setting date limit
  setMinDate() {
    const today = new Date();
    this.minDate = today.toISOString().split('T')[0];
  }

  // Method to update the minEndDate based on selected startDate
  updateMinEndDate(startDate: string) {
    if (startDate) {
      const start = new Date(startDate);

      // Set minEndDate to one day after start date
      this.minEndDate = new Date(start.getTime() + 24 * 60 * 60 * 1000).toISOString().split('T')[0];

      // Set maxEndDate to 30 days after start date (adjust as needed)
      this.maxEndDate = new Date(start.getTime() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0];

      // Reset endDate if it's outside the new valid range
      const currentEndDate = this.userForm.get('endDate')?.value;
      if (currentEndDate) {
        const endDate = new Date(currentEndDate);
        if (endDate <= start || endDate > new Date(this.maxEndDate)) {
          this.userForm.get('endDate')?.setValue('');
        }
      }

      this.userForm.get('endDate')?.updateValueAndValidity();
    }
  }

  //method to check what start date is being selected before freezing it in the end date form fields
  listenToStartDateChanges() {
    this.userForm.get('startDate')?.valueChanges.subscribe(startDate => {
      if (startDate) {
        this.updateMinEndDate(startDate);
      }
    });


  }
//********************* */  FILTER REGION INFORMATION**************
searchRegion(event: Event) {
  const inputElement = event.target as HTMLInputElement;
  const query = inputElement.value;
//  console.log(query);
  if (query.length > 0) {
    this.http.get<any[]>(`http://localhost:3000/region?name=${query}`)
      .subscribe((response: any) => {
        this.filteredRegions = response.data;

      });
  } else {
    this.filteredRegions = [];
  }
}

// Handle the selection of a region
selectRegion(region: any) {
  // this.region = region.name;
  // Update the form control with the selected region name
  this.userForm.get('region')?.setValue(region.name);
  this.filteredRegions = []; // Clear the suggestions after selection
}

//Search Booking number
searchBookingNo(action: Event) {
  const bookingInput = action.target as HTMLInputElement;
  const qry = bookingInput.value;

  if(qry && qry.length > 0) {
    this.http.get<any[]>(`http://localhost:3000/bookNo?number=${qry}`).subscribe(
      (response: any) => {
        this.filterdBookNo = response.data;
      }, (error) => {
        console.error('Error fetching booking numbers:', error);
      }
    );
  } else {
    // If qry is undefined or has no length, clear the filtered list
    this.filterdBookNo = [];
  }
}

//Handle the selection of a booking number
selectBookNo(bkNo: any) {
    this.userForm.get('bookingNumber')?.setValue(bkNo.book_no);
    this.bookingNumber = this.userForm.get('bookingNumber')?.value;
    this.filterdBookNo = [];
}

//Method to get back one step
returnStep() {
  if(this.currentStep > 0) {
    this.currentStep = this.currentStep - 1;
    this.messages.pop();
  }
  if(this.currentComplainStep > 0) {
    this.currentComplainStep = this.currentComplainStep - 1;
    this.messages.pop();
  }
  this.noRegion = 0;
}

handleYesNo(choice: string) {
  if (this.currentComplainStep === 1) {
    this.isInquiry = choice === 'Yes';
    this.messages.push({
      text: this.isInquiry ? 'Please enter your fullname and phone number.' : 'Please enter your booking number.',
      sender: 'bot'
    });
    if(this.isInquiry === true) {
      this.currentComplainStep = 2;
    } else {
      this.currentComplainStep = 7;
    }
  }

  if(this.currentComplainStep === 4) {
    this.isInquiry = choice === 'Yes';
    this.messages.push({
      text: this.isInquiry ? 'Please tell us more about your concern by select the option below' : 'Thank you for reaching out to us, we keep our services improved by reaching us throught this portal',
      sender: 'bot'
    });
    // this.messages.push({
    //   text: this.isInquiry ? 'Please confirm your booking details below' : 'Thank you for reaching out to us, we keep our services improved by reaching us throught this portal',
    //   sender: 'bot'
    // });
    if(this.isInquiry === true) {
      this.currentComplainStep = 5;
    } else {
      this.currentComplainStep = 8;
    }
  }

  if(this.currentComplainStep === 8) {
    this.isInquiry = choice === 'Yes';
    this.messages.push({
      text: this.isInquiry ? `Please select type of complain below` : `Please enter the correct booking number`,
      sender: 'bot'
    });

    if(this.isInquiry === true) {
      this.currentComplainStep = 9;
    } else {
      this.currentComplainStep = 7;
    }
  }

  if(this.currentComplainStep === 10) {
    this.isInquiry = choice === 'Yes';
    this.messages.push({
      text: this.isInquiry ? `Yes` : `No`,
      sender: `user`
    });
    this.messages.push({
      text: this.isInquiry ? `You selected Yes, Thank you for giving us your thoughts, we will consider this in your booking` : `Please select related complain below`,
      sender: `bot`
    });

    if(this.isInquiry === true) {
      this.currentComplainStep = 13;
    } else {
      //For fetching more type of related complain
      this.fetchRelatedComplain();
      this.currentComplainStep = 11;
    }
  }
}

yesNo(choice: string) {
  if (this.currentComplainStep === 4) {
    if (this.isInquiry) {
      this.choice = choice;
      this.messages.push({
        text: this.choice === 'Yes' ? 'Please provide more details about your inquiry.' : 'Thank you for your prompt response.',
        sender: 'bot'
      });
      if(this.choice === "No") {
        this.currentComplainStep = 13;
      } else {
        this.currentComplainStep = 5;
      }
    } else {
      this.messages.push({
        text: choice === 'Yes' ? 'Please provide more details about your complaint.' : 'Thank you for your prompt response.',
        sender: 'bot'
      });
      this.currentComplainStep = 5; // Move to the next step after selecting additional details
    }
  }
}

//Check match between the value entered and that from array comes from database for booking number
isBookingNumberValid(): boolean {
  const bookingNumber = this.userForm.get('bookingNumber')?.value;
  // Check if the booking number exists in the filterdBookNo array
  return this.filterdBookNo.some((bkn) => bkn.book_no === bookingNumber);
}

//Check match between the value entered and that from array comes from database for region name

//Fetch value from booking table using booking number
fetchBooking() {
  const book_number = this.bookingNumber;
  this.http.get(`http://localhost:3000/bkn?bkn=${book_number}`).subscribe(
    (response: any) => {
      this.returnedBookingDetails = response.data;
    }, (error) => {
      console.error('error fetching booking details: ', error);
    }
  );
}

complainStep() {
  switch(this.currentComplainStep) {
    case 2:
      if(this.userForm.get('fullname')?.valid && this.userForm.get('phone')?.valid) {
          this.fullname = this.userForm.get('fullname')?.value;
          this.phone = this.userForm.get('phone')?.value;
          this.messages.push({
            text: `fullname: ${this.fullname} and phone number is ${this.phone}`,
            sender: `user`
          });
          this.messages.push({
            text: `Please select your inquiry from the list below`,
            sender: `bot`
          });
          this.fetchInquiry();
          this.currentComplainStep = 3;
        }else {
          this.messages.push({
            text: 'please fill out enter your fullname and phone number',
            sender: 'bot'
          });
        }
      break;
      case 3:
        this.fetchInquiryAnswer();
        this.currentComplainStep = 4;
        break;
      case 5:
        if(this.userForm.get('additionalDetails')?.valid) {
          this.inquiryText = this.userForm.get('additionalDetails')?.value;
          this.submitComplaint();
          this.currentComplainStep = 13;
        } else {
          this.messages.push({
            text: `Please provide your custom inquiry before submitting`,
            sender: `bot`
          });
        }
        break;
      case 6:
          this.currentComplainStep = 13;
          break;
      case 7:
        this.messages.push({
          text: `My booking number is: ${this.bookingNumber}`,
          sender: `user`
        });
        this.fetchBooking();
        if(this.filterdBookNo) {
          this.messages.push({
            text: `Please confirm your booking details below`,
            sender: `bot`
          });
          this.currentComplainStep = 8;
        } else {
          this.messages.push({
            text: `Please enter a valid booking number`,
            sender: `bot`
          });
        }

        break;
      case 9:
        this.fetchAnswer();
        this.currentComplainStep = 10;
        break;
      case 11:
        // //For fetching more type of related complain
        // this.fetchRelatedComplain();
        this.fetchRelatedComplainAnswer();
        break;
      case 13:
        this.messages.push({
          text: `Your complain has been processed successfully`,
          sender: `bot`
        });
  }
}

// *****************************************************************
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
      this.currentComplainStep = 1;
    }
  }

  nextStep() {
    switch (this.currentStep) {
      case 1:
      // fetch all region Name information hereee
        if (this.userForm.get('region')?.valid) {
          // Proceed to next step
          this.region = this.userForm.get('region')?.value;
          this.currentStep = 2; // Move to Step 2
        } else {
          // Show error message
          console.log('Please enter a valid region');
          this.messages.push({
            text: 'Please enter a valid region before proceeding.',
            sender: 'bot'
          });
          this.filteredRegions = []; // Clear the suggestions after moving to the next step
          this.currentStep = 2;
        }
    break;

      case 2:
        //check if it is inquiry values or date values from form control
        if(this.userForm.get('startDate')?.valid && this.userForm.get('endDate')?.valid) {
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
        this.firstname = this.userForm.get('firstname')?.value;
        this.lastname = this.userForm.get('lastname')?.value;
        this.email = this.userForm.get('email')?.value;
        if (this.firstname && this.lastname && this.email) {
          // this.generateBookingNumber();
          this.messages.push({
            text: 'Please review your booking details.',
            sender: 'bot',
          });
          this.currentStep = 6; // Move to the review step
          this.generateBookingNumber();
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
            this.messages.pop();
            this.messages.pop();
            this.noRegion = 1;
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

  fetchRelatedComplain() {
    const compId = this.selectedType
    this.http.get(`http://localhost:3000/relatedType?compId=${compId}`).subscribe(
      (response: any) => {
        this.relatedComplain = response.data;
      }
    )
  }


  onComplainSelect(complainId: number) {
    // Update selected related complain type
    this.selectedReletedComplainType = complainId.toString();

    // Push a message indicating user's selected complaint
    const selectedComplaint = this.relatedComplain.find(c => c.rid === complainId);
    if (selectedComplaint) {
      this.messages.push({
        text: `You selected: ${selectedComplaint.complain}`,
        sender: 'user'
      });
    }

    // Fetch the answer for the selected complain
    this.fetchRelatedComplainAnswer();
    this.currentComplainStep = 13;
  }

  fetchRelatedComplainAnswer() {
    console.log(this.currentComplainStep);
    const relatedCompId = parseInt(this.selectedReletedComplainType, 10);
    this.http.get(`http://localhost:3000/relatedAnswer?relatedCompId=${relatedCompId}`).subscribe(
      (response: any) => {
        if (response.status) {
          this.relatedCompAnswer = response.data;
          console.log(this.relatedCompAnswer);
          this.relatedCompAnswer.forEach((item: any) => {
            this.relatedCompAnsResult(item.answer_complain);
          });
        }
      },
      (error) => {
        console.error('Error fetching related complain answers', error);
      }
    );
  }

  relatedCompAnsResult(ans: string) {
    this.botAnswer = ans;
    this.messages.push({
      text: `${this.botAnswer}`,
      sender: `bot`
    });
  }



  // fetchRelatedComplainAnswer() {
  //   console.log(this.currentComplainStep);
  //   const relatedCompId = parseInt(this.selectedReletedComplainType, 10);
  //   this.http.get(`http://localhost:3000/relatedAnswer?relatedCompId=${relatedCompId}`).subscribe(
  //     (response: any) => {
  //       if(response.status) {
  //         this.relatedCompAnswer = response.data;
  //         console.log(this.relatedCompAnswer);
  //         this.relatedCompAnswer.forEach((item: any) => {
  //           this.relatedCompAnsResult(item.answer_complain);
  //         });
  //       }
  //     });
  // }

  // typeRelatedComplainAnsSelected(id: string) {
  //   this.selectedType = id;
  //   console.log(this.selectedType);
  //   const selectType = this.relatedCompAnswer.find((rtoc) => rtoc.id === id);
  //   this.type_complain = selectType ? selectType.answer_complain : '';
  //   this.messages.push({
  //     text: `My option is: ${this.type_complain}`,
  //     sender: `user`
  //   });
  //   this.complainStep();
  // }

  // relatedCompAnsResult(ans: string) {
  //   this.botAnswer = ans;
  //   this.messages.push({
  //     text: `${this.botAnswer}`,
  //     sender: `bot`
  //   });
  // }

  //Fetch type of inuiry a user can select from
  fetchInquiry() {
    this.http.get('http://localhost:3000/inquiryType').subscribe(
      (response: any) => {
        this.typeOfInquiry = response.data;
      }
    )
  }


  // Fetch answer of the selected type of complain
  fetchInquiryAnswer() {
    const id = parseInt(this.selectedInquiryType, 10);
    this.http.get(`http://localhost:3000/inquiryAnswer?answer=${id}`).subscribe(
      (response: any) => {
        if (response.status) {
          this.answer = response.data;
          this.answer.forEach((item: any) => {
            this.ansResult(item.answer);
          });
        } else {
          console.log('No answer found for the given complaint type.');
        }
      },
      (error) => {
        console.error('Error fetching answer:', error);
      }
    );
  }

  //Get selected type of complain
  typeInquirySelected(id: string) {
    this.selectedInquiryType = id;
    const selectedType = this.typeOfInquiry.find((toc) => toc.id === id);
    this.type_inquiry = selectedType ? selectedType.inquiry : '';
    this.messages.push({
      text: `My option is: ${this.type_inquiry}`,
      sender: 'user'
    });
    this.complainStep();
  }


  //Fetch type of complain a user can select from
  fetchComplain() {
    this.http.get('http://localhost:3000/complainType').subscribe(
      (response: any) => {
        this.typeOfComplain = response.data;
      }
    )
  }

  //Get selected type of complain
  typeSelected(id: string) {
    this.selectedType = id;
    const selectedType = this.typeOfComplain.find((toc) => toc.id === id);
    this.type_complain = selectedType ? selectedType.type : '';
    console.log(this.currentComplainStep);
    this.messages.push({
      text: `My option is: ${this.type_complain}`,
      sender: 'user'
    });
    this.complainStep();
  }

  // Fetch answer of the selected type of complain
  fetchAnswer() {
    const id = parseInt(this.selectedType, 10);
    this.http.get(`http://localhost:3000/answer?answer=${id}`).subscribe(
      (response: any) => {
        if (response.status) {
          this.answer = response.data;
          this.answer.forEach((item: any) => {
            this.ansResult(item.answer);
          });
        } else {
          console.log('No answer found for the given complaint type.');
        }
      },
      (error) => {
        console.error('Error fetching answer:', error);
      }
    );
  }

  ansResult(ans: string) {
    this.botAnswer = ans;
    this.messages.push({
      text: `${this.botAnswer}`,
      sender: 'bot'
    });
  }



  bookRoom() {
    const now = new Date();
    if (this.canBook(now)) {
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
                      this.updateTokenTracking(now); // Update token tracking
                      this.resetChat(); // Optionally reset chat after successful booking
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
    } else {
      this.messages.push({
        text: 'You have exceeded the booking limits. Please wait before trying again.',
        sender: 'bot',
      });
    }
  }

  canBook(now: Date): boolean {
    if (!this.lastBookingTime) {
      return true;
    }
    // ##########################################################################
    const timeDiff = (now.getTime() - this.lastBookingTime.getTime()) / 1000; // Time difference in seconds
    if (timeDiff > 60) { // Reset the token count after a minute
      this.bookingTokens = 0;
    }
    // set booking limit through token
    if (this.bookingTokens >= 2) { // Assuming the limit is 10 bookings in an hour
      return false;
    }
    return true;
  }

  updateTokenTracking(now: Date): void {
    this.bookingTokens++;
    this.lastBookingTime = now;
  }

  startCountdown(duration: number) {
    this.countdownActive = true;
    setTimeout(() => {
      this.resetChat();
    }, duration);
  }

  submitComplaint() {
    if (this.inquiryText) {
      this.http.post('http://localhost:3000/inquiry', {
        fullname: this.fullname,
        phone: this.phone,
        customDesc: this.inquiryText,
        inquiryId: this.selectedInquiryType
        })
        .subscribe(
          (response: any) => {
            if (response.status) {
              this.messages.push({
                text: 'Your inquiry have been submitted successfully.',
                sender: 'bot',
              });
              this.complaint = ''; // Clear the complaint field
            } else {
              this.messages.push({
                text: 'Failed to submit your inquiry. Please try again later.',
                sender: 'bot',
              });
            }
          },
          (error) => {
            this.messages.push({
              text: 'An error occurred while submitting your inquiry. Please try again later.',
              sender: 'bot',
            });
          }
        );
    } else {
      this.messages.push({
        text: 'Please enter your custom inquiry before submitting.',
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
