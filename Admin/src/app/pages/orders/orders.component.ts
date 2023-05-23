/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { NavigationExtras, Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';
import * as moment from 'moment';

@Component({
  selector: 'app-orders',
  templateUrl: './orders.component.html',
  styleUrls: ['./orders.component.scss']
})
export class OrdersComponent implements OnInit {
  dummy = Array(10);
  dummyOrders: any[] = [];
  orders: any[] = [];
  page: number = 1;
  constructor(
    public util: UtilService,
    public api: ApiService,
    private router: Router
  ) {
    this.getOrders();
  }

  ngOnInit(): void {
  }

  getOrders() {
    this.api.get_private('v1/orders/getAll').then((data: any) => {
      this.dummy = [];
      if (data && data.status && data.status == 200 && data.success) {
        console.log(">>>>>", data);
        if (data && data.data.length > 0) {
          this.orders = data.data;
          this.dummyOrders = data.data;
          console.log("======", this.orders);
        }
      }
    }, error => {
      this.dummy = [];
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.dummy = [];
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  getNames(storeInfo: any) {
    const names = storeInfo.map((x: any) => x.name);
    return names.join();
  }

  exportCSV() {

    let data: any = [];
    this.orders.forEach(element => {
      const info = {
        'id': this.util.replaceWithDot(element.id),
        'username': this.util.replaceWithDot(element.first_name) + ' ' + this.util.replaceWithDot(element.last_name),
        'store': this.util.replaceWithDot(this.getNames(element.storeInfo)),
        'date': this.util.replaceWithDot(element.date_time),
        'total': this.util.replaceWithDot(element.grand_total),
        'order_to': this.util.replaceWithDot(element.order_to),
        'store_id': this.util.replaceWithDot(element.store_id),
      }
      data.push(info);
    });
    const name = 'orders';
    this.util.downloadFile(data, name, ['id', 'username', 'store', 'date', 'total', 'order_to', 'store_id']);
  }

  search(str: any) {
    this.resetChanges();
    console.log('string', str);
    if (str != '') {
      this.orders = this.filterItems(str);
    }
  }


  protected resetChanges = () => {
    this.orders = this.dummyOrders;
  }

  filterItems(searchTerm: any) {
    return this.orders.filter(x => x.id == searchTerm);

  }

  setFilteredItems() {
    console.log('clear');
    this.orders = [];
    this.orders = this.dummyOrders;
  }

  viewsInfo(item: any) {
    const param: NavigationExtras = {
      queryParams: {
        id: item
      }
    }
    this.router.navigate(['order-details'], param);
  }

  getDate(date: any) {
    return moment(date).format('ll');
  }


}
