/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Location } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import * as moment from 'moment';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-order-history',
  templateUrl: './order-history.component.html',
  styleUrls: ['./order-history.component.scss']
})
export class OrderHistoryComponent implements OnInit {

  // @ViewChild('myModal') public myModal: ModalDirective;
  id: any;
  loaded: boolean = false;
  orderDetail: any[] = [];
  orders: any[] = [];
  payMethod: any;
  status: any;
  datetime: any;
  orderAt: any;
  address: any;
  userInfo: any;
  driverInfo: any;
  changeStatusOrder: any;
  drivers: any[] = [];
  dummyDrivers: any[] = [];
  userLat: any;
  userLng: any;
  driverId: any;
  assignee: any[] = [];
  assigneeDriver: any = [];

  orderStatus: any[] = [];
  statusText: any = '';
  grandTotal: any;
  tax: any;

  // deliveryCharge: any = 0;
  orderTax: any = 0;

  orderTotal: any = 0;
  orderDiscount: any = 0;
  orderDeliveryCharge: any = 0;
  orderWalletDiscount: any = 0;
  orderTaxCharge: any = 0;
  orderGrandTotal: any = 0;

  selected_driver: any = '';
  public visible = false;
  constructor(
    public util: UtilService,
    public api: ApiService,
    public route: ActivatedRoute,
    private navCtrl: Location
  ) {
    this.route.queryParams.subscribe((data: any) => {
      console.log(data);
      if (data && data.id) {
        this.id = data.id;

        this.api.post_private('v1/orders/getOrderByIdForStore', { id: this.id }).then((data: any) => {
          console.log(data);
          this.loaded = true;
          if (data && data.status && data.status == 200 && data.data) {
            const info = data.data;
            console.log(info);
            if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.items)) {
              this.orders = JSON.parse(info.items);
            }
            console.log('orde->>>', this.orders);
            let total = info.total;
            console.log('==>', total);
            this.orderTotal = total;
            this.grandTotal = total.toFixed(2);
            this.datetime = moment(info.created_at).format('dddd, MMMM Do YYYY');
            this.payMethod = info.paid_method == 'cod' ? 'COD' : 'PAID';
            this.orderAt = info.order_to;
            this.tax = info.tax;
            this.driverId = info.driver_id;
            if (info.discount > 0) {
              this.orderDiscount = (info.discount).toFixed(2);
            }
            if (info.wallet_used == 1) {
              this.orderWalletDiscount = (info.wallet_price).toFixed(2);
            }
            console.log('wallet discount', this.orderWalletDiscount);

            this.userInfo = data.userInfo;

            if (this.orderAt == 0) {
              const address = JSON.parse(info.address);
              console.log('---address', address);
              if (address && address.address) {
                this.userLat = address.lat;
                this.userLng = address.lng;
                this.address = address.landmark + ' ' + address.house + ' ' + address.address + ' ' + address.pincode;
                this.getDrivers();

              }
              console.log('----', this.assignee);
              console.log('----', this.assigneeDriver);
            }
            this.status = info.status;
            this.orderDeliveryCharge = info.delivery_charge;
            this.orderGrandTotal = info.grand_total;
            this.orderTax = info.serviceTax;
            this.orderTaxCharge = info.serviceTax;
            this.grandTotal = info.grand_total;
            console.log('order total', this.orderTotal);
            console.log('order discount', this.orderDiscount);
            console.log('order delivery charge', this.orderDeliveryCharge);
            console.log('order wallet', this.orderWalletDiscount);
            console.log('order tax', this.orderTaxCharge);
            console.log('order grandtotoal', this.orderGrandTotal);
            console.log('status', this.status);
          } else {
            this.util.apiErrorHandler(data);
          }
        }, error => {
          console.log(error);
          this.loaded = true;
          this.util.apiErrorHandler(error);
        }).catch(error => {
          console.log(error);
          this.loaded = true;
          this.util.apiErrorHandler(error);
        });
      }
    });
  }

  toggleLiveDemo() {
    this.visible = !this.visible;
  }

  handleLiveDemoChange(event: any) {
    this.visible = event;
  }

  degreesToRadians(degrees: any) {
    return degrees * Math.PI / 180;
  }

  distanceInKmBetweenEarthCoordinates(lat1: any, lon1: any, lat2: any, lon2: any) {
    console.log(lat1, lon1, lat2, lon2);
    const earthRadiusKm = 6371;
    const dLat = this.degreesToRadians(lat2 - lat1);
    const dLon = this.degreesToRadians(lon2 - lon1);
    lat1 = this.degreesToRadians(lat1);
    lat2 = this.degreesToRadians(lat2);
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  getDrivers() {
    const param = {
      lat: localStorage.getItem('lat'),
      lng: localStorage.getItem('lng')
    };
    this.api.post_private('v1/drivers/getDriversNearStore', param).then((data: any) => {
      console.log('drivers', data);
      if (data && data.status == 200 && data.data && data.data.length) {
        const info = data.data;
        info.forEach(async (element: any) => {
          const distance = await this.distanceInKmBetweenEarthCoordinates(
            this.userLat,
            this.userLng,
            parseFloat(element.lat),
            parseFloat(element.lng));

          element['distanceFrom'] = distance.toFixed(2);
          this.dummyDrivers.push(element);

        });
        console.log('distace', this.dummyDrivers);;
        this.dummyDrivers = this.dummyDrivers.sort((a, b) => a.distanceFrom - b.distanceFrom);
      }
    }, error => {
      console.log(error);
      this.util.apiErrorHandler(error);
    }).catch((error: any) => {
      console.log(error);
      this.util.apiErrorHandler(error);
    });
  }

  printOrder() {
    window.open(this.api.baseUrl + 'v1/orders/printInvoice?id=' + this.id + '&token=' + localStorage.getItem('token'), '_system');
  }

  ngOnInit(): void {
  }

  saveDriver() {
    console.log(this.selected_driver);
    if (this.selected_driver == '' || this.selected_driver == 0) {
      this.util.error('Please select driver');
      return false;
    }
    this.assignOrderToDriver(this.selected_driver);
  }


  call() {
    if (this.userInfo.mobile) {
      window.open('tel:' + this.userInfo.mobile, '_system')

    } else {
      this.util.error(this.util.translate('Number not found'));
    }
  }

  email() {
    if (this.userInfo.email) {
      window.open('mailto:' + this.userInfo.email, '_system')
    } else {
      this.util.error(this.util.translate('Email not found'));
    }
  }

  changeStatus(status: any) {
    console.log(status);
    if (this.orderAt == 1) {
      console.log('self pickup');
      this.changeOrderStatus(1);
    } else if (this.orderAt == 0 && status == 'rejected') {
      console.log('home delivery and reject');
      this.changeOrderStatus(6);
    } else if (this.orderAt == 0 && status == 'accepted') {
      console.log('accept order and home delivery');
      if (this.util.driver_assign == 1) {
        console.log('auto assign');
        const id = this.dummyDrivers[0].id;
        this.assignOrderToDriver(id);
      } else {
        if (this.dummyDrivers.length > 0) {
          console.log('open drivers modal');
          this.presentModal();
        } else {
          console.log('no drivers');
          this.util.error('No Drivers Near you');
        }
      }
    }
  }

  selectDriver(item: any) {
    console.log(item);
    this.selected_driver = item.id;
  }

  async presentModal() {
    console.log('open modal');
    this.toggleLiveDemo();
  }

  assignOrderToDriver(driverId: any) {
    const param = { "id": this.id, "status": 1, "driver_id": driverId };
    this.util.show();
    this.api.post_private('v1/orders/updateFromStore', param).then((data: any) => {
      this.util.hide();
      console.log(data);
      this.util.success('Status Updated');
      this.navCtrl.back();
    }, error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    }).catch((error: any) => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
  }

  updateStatus() {
    if (this.changeStatusOrder == '' || !this.changeStatusOrder || this.changeStatusOrder == null) {
      this.util.error('Please select status');
      return false;
    }
    this.changeOrderStatus(this.changeStatusOrder);
  }

  changeOrderStatus(statusNumber: any) {
    const param = { "id": this.id, "status": statusNumber };
    this.util.show();
    this.api.post_private('v1/orders/updateFromStore', param).then((data: any) => {
      this.util.hide();
      console.log(data);
      this.util.success('Status Updated');
      this.navCtrl.back();
    }, error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    }).catch((error: any) => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
  }

}
