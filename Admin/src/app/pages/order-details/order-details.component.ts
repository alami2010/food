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
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';

@Component({
  selector: 'app-order-details',
  templateUrl: './order-details.component.html',
  styleUrls: ['./order-details.component.scss']
})
export class OrderDetailsComponent implements OnInit {
  id: any;
  loaded: boolean;
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

  orderStatus: any = '';
  statusText: any = '';
  grandTotal: any;
  tax: any;

  // deliveryCharge: any = 0;
  orderTax: any = 0;

  totalStores: any = 0;
  orderTotal: any = 0;
  orderDiscount: any = 0;
  orderDeliveryCharge: any = 0;
  orderWalletDiscount: any = 0;
  orderTaxCharge: any = 0;
  orderGrandTotal: any = 0;

  selected_driver: any = '';
  payName: any = '';

  paymentRef: any;
  orderStatusNames = [
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
  payment = [
    this.util.translate('NA'),
    this.util.translate('COD'),
    this.util.translate('Stripe'),
    this.util.translate('PayPal'),
    this.util.translate('Paytm'),
    this.util.translate('Razorpay'),
    this.util.translate('Instamojo'),
    this.util.translate('Paystack'),
    this.util.translate('Flutterwave')
  ];
  constructor(
    private route: ActivatedRoute,
    private navCtrl: Location,
    public util: UtilService,
    public api: ApiService,
  ) {
    this.route.queryParams.subscribe((data: any) => {
      console.log(data);
      if (data && data.id) {
        this.id = data.id;
        this.loaded = false;
        this.getOrder();
        this.statusText = this.util.translate(' by administrator');
      } else {
        this.navCtrl.back();
      }
    });
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

  getOrder() {
    const param = {
      id: this.id
    };
    this.api.post_private('v1/orders/getByIdAdmin', param).then((data: any) => {
      console.log(data);
      this.loaded = true;
      if (data && data.status && data.status == 200 && data.data) {
        const info = data.data;
        const order = JSON.parse(info.items);
        this.orders = order;
        console.log('orde->>>', this.orders);

        console.log('==>', info.total);
        this.orderTotal = info.total;
        this.grandTotal = info.total.toFixed(2);
        this.orderStatus = this.orderStatusNames[info.status];
        this.datetime = moment(info.created_at).format('dddd, MMMM Do YYYY');
        this.payMethod = info.pay_method == 0 ? 'COD' : 'PAID';
        this.payName = this.payment[info.pay_method];
        this.paymentRef = info.paid;
        this.orderAt = info.order_to == 0 ? 'Home' : 'Self Pickup';
        this.tax = info.serviceTax;
        this.driverId = info.driver_id;
        if (info.discount > 0) {
          this.orderDiscount = info.discount;
        }
        if (info.wallet_used == 1) {
          this.orderWalletDiscount = info.wallet_price;
        }
        console.log('wallet discount', this.orderWalletDiscount);

        this.userInfo = data.user;

        if (this.orderAt == 'Home') {
          const address = JSON.parse(info.address);
          console.log('---address', address);
          if (address && address.address) {
            this.userLat = address.lat;
            this.userLng = address.lng;
            this.address = address.landmark + ' ' + address.house + ' ' + address.address + ' ' + address.pincode;
          }

        }
        console.log('total stores', this.totalStores);
        console.log('order total', this.orderTotal);
        console.log('order discount', this.orderDiscount);
        console.log('order delivery charge', this.orderDeliveryCharge);
        console.log('order wallet', this.orderWalletDiscount);
        console.log('order tax', this.orderTaxCharge);
        console.log('order grandtotoal', this.orderGrandTotal);
        console.log('pay name', this.payName);
      } else {
        this.util.apiErrorHandler(data);
      }
    }, error => {
      console.log(error);
      this.loaded = true;
      this.util.apiErrorHandler(error);
    });
  }

  ngOnInit() {
  }

  back() {
    this.navCtrl.back();
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

  printOrder() {
    window.open(this.api.baseUrl + 'v1/orders/printInvoice?id=' + this.id + '&token=' + localStorage.getItem('token'), '_system');
  }

  selectDriver(item: any) {
    console.log(item);
    this.selected_driver = item.id;
  }



  getTotalBilling() {
    const total = parseFloat(this.orderTotal) + parseFloat(this.orderTaxCharge) + parseFloat(this.orderDeliveryCharge);
    const discount = parseFloat(this.orderDiscount) + parseFloat(this.orderWalletDiscount);
    return total - discount > 0 ? total - discount : 0;
  }

  sendNotification() {
    if (this.userInfo && this.userInfo.fcm_token) {
      const param = {
        title: this.util.translate('Order refunded'),
        message: this.util.translate('Your order is rejected by store your refund amount will be credited within 2-3 bussiness days'),
        id: this.userInfo.fcm_token
      };
      this.api.post_private('v1/notification/sendNotification', param).then((data: any) => {
        console.log(data);
      }, error => {
        console.log(error);
      }).catch(error => {
        console.log(error);
      });
    }
  }

  refundStripe() {
    console.log('refund stripe');
    console.log(this.paymentRef);
    const ref = JSON.parse(this.paymentRef);
    console.log('ref=>', ref);
    if (ref && ref.id) {
      const param = {
        charge_id: ref.id,
      };
      this.util.show();
      this.api.post_private('v1/payments/refundStripePayments', param).then((data: any) => {
        console.log(data);
        if (data && data.status && data.status == 200) {
          this.refundOrder();
        } else {
          this.util.hide();
          this.util.apiErrorHandler(data);
        }
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
  }

  refundPayPal() {
    console.log('refund paypal');
    console.log(this.paymentRef);
    const ref = JSON.parse(this.paymentRef);
    console.log('ref=>', ref);
    let id;
    if (ref && ref.key) {
      id = ref.key;
    } else if (ref && ref.intent && ref.intent == 'CAPTURE') {
      id = ref.purchase_units[0].payments.captures[0].id;
    }
    console.log('transactional id', id);

    const param = {
      ref: id,
      amount: this.grandTotal
    }
    console.log('param', param);
    this.util.show();
    this.api.post_private('v1/payments/payPalRefund', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.refundOrder();
      } else {
        this.util.hide();
        this.util.apiErrorHandler(data);
      }
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

  refundPayTM() {
    console.log('refund paytm');
    console.log(this.paymentRef);
    const ref = JSON.parse(this.paymentRef);
    console.log('ref=>', ref);
    let key;
    let txtId;
    if (ref && ref.key && ref.txtId) {
      key = ref.key;
      txtId = ref.txtId;
      const param = {
        id: key,
        txt_id: txtId,
        amount: this.grandTotal
      };
      this.util.show();
      this.api.post_private('v1/payments/paytmRefund', param).then((data: any) => {
        console.log(data);
        if (data && data.status && data.status == 200) {
          this.refundOrder();
        } else {
          this.util.hide();
          this.util.apiErrorHandler(data);
        }
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
  }

  refundRazorPay() {
    console.log('refund razorpay');
    console.log(this.paymentRef);
    const ref = JSON.parse(this.paymentRef);
    console.log('ref=>', ref);
    if (ref && ref.id) {
      const param = {
        id: ref.id
      }
      this.util.show();
      this.api.post_private('v1/payments/razorPayRefund', param).then((data: any) => {
        console.log(data);
        if (data && data.status && data.status == 200) {
          this.refundOrder();
        } else {
          this.util.hide();
          this.util.apiErrorHandler(data);
        }
      }, error => {
        console.log(error);
        this.util.hide();
        this.util.apiErrorHandler(error);
      }).catch(error => {
        console.log(error);
        this.util.hide();
        this.util.apiErrorHandler(error);
      });
      //
    }
  }

  refundInstaMOJO() {
    console.log('refund instamojo');
    console.log(this.paymentRef);

    let key;
    if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(this.paymentRef)) {
      const ref = JSON.parse(this.paymentRef);
      console.log('ref=>', ref);
      key = ref.payment_id;
    } else {
      key = this.paymentRef;
    }

    console.log('key', key);
    const param = {
      id: key
    }
    this.util.show();
    this.api.post_private('v1/payments/instaMOJORefund', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.refundOrder();
      } else {
        this.util.hide();
        this.util.apiErrorHandler(data);
      }
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

  refundPayStack() {
    console.log('refund paystack');
    const param = {
      id: this.paymentRef
    }
    this.util.show();
    this.api.post_private('v1/payments/refundPayStack', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.refundOrder();
      } else {
        this.util.hide();
        this.util.apiErrorHandler(data);
      }
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

  refundFlutterwave() {
    console.log('refund flutterwave');
    console.log(this.paymentRef);
    const ref = JSON.parse(this.paymentRef);
    console.log('ref=>', ref);
    let id;
    if (ref && ref.orderId) {
      id = ref.orderId;
    } else if (ref && ref.transaction_id) {
      id = ref.transaction_id;
    }
    console.log('transactional id', id);
    const param = {
      ref: id,
      amount: this.grandTotal
    }
    console.log('param', param);
    this.util.show();
    this.api.post_private('v1/payments/refundFlutterwave', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.refundOrder();
      } else {
        this.util.hide();
        this.util.apiErrorHandler(data);
      }
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

  refundPaykun() {
    console.log('refund paykun');
  }

  changeOrderStatus() {
    console.log(this.changeStatusOrder);
    console.log('stauts', this.orderStatus);
    console.log('paid with', this.payName);
    if (this.changeStatusOrder == 'refund') {
      console.log('refund with API');
      if (this.payName == 'Stripe') {
        this.refundStripe();
      } else if (this.payName == 'PayPal') {
        this.refundPayPal();
      } else if (this.payName == 'Paytm') {
        this.refundPayTM();
      } else if (this.payName == 'Razorpay') {
        this.refundRazorPay();
      } else if (this.payName == 'Instamojo') {
        this.refundInstaMOJO();
      } else if (this.payName == 'Paystack') {
        this.refundPayStack();
      } else if (this.payName == 'Flutterwave') {
        this.refundFlutterwave();
      } else if (this.payName == '9') {
        this.refundPaykun();
      }
    } else {
      console.log('refund with merchant');
      this.refundOrder();
    }

  }


  refundOrder() {
    this.util.show();
    const param = {
      id: this.id,
      status: 7,
    };
    this.api.post_private('v1/orders/updateStatusAdmin', param).then((data: any) => {
      console.log('order', data);
      this.util.hide();
      if (data && data.status == 200) {
        this.sendNotification();
        this.back();
      } else {
        this.util.apiErrorHandler(data);
      }
    }, error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
  }

}
