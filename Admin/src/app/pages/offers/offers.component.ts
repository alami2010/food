/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import * as moment from 'moment';
import { ModalDirective } from 'ngx-bootstrap/modal';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';
import Swal from 'sweetalert2';
import { IDropdownSettings } from 'ng-multiselect-dropdown';

@Component({
  selector: 'app-offers',
  templateUrl: './offers.component.html',
  styleUrls: ['./offers.component.scss']
})
export class OffersComponent implements OnInit {
  @ViewChild('myModal3') public myModal3: ModalDirective;
  @ViewChild('myModal2') public myModal2: ModalDirective;
  dummy: any[] = [];
  list: any[] = [];
  dummyList: any[] = [];
  page: number = 1;
  value: any = '';

  name: any = '';
  off: any = '';
  type: any = '';
  date_time: any = '';
  descriptions: any = '';
  upto: any = '';
  status: any = 1;
  max_usage: any = '';
  min_cart_value: any = '';
  user_limit_validation: any = '';
  action: any = '';
  expire: any = '';

  offerId: any = '';

  stores: any[] = [];



  dropdownMultiSettings: IDropdownSettings = {
    singleSelection: false,
    idField: 'id',
    textField: 'name',
    selectAllText: 'Select All',
    unSelectAllText: 'UnSelect All',
    allowSearchFilter: true,
    itemsShowLimit: 3,
  };
  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.getList();
    this.getStores();
  }

  getStores() {
    this.api.get_private('v1/store/getStores').then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        this.stores = data.data;
      }
    }, error => {
      console.log(error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.apiErrorHandler(error);
    });
  }

  getList() {
    this.dummy = Array(5);
    this.list = [];
    this.dummyList = [];
    this.api.get_private('v1/offers/getAll').then((data: any) => {
      console.log(data);
      this.dummy = [];
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        this.list = data.data;
        this.dummyList = data.data;
        console.log(Object.keys(this.list[0]));
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

  getDate(item: any) {
    return moment(item).format('lll');
  }

  ngOnInit(): void {
  }


  changeStatus(item: any) {
    console.log(item);
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
        const body = {
          id: item.id,
          status: item.status == 0 ? 1 : 0
        };
        console.log("========", body);
        this.util.show();
        this.api.post_private('v1/offers/updateStatus', body).then((data: any) => {
          this.util.hide();
          console.log("+++++++++++++++", data);
          if (data && data.status && data.status == 200 && data.success) {
            this.util.success(this.util.translate('Status Updated !'));
            this.getList();
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
    //offers/updateStatus
  }


  addNew() {
    this.action = 'create';
    this.myModal2.show();
  }


  clearData() {
    this.name = '';
    this.off = '';
    this.min_cart_value = '';
    this.upto = '';
    this.type = '';
    this.descriptions = '';
    this.expire = '';
    this.action = 'create';
  }
  downloadSample() {
    window.open('assets/sample/offers.csv', '_blank');
  }

  saveChanges() {
    console.log(this.value);

    if (this.name == '' || this.name == null || this.off == '' || this.off == null || this.upto == '' || this.upto == null ||
      this.type == '' || this.type == null || this.descriptions == null || this.descriptions == '' || this.expire == '' || this.expire == null ||
      this.max_usage == '' || this.max_usage == null || this.min_cart_value == '' || this.min_cart_value == null || this.user_limit_validation == '' || this.user_limit_validation == null) {
      this.util.error(this.util.translate('All Fields are required'));
      return false;
    }

    if (this.value == '' || this.value == null || this.value.length <= 0) {
      this.util.error(this.util.translate('Please select Restaurants'));
      return false;
    }
    let values = '';
    const ids = this.value.map((x: any) => x.id);
    console.log('ids', ids);
    if (ids && ids.length) {
      values = ids.join();
    }
    const param = {
      name: this.name,
      store_ids: values,
      code: this.name,
      discount: this.off,
      max_usage: this.max_usage,
      min_cart_value: this.min_cart_value,
      validations: 1,
      user_limit_validation: this.user_limit_validation,
      type: this.type,
      expire: this.expire,
      manage: 0,
      short_descriptions: this.descriptions,
      status: 1,
      upto: this.upto
    };

    this.util.show();
    this.api.post_private('v1/offers/create', param).then((data: any) => {
      console.log("+++++++++++++++", data);
      this.util.hide();
      if (data && data.status && data.status == 200 && data.success) {
        this.clearData();
        this.myModal2.hide();
        this.util.success(this.util.translate('Added !'));
        this.getList();
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

  updateChanges() {
    console.log(this.name);
    console.log(this.off);
    console.log(this.upto);
    console.log(this.type);
    console.log(this.descriptions);
    console.log(this.expire);
    console.log(this.max_usage);
    console.log(this.min_cart_value);
    console.log(this.user_limit_validation);
    console.log(this.user_limit_validation);
    if (this.name == '' || this.name == null || this.off == '' || this.off == null || this.upto == '' || this.upto == null ||
      this.descriptions == null || this.descriptions == '' || this.expire == '' || this.expire == null ||
      this.max_usage == '' || this.max_usage == null || this.min_cart_value == '' || this.min_cart_value == null || this.user_limit_validation == '' || this.user_limit_validation == null) {
      this.util.error(this.util.translate('All Fields are required'));
      return false;
    }

    if (this.value == '' || this.value == null || this.value.length <= 0) {
      this.util.error(this.util.translate('Please select Restaurants'));
      return false;
    }
    let values = '';
    const ids = this.value.map((x: any) => x.id);
    console.log('ids', ids);
    if (ids && ids.length) {
      values = ids.join();
    }
    const param = {
      id: this.offerId,
      name: this.name,
      store_ids: values,
      code: this.name,
      discount: this.off,
      max_usage: this.max_usage,
      min_cart_value: this.min_cart_value,
      validations: 1,
      user_limit_validation: this.user_limit_validation,
      type: this.type,
      expire: this.expire,
      manage: 0,
      short_descriptions: this.descriptions,
      status: 1,
      upto: this.upto
    };

    this.util.show();
    this.api.post_private('v1/offers/update', param).then((data: any) => {
      console.log("+++++++++++++++", data);
      this.util.hide();
      if (data && data.status && data.status == 200 && data.success) {
        this.clearData();
        this.myModal2.hide();
        this.util.success(this.util.translate('Updated !'));
        this.getList();
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


  openOffers(item: any) {
    console.log(item);
    this.offerId = item;
    this.util.show();
    this.api.post_private('v1/offers/getById', { "id": this.offerId }).then((data: any) => {
      this.util.hide();
      console.log("+++++++++++++++", data);
      if (data && data.status && data.status == 200 && data.success) {
        this.action = 'edit';
        const info = data.data;
        this.name = info.name;
        this.off = info.discount;
        this.upto = info.upto;
        this.type = info.type;
        this.descriptions = info.short_descriptions;
        this.max_usage = info.max_usage;
        this.min_cart_value = info.min_cart_value;
        this.user_limit_validation = info.user_limit_validation;
        this.expire = moment(info.expire).format('dd/mm/yyyy');
        this.value = info.restaurants;
        this.myModal2.show();
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
}
