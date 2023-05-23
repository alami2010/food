/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import * as moment from 'moment';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';
import Swal from 'sweetalert2';
@Component({
  selector: 'app-bookings',
  templateUrl: './bookings.component.html',
  styleUrls: ['./bookings.component.scss']
})
export class BookingsComponent implements OnInit {
  list: any[] = [];
  page: any = 1;
  dummy: any[] = [];
  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.getList();
  }

  getList() {
    this.dummy = Array(5);
    this.api.post_private('v1/table_booking/getBookingsByStore', { id: localStorage.getItem('uid') }).then((data: any) => {
      console.log(data);
      this.dummy = [];
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        this.list = data.data;
      }
    }, error => {
      console.log(error);
      this.dummy = [];
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.dummy = [];
      this.util.apiErrorHandler(error);
    });
  }
  ngOnInit(): void {
  }

  getDate(date: any) {
    return moment(date).format('ll');
  }

  statusUpdate(num: any, id: any) {
    Swal.fire({
      title: this.util.translate('Confirm!'),
      text: this.util.translate("to update this status"),
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes'
    }).then((result) => {
      if (result.isConfirmed) {
        this.util.show();
        this.api.post_private('v1/table_booking/updateBookingInfo', { status: num, id: id }).then((data: any) => {
          console.log(data);
          this.util.hide();
          Swal.fire(
            'Updated!',
            'Booking has been updated.',
            'success'
          );
          this.getList();
        }, error => {
          console.log(error);
          this.util.hide();
          this.util.apiErrorHandler(error);
        }).catch(error => {
          console.log(error);
          this.util.hide();
          this.util.apiErrorHandler(error);
        });

      }
    });

  }

}
