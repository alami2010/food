/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ActivatedRoute } from '@angular/router';
import { ModalDirective } from 'ngx-bootstrap/modal';
import { ChangeDetectorRef, Component, OnInit, ViewChild } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';
import { IDropdownSettings } from 'ng-multiselect-dropdown';
import * as moment from 'moment';
import { Location } from '@angular/common';

@Component({
  selector: 'app-manage-stores',
  templateUrl: './manage-stores.component.html',
  styleUrls: ['./manage-stores.component.scss']
})
export class ManageStoresComponent implements OnInit {
  @ViewChild('largeModal') public largeModal: ModalDirective;
  first_name: any = '';
  last_name: any = '';
  email: any = '';
  password: any = '';
  country_code: any = '';
  cities: any[] = [];
  categories: any[] = [];
  city_id: any = '';
  name: any = '';
  cover: any = '';
  mobile: any = '';
  address: any = '';
  landmark: any = '';
  pincode: any = '';
  lat: any = '';
  lng: any = '';
  master_categories: any[] = [];
  delivery_type: any = '';
  pure_veg: any = '';
  have_dining: any = '';
  min_order_price: any = '';
  extra_charges: any = '';
  short_descriptions: any = '';
  open_time: any = '';
  close_time: any = '';
  certificate: any = '';
  cuisines: any = '';
  delivery_time: any = '';
  cost_for_two: any = '';
  edit: boolean = false;

  countries: any[] = [];
  dummy: any[] = [];
  dummyLoad: any[] = [];
  displayed: any = '';
  commisstionRate: any = '';

  dropdownSettings: IDropdownSettings = {
    singleSelection: false,
    idField: 'name',
    textField: 'name',
    selectAllText: 'Select All',
    unSelectAllText: 'UnSelect All',
    itemsShowLimit: 3,
    allowSearchFilter: true
  };

  dropdownCategorySettings: IDropdownSettings = {
    singleSelection: false,
    idField: 'id',
    textField: 'name',
    selectAllText: 'Select All',
    unSelectAllText: 'UnSelect All',
    itemsShowLimit: 3,
    allowSearchFilter: true
  };

