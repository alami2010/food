/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { NavigationExtras, Router } from '@angular/router';
import * as moment from 'moment';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-orders',
  templateUrl: './orders.component.html',
  styleUrls: ['./orders.component.scss']
})
export class OrdersComponent implements OnInit {
  list: any[] = [];
  page: any = 1;
  dummy: any[] = [];
  constructor(
    public util: UtilService,
    public api: ApiService,
    private router: Router
  ) {
    this.dummy = Array(10);
    this.getList();
  }

  getList() {

    this.api.post_private('v1/orders/getByStore', { id: localStorage.getItem('uid') }).then((data: any) => {
      console.log(data);
      this.dummy = [];
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        this.list = data.data;
        this.list.forEach((element) => {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(element.items)) {
            element.items = JSON.parse(element.items);
          }
        })
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

  viewsInfo(id: any) {
    console.log(id);
    const param: NavigationExtras = {
      queryParams: {
        id: id
      }
    };
    this.router.navigate(['order-history'], param);
  }

  getStatus(num: any) {
    const orderStatus = [
      this.util.translate('Created'), // 0
      this.util.translate('Accepted'), // 1
      this.util.translate('Prepared'), // 2
      this.util.translate('Ongoing'), // 3
      this.util.translate('Delivered'), // 4
      this.util.translate('Cancelled'), // 5
      this.util.translate('Rejected'), // 6
      this.util.translate('Refunded'), // 7
      this.util.translate('Pending Payments'), // 8
    ];
    return orderStatus[num];
  }
}
