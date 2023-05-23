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

@Component({
  selector: 'app-stats',
  templateUrl: './stats.component.html',
  styleUrls: ['./stats.component.scss']
})
export class StatsComponent implements OnInit {
  stores: any[] = [];
  storeId: any;
  storecommission: any;
  from: any;
  to: any;
  allOrders: any[] = [];
  storeOrder: any[] = [];
  totalAmount: any = 0;
  commisionAmount: any = 0;
  toPay: any = 0;
  apiCalled: boolean;
  storename: any;

  totalAmountsFromOrder: any = 0;
  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.storeId = parseInt(localStorage.getItem('uid') || '0');
  }

  ngOnInit(): void {
  }

  getStats() {
    console.log('from', this.from);
    console.log('to', this.to);
    if (this.from && this.to) {

      console.log('ok');
      const param = {
        id: localStorage.getItem('uid'),
        from: moment(this.from, 'YYYY-MM-DD HH:mm A').utc(false).format('YYYY-MM-DD HH:mm'),
        to: moment(this.to, 'YYYY-MM-DD HH:mm A').utc(false).format('YYYY-MM-DD HH:mm'),
      };
      console.log(param);
      this.util.show();
      this.apiCalled = false;
      this.storeOrder = [];
      this.api.post_private('v1/orders/getStoreStatsDataWithDates', param).then((data: any) => {
        this.apiCalled = true;
        this.util.hide();
        console.log(data);
        if (data && data.status == 200 && data.data.length) {
          this.storecommission = data.commission.rate;
          console.log('commustion', this.storecommission);
          let price = 0;

          data.data.forEach(async (element: any) => {
            if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(element.items)) {
              element.items = JSON.parse(element.items);


              const status = element.status;

              if (status == 4) {
                element.items.forEach((order: any) => {

                  if (order && order.discount == 0) {
                    if (order.size == 1) {
                      if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                        order.savedVariationsList.forEach((variants: any) => {
                          price = price + (parseFloat(variants.price) * variants.quantity);
                        });
                      }

                    } else {
                      price = price + (parseFloat(order.price) * order.quantity);
                    }
                  } else {
                    if (order.size == 1) {
                      if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                        order.savedVariationsList.forEach((variants: any) => {
                          price = price + (parseFloat(variants.price) * variants.quantity);
                        });
                      }
                    } else {
                      price = price + (parseFloat(order.discount) * order.quantity);
                    }
                  }
                  this.storeOrder.push(element);
                });
              }

            }
          });

          setTimeout(() => {
            function percentage(num: any, per: any) {
              return (num / 100) * per;
            }
            console.log(this.storeOrder);
            console.log(price, this.storecommission);
            const totalPrice = percentage(price, parseFloat(this.storecommission));
            console.log('commistion====>>>>>', totalPrice.toFixed(2));
            this.commisionAmount = totalPrice.toFixed(2);
            this.totalAmount = price;
            this.toPay = this.commisionAmount;
          }, 1000);

        }
      }, error => {
        this.util.hide();
        console.log(error);
        this.apiCalled = true;
        this.util.error(this.util.translate('Something went wrong'));
      }).catch((error) => {
        this.util.hide();
        console.log(error);
        this.apiCalled = true;
        this.util.error(this.util.translate('Something went wrong'));
      });
    } else {
      console.log('not valid');
      this.util.error(this.util.translate('All Fields are required'));
      return false;
    }
  }

  getCommisions(total: any) {
    return ((parseFloat(total) * this.storecommission) / 100).toFixed(2);
  }

  donwloadPDF() {

  }
  today() {
    return moment().format('ll');
  }
  getDate(date: any) {
    return moment(date).format('ll');
  }
  getName() {
    return 'name';
    // return this.storeOrder[0].name + '_' + moment(this.from).format('DDMMYYYY') + '_' + moment(this.to).format('DDMMYYYY');
  }

}
