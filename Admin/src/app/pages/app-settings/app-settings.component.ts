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

@Component({
  selector: 'app-app-settings',
  templateUrl: './app-settings.component.html',
  styleUrls: ['./app-settings.component.scss']
})
export class AppSettingsComponent implements OnInit {
  @ViewChild('largeModal') public largeModal: ModalDirective;

  currencySymbol: any = '$';
  currencySide: any = 'left';
  currencyCode: any = 'usd';
  appDirection: any = 'ltr';
  logo: any = '';
  sms_name: any = '0';
  user_login: any = 0; // 0 = email & password || 1 = phone & password || 2 = phone & OTP
  user_verify_with: any = 0; // 0 = email ; 1 = phone
  id: any;
  haveData: boolean = false;
  app_color: any = '#000000';
  app_status: any = 1;
  country_modal: any[] = [];
  show_booking: any = 1;
  home_page_style: any = 1;
  store_page_stype: any = 1;
  driver_assign: any = 1;
  default_country_code: any;
  fcm_token: any;

  twilloCreds = {
    sid: '',
    token: '',
    from: ''
  };

  msgCreds = {
    key: '',
    sender: ''
  }

  countries: any[] = [];
  dummy: any[] = [];
  dummyLoad: any[] = [];
  selected: any[] = [];
  constructor(
    public util: UtilService,
    public api: ApiService,
  ) {
    this.getData();
  }

  ngOnInit(): void {
  }

