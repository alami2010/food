/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';
import { ModalDirective } from 'ngx-bootstrap/modal';
import { NavigationExtras, Router } from '@angular/router';
import Swal from 'sweetalert2';
import * as moment from 'moment';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  @ViewChild('myModal') public myModal: ModalDirective;

  dummy: any[] = [];
  dummyList: any[] = [];
  page: any = 1;
  recentOrders: any[] = [];
  recentUsers: any[] = [];
  complaints: any[] = [];

  users: any = 0;
  order: any = 0;
  stores: any = 0;
  products: any = 0;

  labelToday: any = '';
  labelWeekly: any = '';
  labelMonthly: any = '';

  lineChartLegend = true;
  lineChartPlugins = [];
  lineChartType = 'line';

  reasons: any[] = [
    this.util.translate('The product arrived too late'),
    this.util.translate('The product did not match the description'),
    this.util.translate('The purchase was fraudulent'),
    this.util.translate('The product was damaged or defective'),
    this.util.translate('The merchant shipped the wrong item'),
    this.util.translate('Wrong Item Size or Wrong Product Shipped'),
    this.util.translate('Driver arrived too late'),
    this.util.translate('Driver behavior'),
    this.util.translate('Store Vendors behavior'),
    this.util.translate('Issue with Payment Amout'),
    this.util.translate('Others'),
  ];

  issue_With: any[] = [
    '',
    this.util.translate('Order'),
    this.util.translate('Store'),
    this.util.translate('Driver'),
    this.util.translate('Product')
  ];

  name: any = '';
  email: any = '';
  message: any = '';

  reply: any = '';
  id: any = '';


  chartBarData = {
    labels: ['Sells'],
    datasets: [
      {
        label: 'Sells',
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };

  chartBarData2 = {
    labels: ['Sells'],
    datasets: [
      {
        label: 'Sells',
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };

  chartBarData3 = {
    labels: ['Sells'],
    datasets: [
      {
        label: 'Sells',
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };
  constructor(
    public api: ApiService,
    public util: UtilService,
    private router: Router
  ) {
    this.getHome();
  }


  ngOnInit() {

  }

  openPage(url: any) {
    this.router.navigate([url]);
  }

  getHome() {
    this.dummy = Array(5);
    this.api.get_private('v1/home/getAdminDashboard').then((data: any) => {
      console.log(data);
      this.dummy = [];
      if (data && data.status && data.status == 200) {
        this.users = data.data.users;
        this.order = data.data.orders;
        this.stores = data.data.stores;
        this.products = data.data.products;

        console.log(data.data.today);
        if (data && data.data && data.data.today && data.data.today.label) {
          data.data.today.label.forEach((element: any) => {
            this.chartBarData.labels.push(element);
          });
          data.data.today.data.forEach((element: any) => {
            this.chartBarData.datasets[0].data.push(element);
          });
        }
        this.labelToday = data.data.todayLabel;

        console.log(data.data.week);
        if (data && data.data && data.data.week && data.data.week.label) {
          data.data.week.label.forEach((element: any) => {
            this.chartBarData2.labels.push(element);
          });
          data.data.week.data.forEach((element: any) => {
            this.chartBarData2.datasets[0].data.push(element);
          });
        }
        this.labelWeekly = data.data.weekLabel;

        console.log(data.data.month);
        if (data && data.data && data.data.month && data.data.month.label) {
          data.data.month.label.forEach((element: any) => {
            this.chartBarData3.labels.push(element);
          });
          data.data.month.data.forEach((element: any) => {
            this.chartBarData3.datasets[0].data.push(element);
          });
        }
        this.labelMonthly = data.data.monthLabel;

        console.log(this);

        this.recentUsers = data.data.recentUsers;
        this.recentOrders = data.data.recentOrders;

        this.complaints = data.data.complaints;
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

  statusUpdate(item: any) {
    console.log(item);
    const text = item.status == 1 ? 'Deactive' : 'Active';
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To ') + text + this.util.translate(' this user!'),
      icon: 'question',
      showConfirmButton: true,
      confirmButtonText: this.util.translate('Yes'),
      showCancelButton: true,
      cancelButtonText: this.util.translate('Cancel'),
      backdrop: false,
      background: 'white'
    }).then((data) => {
      if (data && data.value) {
        console.log('update it');
        const query = item.status == 1 ? 0 : 1;
        item.status = query;
        this.util.success('Updated');
        this.util.show();
        this.api.post_private('v1/profile/update', item).then((datas) => {
          this.util.hide();
          this.util.success('Updated');
        }, error => {
          this.util.hide();
          console.log('Error', error);
          this.util.apiErrorHandler(error);
        }).catch(error => {
          this.util.hide();
          console.log('Err', error);
          this.util.apiErrorHandler(error);
        });
      }
    });
  }

  viewsInfo(item: any) {
    console.log(item);
    const param: NavigationExtras = {
      queryParams: {
        id: item
      }
    };
    this.router.navigate(['manage-users'], param);
  }

  deleteItem(item: any) {
    console.log(item);
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To Delete this user!'),
      icon: 'question',
      showConfirmButton: true,
      confirmButtonText: this.util.translate('Yes'),
      showCancelButton: true,
      cancelButtonText: this.util.translate('Cancel'),
      backdrop: false,
      background: 'white'
    }).then((data) => {
      if (data && data.value) {
        console.log('update it');
        this.util.success('Deleted');
        this.util.show();
        this.api.post_private('v1/users/deleteUser', item).then((datas) => {
          this.util.hide();
          this.util.success('Deleted');
          this.recentUsers = this.recentUsers.filter(x => x.id != item.id);
        }, error => {
          this.util.hide();
          console.log('Error', error);
          this.util.apiErrorHandler(error);
        }).catch(error => {
          this.util.hide();
          console.log('Err', error);
          this.util.apiErrorHandler(error);
        });
      }
    });
  }

  viewOrderInfo(item: any) {
    console.log(item);
    const param: NavigationExtras = {
      queryParams: {
        id: item
      }
    }
    this.router.navigate(['order-details'], param);
  }

  statusUpdateComplaints(item: any) {
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To update this item?'),
      icon: 'question',
      showConfirmButton: true,
      confirmButtonText: this.util.translate('Yes'),
      showCancelButton: true,
      cancelButtonText: this.util.translate('Cancel'),
      backdrop: false,
      background: 'white'
    }).then((data) => {
      if (data && data.value) {
        console.log('update it');
        item.status = item.status == 0 ? 1 : 0
        const body = {
          id: item.id,
          status: item.status
        };
        console.log("========", body);
        this.util.show();
        this.api.post_private('v1/complaints/update', body).then((data: any) => {
          this.util.hide();
          console.log("+++++++++++++++", data);
          if (data && data.status && data.status == 200 && data.success) {
            this.util.success(this.util.translate('Status Updated !'));
          }
        }, error => {
          this.util.hide();
          console.log('Error', error);
          this.util.apiErrorHandler(error);
        }).catch(error => {
          this.util.hide();
          console.log('Err', error);
          this.util.apiErrorHandler(error);
        });
      }
    });
  }

  openItem(item: any) {
    console.log(item);
    this.name = item.userInfo.first_name + ' ' + item.userInfo.last_name;
    this.email = item.userInfo.email;
    this.message = item.short_message;
    this.id = item.id;
    this.myModal.show();
  }

  sendMail() {
    if (this.reply == '' || !this.reply) {
      this.util.error(this.util.translate('Please add your reply text'));
      return false;
    }
    const param = {
      id: this.id,
      mediaURL: this.api.imageUrl,
      subject: this.util.appName + ' ' + this.util.translate('Replied on your complaints'),
      thank_you_text: this.util.translate('You have received new mail on your complaints'),
      header_text: this.util.appName + ' ' + this.util.translate('Replied on your complaints'),
      email: this.email,
      from_username: this.name,
      to_respond: this.reply
    };
    this.util.show();
    console.log(param);
    this.api.post_private('v1/complaints/replyContactForm', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      this.reply = '';
      this.myModal.hide();
      this.util.success(this.util.translate('Mail sent'));
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

  getDate(date: any) {
    return moment(date).format('ll');
  }

}