  submited: boolean = false;
  storeId: any = '';
  constructor(
    public util: UtilService,
    public api: ApiService,
    private navCtrl: Location,
    private route: ActivatedRoute,
    private chMod: ChangeDetectorRef
  ) {

    this.getAllCities();
    this.getAllCat();
    this.route.queryParams.subscribe((data: any) => {
      console.log(data);
      if (data && data.id) {
        this.storeId = data.id;
        this.edit = true;
        this.getInfor();
      }
    })

  }
  getInfor() {
    const param = {
      id: this.storeId
    }
    this.util.show();
    this.api.post_private('v1/store/getById', param).then((data: any) => {
      this.util.hide();
      console.log(data);
      if (data && data.status && data.status == 200 && data.data) {
        const info = data.data;
        this.address = info.address;
        this.certificate = info.certificate;
        this.city_id = info.city_id;
        this.close_time = info.close_time;
        this.cost_for_two = info.cost_for_two;
        this.cover = info.cover;
        this.delivery_time = info.delivery_time;
        this.delivery_type = info.delivery_type;
        this.extra_charges = info.extra_charges;
        this.have_dining = info.have_dining;
        this.landmark = info.landmark;
        this.commisstionRate = info.commission;
        this.min_order_price = info.min_order_price;
        this.name = info.name;
        this.open_time = info.open_time;
        this.pincode = info.pincode;
        this.pure_veg = info.pure_veg;
        this.short_descriptions = info.short_descriptions;
        this.lat = info.lat;
        this.lng = info.lng;
        this.master_categories = info.master;
        // this.cuisines = info.cusi;
        try {
          if (info.cuisines) {
            const cusi = info.cuisines.split(',');
            this.cuisines = [];
            cusi.forEach((element: any) => {
              this.cuisines.push({ name: element });
            });
          }
        } catch (error) {
          console.log(error);
        }
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

  getAllCat() {
    this.categories = [];
    this.api.get_private('v1/categories/getAll').then((data: any) => {
      if (data && data.status && data.status === 200 && data.success) {
        console.log(">>>>>", data);
        if (data.data.length > 0) {
          this.categories = data.data;
          console.log("=========", this.categories);
        }
      }
    }, error => {
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  getAllCities() {
    this.cities = [];
    this.api.get_private('v1/cities/getAll').then((data: any) => {
      if (data && data.status && data.status === 200 && data.success) {
        console.log(">>>>>", data);
        if (data.data.length > 0) {
          this.cities = data.data;
          console.log("=========", this.cities);
        }
      }
    }, error => {
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  ngOnInit(): void {
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
        console.log('==>>', data);
        this.util.hide();
        if (data && data.data.image_name) {
          this.cover = data.data.image_name;
        }
      }, err => {
        console.log(err);
        this.util.hide();
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

  useCode() {
    console.log(this.country_code);
    this.displayed = '+' + this.country_code;
    this.largeModal.hide();
  }

  create() {
    this.submited = true;
    console.log('create new store');
    console.log(this.email, 'email');
    console.log(this.password, 'password');
    console.log(this.first_name, 'fname');
    console.log(this.last_name, 'lnga');
    console.log(this.country_code, 'cc');
    console.log(this.mobile, 'mobile');
    console.log(this.name, 'name');
    console.log(this.city_id, 'city');
    console.log(this.master_categories, 'cates');
    console.log(this.delivery_type, 'type');
    console.log(this.short_descriptions, 'desc');
    console.log(this.pure_veg, 'veg');
    console.log(this.have_dining, 'dining');
    console.log(this.min_order_price, 'min');
    console.log(this.cost_for_two, 'cost');
    console.log(this.address, 'address');
    console.log(this.landmark, 'landmark');
    console.log(this.pincode, 'pincode');
    console.log(this.cuisines, 'cusines');
    console.log(this.extra_charges, 'extra');
    console.log(this.open_time, 'open', this.close_time, 'close');
    console.log(this.cover, 'cover');
    console.log(this.commisstionRate, 'commisstionRate');

    // if (typeof google === 'object' && typeof google.maps === 'object') {
    if (this.email == '' || this.password == '' || this.first_name == '' || this.last_name == '' || this.country_code == '' || this.mobile == '' ||
      this.name == '' || this.city_id == '' || this.master_categories.length == 0 || this.delivery_type == '' || this.short_descriptions == '' || this.pure_veg == '' ||
      this.have_dining == '' || this.min_order_price == '' || this.cost_for_two == '' || this.address == '' || this.landmark == '' || this.pincode == '' ||
      this.cuisines == '' || this.extra_charges == '' || this.open_time == '' || this.close_time == '' || this.cover == '' || this.commisstionRate == '' ||
      this.lat == '' || this.lng == '' || this.lat == null || this.lng == null) {
      this.util.error('All fields are required');
      return false;
    }
    if (!this.cuisines || this.cuisines.length == 0) {
      this.util.error('please select cuisines ');
      return false;
    }

    if (!this.master_categories || this.master_categories.length == 0) {
      this.util.error('please select categories');
      return false;
    }

    const emailfilter = /^[\w._-]+[+]?[\w._-]+@[\w.-]+\.[a-zA-Z]{2,6}$/;
    if (!emailfilter.test(this.email)) {
      this.util.error(this.util.translate('Please enter valid email'));
      return false;
    }
    console.log(this.cuisines.map((x: any) => x.name));
    console.log(this.master_categories.map(x => x.id));
    this.util.show();
    const master_categories = this.master_categories.map(x => x.id);
    const cuisines = this.cuisines.map((x: any) => x.name);

    const param = {
      first_name: this.first_name,
      last_name: this.last_name,
      mobile: this.mobile,
      country_code: '+' + this.country_code,
      email: this.email,
      password: this.password
    }

    this.api.post_private('v1/auth/create_store_account', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200 && data.user && data.user.id) {
        const store_param = {
          uid: data.user.id,
          city_id: this.city_id,
          name: this.name,
          cover: this.cover,
          mobile: this.mobile,
          address: this.address,
          landmark: this.landmark,
          pincode: this.pincode,
          lat: this.lat,
          lng: this.lng,
          master_categories: master_categories.join(','),
          delivery_type: this.delivery_type,
          pure_veg: this.pure_veg,
          have_dining: this.have_dining,
          min_order_price: this.min_order_price,
          extra_charges: this.extra_charges,
          short_descriptions: this.short_descriptions,
          images: 'NA',
          verified: 1,
          status: 1,
          open_time: moment('1997-07-15 ' + this.open_time).format('HH:mm'),
          close_time: moment('1997-07-18 ' + this.close_time).format('HH:mm'),
          is_closed: 0,
          certificate: this.certificate,
          ratings: 0,
          cuisines: cuisines.join(','),
          delivery_time: this.delivery_time,
          cost_for_two: this.cost_for_two
        };
        this.api.post_private('v1/store/create_store_account', store_param).then((data: any) => {
          console.log(data);
          if (data && data.status && data.status == 200 && data.data && data.data.id) {
            const commissionParam = {
              store_id: data.data.id,
              rate: this.commisstionRate,
              status: 1
            };
            this.api.post_private('v1/commission/save', commissionParam).then((data: any) => {
              console.log(data);
              this.util.hide();
              if (data && data.status && data.status == 200 && data.data) {
                this.util.success('Restaurant Saved');
                this.navCtrl.back();
              } else {
                this.util.error('Something went wrong while saving store commissions');
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
          } else {
            this.util.hide();
            this.util.error('Something went wrong while creating store account');
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
      } else {
        this.util.hide();
        this.util.error('Something went wrong while registering store account');
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
    console.log('update store info', this.master_categories);
    this.pure_veg == 1 ? 1 : 0;
    this.submited = true;
    console.log(this.name, 'name');
    console.log(this.city_id, 'city');
    console.log(this.master_categories, 'cates', this.master_categories.length == 0);
    console.log(this.delivery_type, 'type');
    console.log(this.short_descriptions, 'desc');
    console.log(this.pure_veg, 'veg', this.pure_veg == '');
    console.log(this.have_dining, 'dining', this.have_dining == '');
    console.log(this.min_order_price, 'min');
    console.log(this.cost_for_two, 'cost');
    console.log(this.address, 'address');
    console.log(this.landmark, 'landmark');
    console.log(this.pincode, 'pincode');
    console.log(this.cuisines, 'cusines', this.cuisines === '');
    console.log(this.extra_charges, 'extra');
    console.log(this.open_time, 'open', this.close_time, 'close');
    console.log(this.cover, 'cover');
    console.log(this.commisstionRate, 'commisstionRate');

    console.log(this.name == '', 'name', this.city_id == '', 'city', this.master_categories.length == 0, 'cates', this.delivery_type == '', 'type', this.short_descriptions == '', 'desc', this.pure_veg == '', 'veg',
      this.have_dining == '', 'ding', this.min_order_price == '', 'min', this.cost_for_two == '', 'cost', this.address == '', 'add', this.landmark == '', 'land', this.pincode == '', 'pin',
      this.cuisines == '', 'cusi', this.extra_charges == '', 'extra', this.open_time == '', 'open', this.close_time == '', 'close', this.cover == '', 'cover', this.commisstionRate == '', 'rate');
    if (this.name == '' || this.city_id == '' || this.master_categories.length == 0 || this.delivery_type == '' || this.short_descriptions == '' || this.pure_veg == '' ||
      this.have_dining == '' || this.min_order_price == '' || this.cost_for_two == '' || this.address == '' || this.landmark == '' || this.pincode == '' ||
      this.cuisines == '' || this.extra_charges == '' || this.open_time == '' || this.close_time == '' || this.cover == '' || this.commisstionRate == '' ||
      this.lat == '' || this.lng == '' || this.lat == null || this.lng == null) {
      this.util.error('All fields are required');
      return false;
    }

    if (!this.cuisines || this.cuisines.length == 0) {
      this.util.error('please select cuisines ');
      return false;
    }

    if (!this.master_categories || this.master_categories.length == 0) {
      this.util.error('please select categories');
      return false;
    }

    console.log(this.cuisines.map((x: any) => x.name));
    console.log(this.master_categories.map(x => x.id));
    this.util.show();

    const master_categories = this.master_categories.map(x => x.id);
    const cuisines = this.cuisines.map((x: any) => x.name);

    const param = {
      id: this.storeId,
      city_id: this.city_id,
      name: this.name,
      cover: this.cover,
      address: this.address,
      landmark: this.landmark,
      pincode: this.pincode,
      lat: this.lat,
      lng: this.lng,
      master_categories: master_categories.join(','),
      delivery_type: this.delivery_type,
      pure_veg: this.pure_veg,
      have_dining: this.have_dining,
      min_order_price: this.min_order_price,
      extra_charges: this.extra_charges,
      short_descriptions: this.short_descriptions,
      images: 'NA',
      verified: 1,
      status: 1,
      open_time: moment('1997-07-15 ' + this.open_time).format('HH:mm'),
      close_time: moment('1997-07-18 ' + this.close_time).format('HH:mm'),
      is_closed: 0,
      certificate: this.certificate,
      ratings: 0,
      cuisines: cuisines.join(','),
      delivery_time: this.delivery_time,
      cost_for_two: this.cost_for_two
    };
    this.util.show();
    this.api.post_private('v1/store/updateInfo', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status === 200) {
        const commParam = {
          id: this.storeId,
          rate: this.commisstionRate
        };
        this.api.post_private('v1/commission/updateCommission', commParam).then((data: any) => {
          this.util.hide();
          if (data && data.status && data.status == 200) {
            this.util.success('Updated');
            this.navCtrl.back();
          } else {
            this.util.error('Something went wrong while updating store commissions');
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
      } else {
        this.util.hide();
        this.util.error('Something went wrong while updating store informations');
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