  getData() {
    this.util.show();
    this.api.get_private('v1/setttings/getSettingsForOwner').then((data: any) => {
      this.util.hide();
      console.log(data);
      if (data && data.status === 200 && data.data && data.data.length) {
        this.haveData = true;
        this.id = data.data[0].id;
        const info = data.data[0];
        console.log(info);
        this.appDirection = info.appDirection;
        this.currencySide = info.currencySide;
        this.currencySymbol = info.currencySymbol;
        this.logo = info.logo;
        this.sms_name = info.sms_name;
        this.user_login = info.user_login;
        this.app_status = info.app_status;
        this.app_color = info.app_color;
        this.show_booking = info.show_booking;
        this.store_page_stype = info.store_page_stype;
        this.currencyCode = info.currencyCode;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false; } })(info.country_modal)) {
          this.country_modal = JSON.parse(info.country_modal);
        }
        this.home_page_style = info.home_page_style;
        this.driver_assign = info.driver_assign;
        this.default_country_code = info.default_country_code;
        this.user_verify_with = info.user_verify_with;
        this.fcm_token = info.fcm_token;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.sms_creds)) {
          const creds = JSON.parse(info.sms_creds);
          console.log('creds=>', creds);
          this.twilloCreds = creds.twilloCreds;
          this.msgCreds = creds.msg;
        }
      } else {
        this.haveData = false;
      }
      console.log('have data=?', this.haveData);
    }, error => {
      this.util.hide();
      console.log(error);
      this.haveData = false;
    }).catch(error => {
      this.util.hide();
      console.log(error);
      this.haveData = false;
    });
  }


  createSettings() {
    console.log(this.app_color);
    if (this.currencySymbol === '' || this.currencySide === '' || this.logo === '' || this.appDirection === '' || this.sms_name === '' || this.user_login === '' || this.currencyCode === '' || this.home_page_style === '' || !this.default_country_code || this.default_country_code === '' || this.fcm_token === '' || !this.fcm_token) {
      this.util.error(this.util.translate('All fields are required'));
      return false;
    }
    if (this.sms_name === '0') {
      if (this.twilloCreds.sid === '' || !this.twilloCreds.sid || this.twilloCreds.token === '' || !this.twilloCreds.token || this.twilloCreds.from === '' || !this.twilloCreds.from) {
        this.util.error(this.util.translate('Twilio credentials missings'));
        return false;
      }
    }

    if (this.sms_name === '1') {
      if (this.msgCreds.key === '' || !this.msgCreds.key || this.msgCreds.sender === '' || !this.msgCreds.sender) {
        this.util.error(this.util.translate('Msg91 credentials missings'));
        return false;
      }
    }


    if (this.haveData === false) {
      console.log('create');
      this.create();
    } else {
      console.log('update');
      this.update();
    }
  }

  create() {
    const creds = {
      twilloCreds: this.twilloCreds,
      msg: this.msgCreds,
    }
    const param = {
      currencySymbol: this.currencySymbol,
      currencySide: this.currencySide,
      appDirection: this.appDirection,
      logo: this.logo,
      sms_name: this.sms_name,
      sms_creds: JSON.stringify(creds),
      user_login: this.user_login,
      status: 1,
      app_color: this.app_color,
      app_status: this.app_status,
      country_modal: JSON.stringify(this.country_modal),
      show_booking: this.show_booking,
      store_page_stype: this.store_page_stype,
      currencyCode: this.currencyCode,
      driver_assign: this.driver_assign,
      home_page_style: this.home_page_style,
      default_country_code: this.default_country_code,
      user_verify_with: this.user_verify_with,
      fcm_token: this.fcm_token,
    }
    console.log(param);

    this.util.show();
    this.api.post_private('v1/setttings/save', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status === 200) {
        this.getData();
        window.location.reload();
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

  update() {
    const creds = {
      twilloCreds: this.twilloCreds,
      msg: this.msgCreds,
    }
    const param = {
      currencySymbol: this.currencySymbol,
      currencySide: this.currencySide,
      appDirection: this.appDirection,
      logo: this.logo,
      sms_name: this.sms_name,
      sms_creds: JSON.stringify(creds),
      user_login: this.user_login,
      status: 1,
      app_color: this.app_color,
      id: this.id,
      app_status: this.app_status,
      country_modal: JSON.stringify(this.country_modal),
      show_booking: this.show_booking,
      store_page_stype: this.store_page_stype,
      currencyCode: this.currencyCode,
      driver_assign: this.driver_assign,
      home_page_style: this.home_page_style,
      default_country_code: this.default_country_code,
      user_verify_with: this.user_verify_with,
      fcm_token: this.fcm_token,
    }
    console.log(param);

    this.util.show();
    this.api.post_private('v1/setttings/update', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status === 200) {
        this.getData();
        window.location.reload();
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

  preview_banner(files: any) {
    console.log('fle', files);
    if (files.length === 0) {
      return;
    }
    const mimeType = files[0].type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }
    if (files) {
      console.log('ok');
      this.util.show();
      this.api.uploadFile(files).subscribe((data: any) => {
        console.log('==>>>>>>', data.data);
        this.util.hide();
        if (data && data.data.image_name) {
          this.logo = data.data.image_name;
        }
      }, error => {
        console.log(error);
        this.util.hide();
        this.util.apiErrorHandler(error);
      });
    } else {
      console.log('no');
    }
  }

  openCountryModel() {
    console.log('open moda');
    this.dummyLoad = Array(10);
    setTimeout(() => {
      this.dummyLoad = [];
      this.dummy = this.util.countrys;
      this.countries = this.dummy;
      this.util.countrys.forEach(element => {
        const exist = this.country_modal.filter(x => x.country_code === element.country_code);
        element.isChecked = exist && exist.length ? true : false;
      })
      console.log(this.dummy);
    }, 500);
    this.largeModal.show();
  }

  onSearchChange(events: any) {
    console.log(events);
    if (events !== '') {
      this.countries = this.dummy.filter((item) => {
        return item.country_name.toLowerCase().indexOf(events.toLowerCase()) > -1;
      });
    } else {
      this.countries = [];
    }
  }

  changed() {
    this.selected = this.util.countrys.filter(x => x.isChecked === true);
    console.log(this.selected);
  }

  saveCountries() {
    this.country_modal = this.selected;
    this.largeModal.hide();
  }
}
