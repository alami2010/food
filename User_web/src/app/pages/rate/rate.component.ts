/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ModalDirective } from 'angular-bootstrap-md';
import * as moment from 'moment';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-rate',
  templateUrl: './rate.component.html',
  styleUrls: ['./rate.component.scss']
})
export class RateComponent implements OnInit {
  @ViewChild('productRating') public productRating: ModalDirective;
  @ViewChild('storeRating') public storeRating: ModalDirective;
  @ViewChild('driverRating') public driverRating: ModalDirective;
  orderId: any;
  apiCalled: boolean = false;

  products: any;

  product_id: any;
  product_name: any;
  product_rate: any = 2;
  product_comment: any = '';
  product_total: any;
  product_rating: any[] = [];
  product_way: any;

  store_id: any;
  store_name: any;
  store_rate: any = 2;
  store_comment: any = '';
  store_total: any;
  store_rating: any[] = [];
  store_way: any;

  driver_id: any;
  driver_name: any;
  driver_email: any;
  driver_cover: any = '';
  driver_mobile: any = '';
  driver_rate: any = 2;
  driver_comment: any = '';
  driver_total: any;
  driver_rating: any[] = [];
  driver_way: any;
  deliverTo: any = 0;
  constructor(
    public util: UtilService,
    public api: ApiService,
    private navParam: ActivatedRoute,
  ) {
    this.navParam.queryParams.subscribe((data: any) => {
      if (data && data.id && data.id != '') {
        this.orderId = data.id;
        this.getOrderDetail();
      }
    });
  }

  ngOnInit(): void {
  }

  getOrderDetail() {
    this.api.post_private('v1/orders/getByOrderId', { id: this.orderId }).then((data: any) => {
      this.apiCalled = true;
      console.log(data, 'data',);
      if (data && data.status == 200) {

        this.store_name = data.storeInfo.name;
        this.store_id = data.storeInfo.uid;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(data.data.items)) {
          this.products = JSON.parse(data.data.items);
          console.log(this.products);
        } else {
          this.products = [];
        }

        if (data.data.order_to == 0) {
          this.driver_id = data.data.driver_id;
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(data.data.address)) {
            var address = JSON.parse(data.data.address);
            console.log(address);
            this.driver_name = data.driverInfo.first_name + ' ' + data.driverInfo.last_name;
            this.driver_cover = data.driverInfo.cover;
            this.driver_email = data.driverInfo.email;
            this.driver_mobile = data.driverInfo.mobile;
            this.driver_id = data.driverInfo.id;
          }
        }

        this.deliverTo = data.data.order_to;
      }
    }, error => {
      this.apiCalled = true;
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.apiCalled = true;
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  openProduct(item: any) {
    console.log(item);
    this.product_id = item.id;
    this.product_name = item.name;
    this.util.start();
    this.api.post_private('v1/ratings/getByProductId', { id: this.product_id }).then((data: any) => {
      console.log(data);
      this.util.stop();
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        data.data.forEach(element => {
          this.product_rating.push(parseInt(element.rate));
        });
        console.log(this.product_rating);
      }
      this.productRating.show();
    }, error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  openStore() {
    console.log(this.store_id);
    this.util.start();
    this.api.post_private('v1/ratings/getByStoreId', { id: this.store_id }).then((data: any) => {
      console.log(data);
      this.util.stop();
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        data.data.forEach(element => {
          this.store_rating.push(parseInt(element.rate));
        });
        console.log(this.store_rating);
      }
      this.storeRating.show();
    }, error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  openDriver() {
    this.util.start();
    this.api.post_private('v1/ratings/getByDriverId', { id: this.driver_id }).then((data: any) => {
      console.log(data);
      this.util.stop();
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        data.data.forEach(element => {
          this.driver_rating.push(parseInt(element.rate));
        });
        console.log(this.driver_rating);
      }
      this.driverRating.show();
    }, error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  submitProductRating() {

    if (this.product_comment == '') {
      this.util.errorMessage('Comment are missings');
      return false;
    }
    this.product_rating.push(this.product_rate);
    const sum = this.product_rating.reduce((a, b) => a + b);
    const average = (sum / this.product_rating.length).toFixed(2);
    console.log(sum, average);
    const param = {
      'uid': localStorage.getItem('uid'),
      'product_id': this.product_id,
      'driver_id': 0,
      'store_id': 0,
      'rate': this.product_rate,
      'msg': this.product_comment,
      'from': 1, // order = 1 // direct = 0
      'status': 1,
      'timestamp': moment().format('YYYY-MM-DD'),
      'total_ratings': this.product_rating.length,
      'rating': average
    };
    this.util.start();
    this.api.post_private('v1/ratings/saveProductRatings', param).then((data: any) => {
      this.util.stop();
      console.log(data);
      this.product_rate = 0;
      this.product_comment = '';
      this.productRating.hide();
      this.util.suucessMessage('Rating added');
    }, error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  addStoreRating() {
    if (this.store_comment == '') {
      this.util.errorMessage('Comment are missings');
      return false;
    }
    this.store_rating.push(this.store_rate);
    const sum = this.store_rating.reduce((a, b) => a + b);
    const average = (sum / this.store_rating.length).toFixed(2);
    console.log(sum, average);
    var param = {
      'uid': localStorage.getItem('uid'),
      'product_id': 0,
      'driver_id': 0,
      'store_id': this.store_id,
      'rate': this.store_rate,
      'msg': this.store_comment,
      'from': 1, // order = 1 // direct = 0
      'status': 1,
      'timestamp': moment().format('YYYY-MM-DD'),
      'total_ratings': this.store_rating.length,
      'ratings': average
    };
    this.util.start();
    this.api.post_private('v1/ratings/saveStoreRatings', param).then((data: any) => {
      this.util.stop();
      console.log(data);
      this.store_rate = 0;
      this.store_comment = '';
      this.storeRating.hide();
      this.util.suucessMessage('Rating added');
    }, error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  addDriverRating() {
    if (this.driver_comment == '') {
      this.util.errorMessage('Comment are missings');
      return false;
    }
    this.driver_rating.push(this.driver_rate);
    const sum = this.driver_rating.reduce((a, b) => a + b);
    const average = (sum / this.driver_rating.length).toFixed(2);
    console.log(sum, average);
    var param = {
      'uid': localStorage.getItem('uid'),
      'product_id': 0,
      'driver_id': this.driver_id,
      'store_id': 0,
      'rate': this.driver_rate,
      'msg': this.driver_comment,
      'from': 1, // order = 1 // direct = 0
      'status': 1,
      'timestamp': moment().format('YYYY-MM-DD'),
    };
    this.util.start();
    this.api.post_private('v1/ratings/saveDriversRatings', param).then((data: any) => {
      this.util.stop();
      console.log(data);
      this.driver_rate = 0;
      this.driver_comment = '';
      this.driverRating.hide();
      this.util.suucessMessage('Rating added');
    }, error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }
}
