/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ApiService } from './../../services/api.service';
import { Component, OnInit } from '@angular/core';
import { UtilService } from '../../services/util.service';

@Component({
  selector: 'app-general',
  templateUrl: './general.component.html',
  styleUrls: ['./general.component.scss']
})
export class GeneralComponent implements OnInit {
  storeName: any = '';
  contact: any = '';
  email: any = '';
  address: any = '';
  city: any = '';
  state: any = '';
  zip: any = '';
  country: any = '';

  freeShipOnPrice: any = '';
  tax: any = '';
  shippingType = -1;
  shippingPrice: any = '';
  deliveryArea: any = '';
  id: any = '';
  generalInfo: any = '';

  isCreate: any = '';

  facebook_url: any = '';
  instagram: any = '';
  twitter: any = '';
  google_playstore: any = '';
  apple_appstore: any = '';
  web_footer: any = '';
  constructor(
    public util: UtilService,
    public api: ApiService) {

  }

  ngOnInit(): void {
    this.getGeneralInfo();
  }


  getGeneralInfo() {
    this.util.show();
    this.api.get_private('v1/general/getAll').then((data: any) => {
      this.util.hide();
      if (data && data.status && data.status === 200 && data.success) {
        console.log("<<>><<>><<>>", data);
        if (data.data.length <= 0) {
          this.isCreate = true;
        }
        else {
          this.isCreate = false;
          this.generalInfo = data.data[0];
          this.id = this.generalInfo.id;
          this.storeName = this.generalInfo.store_name;
          this.contact = this.generalInfo.mobile;
          this.email = this.generalInfo.email;
          this.address = this.generalInfo.address;
          this.city = this.generalInfo.city;
          this.state = this.generalInfo.state;
          this.zip = this.generalInfo.zip;
          this.country = this.generalInfo.country;
          this.freeShipOnPrice = this.generalInfo.free_delivery;
          this.tax = this.generalInfo.tax;
          this.shippingType = this.generalInfo.shipping;
          this.shippingPrice = this.generalInfo.shippingPrice;
          this.deliveryArea = this.generalInfo.allowDistance;
          this.facebook_url = this.generalInfo.facebook_url;
          this.instagram = this.generalInfo.instagram;
          this.twitter = this.generalInfo.twitter;
          this.google_playstore = this.generalInfo.google_playstore;
          this.apple_appstore = this.generalInfo.apple_appstore;
          this.web_footer = this.generalInfo.web_footer;
        }
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

  createInfo() {
    if (this.storeName === '' || this.contact === '' || this.email === '' || this.address === '' ||
      this.city === '' || this.state === '' || this.zip <= 0 || this.country == '' || !this.country ||
      this.freeShipOnPrice < 0 || this.tax < 0 || this.shippingType === -1 || this.shippingPrice === -1 ||
      this.deliveryArea < 0 || this.storeName === null || this.contact === null || this.email === -1 ||
      this.address === null || this.city === null || this.state === null || this.zip === null ||
      this.freeShipOnPrice === 0 || this.tax === null ||
      this.shippingType === null || this.shippingPrice === null
    ) {
      this.util.error(this.util.translate('All fields are required'));
      return 0;
    }
    const body = {
      store_name: this.storeName,
      mobile: this.contact,
      email: this.email,
      address: this.address,
      city: this.city,
      state: this.state,
      zip: this.zip,
      free_delivery: this.freeShipOnPrice,
      tax: this.tax,
      shipping: this.shippingType,
      shippingPrice: this.shippingPrice,
      allowDistance: this.deliveryArea,
      facebook_url: this.facebook_url,
      instagram: this.instagram,
      twitter: this.twitter,
      google_playstore: this.google_playstore,
      apple_appstore: this.apple_appstore,
      web_footer: this.web_footer,
      country: this.country,
      searchResultKind: 1,
      status: 1
    };

    console.log(body);
    this.util.show();
    this.api.post_private('v1/general/save', body).then((data: any) => {
      this.util.hide();
      console.log("+++++++++++++++", data);
      if (data && data.status && data.status === 200 && data.success) {
        this.util.success(this.util.translate('Information Saved!'));
        this.getGeneralInfo();
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

  updateInfo() {

    if (this.storeName === '' || this.contact === '' || this.email === '' || this.address === '' ||
      this.city === '' || this.state === '' || this.zip <= 0 || this.country == '' || !this.country ||
      this.freeShipOnPrice < 0 || this.tax < 0 || this.shippingType === -1 || this.shippingPrice === -1 ||
      this.deliveryArea < 0 || this.storeName === null || this.contact === null || this.email === -1 ||
      this.address === null || this.city === null || this.state === null || this.zip === null ||
      this.freeShipOnPrice === 0 || this.tax === null ||
      this.shippingType === null || this.shippingPrice === null
    ) {
      this.util.error(this.util.translate('All fields are required'));
      return 0;
    }
    const body = {
      id: this.id,
      store_name: this.storeName,
      mobile: this.contact,
      email: this.email,
      address: this.address,
      city: this.city,
      state: this.state,
      zip: this.zip,
      free_delivery: this.freeShipOnPrice,
      tax: this.tax,
      shipping: this.shippingType,
      shippingPrice: this.shippingPrice,
      allowDistance: this.deliveryArea,
      facebook_url: this.facebook_url,
      instagram: this.instagram,
      twitter: this.twitter,
      google_playstore: this.google_playstore,
      apple_appstore: this.apple_appstore,
      web_footer: this.web_footer,
      country: this.country,
      searchResultKind: 1,
    };

    console.log(body);
    this.util.show();
    this.api.post_private('v1/general/update', body).then((data: any) => {
      this.util.hide();
      console.log("+++++++++++++++", data);
      if (data && data.status && data.status === 200 && data.success) {
        this.util.success(this.util.translate('Updated !'));
        this.getGeneralInfo();
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
