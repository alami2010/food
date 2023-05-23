/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { UtilService } from './../../services/util.service';
import { ApiService } from './../../services/api.service';
import { Component, OnInit } from '@angular/core';
import { IDropdownSettings } from 'ng-multiselect-dropdown';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-banners',
  templateUrl: './banners.component.html',
  styleUrls: ['./banners.component.scss']
})
export class BannersComponent implements OnInit {
  action = 'create';
  dummy = Array(10);
  dummyBanners = [];
  banners: any[] = [];
  bannerID: any = '';
  categories = [];
  cityId: any = '';
  bannerTitle: any = '';
  cover: any = '';
  value: any = '';
  type: any = 0;
  status: any = 1;
  page: number = 1;
  cities: any[] = [];
  resturants: any[] = [];
  startTime: any = '';
  endTime: any = '';

  dropdownSingleSettings: IDropdownSettings = {
    singleSelection: true,
    idField: 'uid',
    textField: 'name',
    selectAllText: 'Select All',
    unSelectAllText: 'UnSelect All',
    allowSearchFilter: true
  };

  dropdownMultiSettings: IDropdownSettings = {
    singleSelection: false,
    idField: 'uid',
    textField: 'name',
    selectAllText: 'Select All',
    unSelectAllText: 'UnSelect All',
    allowSearchFilter: true,
    itemsShowLimit: 3,
  };

  constructor(
    public api: ApiService,
    public util: UtilService) {
    this.getAllCities();
    this.getAllBanner();
  }


  ngOnInit(): void {

  }
  getAllCities() {
    this.cities = [];
    this.api.get_private('v1/cities/getAll').then((data: any) => {
      this.dummy = [];
      if (data && data.status && data.status === 200 && data.success) {
        console.log(">>>>>", data);
        if (data.data.length > 0) {
          this.cities = data.data;
          console.log("=========", this.cities);
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

  getAllBanner() {
    this.banners = [];
    this.dummy = Array(10);
    this.api.get_private('v1/banners/getAll').then((data: any) => {
      console.log('banner=>', data);
      this.dummy = [];
      if (data && data.status && data.status === 200 && data.success) {
        if (data && data.data.length > 0) {
          this.banners = data.data;
          this.dummyBanners = data.data;
        }
      }
    }, error => {
      this.dummy = [];
      this.util.hide();
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.dummy = [];
      this.util.hide();
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  getBannerByID(id: any) {
    this.action = 'update';
    this.bannerID = id;
    const body = {
      id: this.bannerID,
    };
    console.log("BANNER BY ID => ", body);
    this.util.show();
    this.api.post_private('v1/banners/getInfoById', body).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status === 200 && data.success) {
        this.bannerTitle = data.data.title;
        this.cover = data.data.cover;
        this.type = data.data.type;
        this.status = data.data.status;
        this.cityId = data.data.city_id;
        this.startTime = data.data.from;
        this.endTime = data.data.to;

        if (this.type == 1 || this.type == '1') { // load categories
          console.log('its cates', data.data.value);
          this.value = data.data.value;
          this.getAllCat();
        } else if (this.type == 2 || this.type == '2') { // load Restaurants
          // this.value = data.data.restInfo;
          this.value = data.data.value;
          this.getStores();
        } else if (this.type == 3 || this.type == '3') { // load resturants
          this.value = data.data.restInfo;
          this.getStores();
        } else if (this.type == 4 || this.type == '4') {
          console.log('its external link', data.data.value);
          this.value = data.data.value;

        }
        console.log('value', this.value);
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

  getStores() {
    this.api.post_private('v1/store/getStoresWithCityId', { id: this.cityId }).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        this.resturants = data.data;
      }
    }, error => {
      console.log(error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.apiErrorHandler(error);
    });
  }

  onCityChanged(event: any) {
    console.log(event);
    this.resturants = [];
    this.type = 0;
  }

  onChange(value: any) {
    this.type = value.target.value;
    this.value = '';
    console.log("<><><><><>", this.type);
    if (this.type == 1 || this.type == '1') { // load categories
      this.getAllCat();
    } else if (this.type == 2 || this.type == '2') { // load Restaurants
      this.getStores();
    } else if (this.type == 3 || this.type == '3') { // load resturants
      this.getStores();
    }
  }

  getAllCat() {
    this.util.show();
    this.api.get_private('v1/categories/getAll').then((data: any) => {
      this.util.hide();
      if (data && data.status && data.status === 200 && data.success) {
        if (data && data.data.length > 0) {
          data.data.forEach((info: any) => {
            if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false; } })(info.extra_field)) {
              const extra_field = JSON.parse(info.extra_field);
              if (extra_field && extra_field.translation) {
                const currentTranslation = extra_field.translation.filter((x: any) => x.id == localStorage.getItem('selectedLanguage'));
                if (currentTranslation && currentTranslation.length) {
                  info.name = currentTranslation[0].title;
                }
              }
            }

          });
          this.categories = data.data;
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

  createBanner() {
    console.log('city', this.cityId);
    console.log('type', this.type);
    console.log('cover', this.cover);
    console.log('vaue', this.value);
    console.log('title', this.bannerTitle);
    console.log('status', this.status);

    if (this.cityId == 0 || !this.cityId || this.type == 0 || !this.type || !this.cover || this.cover === '' || !this.value || this.value == '') {
      this.util.error(this.util.translate('All fields are required'));
      return false;
    }

    let values = '';
    if (this.type == 3 || this.type == '3') {
      console.log('convert values', this.value);
      if (this.value && this.value.length) {
        const ids = this.value.map((x: any) => x.uid);
        console.log('ids', ids);
        if (ids && ids.length) {
          values = ids.join();
        }
      } else {
        this.util.error(this.util.translate('Please select restaurants'));
        return false
      }
    } else {
      values = this.value
    }
    console.log('values', values);

    const param = {
      title: this.bannerTitle,
      city_id: this.cityId,
      cover: this.cover,
      type: this.type,
      value: values,
      from: this.startTime,
      to: this.endTime,
      status: this.status,
    };
    this.util.show();
    this.api.post_private('v1/banners/save', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200) {
        this.getAllBanner();
        this.clearData();
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

  clearData() {
    this.bannerTitle = '';
    this.cover = '';
    this.value = 0;
    this.type = 0;
    this.status = 0;
    this.startTime = '';
    this.endTime = '';
    this.cityId = '';
    this.bannerID = '';
    this.action = 'create';
  }

  updateBanner() {
    console.log('city', this.cityId);
    console.log('type', this.type);
    console.log('cover', this.cover);
    console.log('vaue', this.value);
    console.log('title', this.bannerTitle);
    console.log('status', this.status);

    if (this.cityId == 0 || !this.cityId || this.type == 0 || !this.type || !this.cover || this.cover === '' || !this.value || this.value == '') {
      this.util.error(this.util.translate('All fields are required'));
      return false;
    }

    let values = '';
    if (this.type == 3 || this.type == '3') {
      console.log('convert values', this.value);
      if (this.value && this.value.length) {
        const ids = this.value.map((x: any) => x.uid);
        console.log('ids', ids);
        if (ids && ids.length) {
          values = ids.join();
        }
      } else {
        this.util.error(this.util.translate('Please select restaurants'));
        return false
      }
    } else {
      values = this.value
    }
    console.log('values', values);

    const param = {
      title: this.bannerTitle,
      id: this.bannerID,
      city_id: this.cityId,
      cover: this.cover,
      type: this.type,
      value: values,
      from: this.startTime,
      to: this.endTime,
      status: this.status,
    };
    this.util.show();
    this.api.post_private('v1/banners/update', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200) {
        this.getAllBanner();
        this.clearData();
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

  getStatus(val: any) {
    if (val === 1 || val === '1') {
      return this.util.translate('Active');
    }
    else if (val === 0 || val === '0') {
      return this.util.translate('Deactive');
    }
  }

  statusUpdate(val: any) {
    this.bannerID = val.id;

    const body = {
      id: this.bannerID,
      status: val.status === 0 ? 1 : 0
    };
    console.log("===========", body);
    this.util.show();
    this.api.post_private('v1/banners/update', body).then((data: any) => {
      console.log("+++++++++++++++", data);
      this.util.hide();
      if (data && data.status && data.status === 200 && data.success) {
        this.util.success(this.util.translate('Banner Status Updated !'));
        this.getAllBanner();
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

  search(str: any) {
    this.resetChanges();
    console.log('string', str);
    this.banners = this.filterItems(str);
  }

  protected resetChanges = () => {
    this.banners = this.dummyBanners;
  }

  filterItems(searchTerm: any) {
    return this.banners.filter((item) => {
      return item.text.toLowerCase().indexOf(searchTerm.toLowerCase()) > -1;
    });
  }

  setFilteredItems() {
    console.log('clear');
    this.banners = [];
    this.banners = this.dummyBanners;
  }

  getClass(item: any) {
    if (item === '1' || item === 1) {
      return 'badge badge-success';
    } else if (item === '0' || item === 0) {
      return 'badge badge-dark';
    }
    return 'badge badge-warning';
  }

  deleteItem(item: any) {
    console.log(item);
    console.log('update status', item);
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To delete this item?'),
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
        console.log(item);
        this.util.show();
        this.api.post_private('v1/banners/destroy', item).then((data) => {
          console.log(data);
          this.util.hide();
          this.util.success(this.util.translate('Deleted'));
          this.getAllBanner();
        }, error => {
          console.log(error);
          this.util.hide();
        }).catch(error => {
          this.util.hide();
          console.log(error);
        });
      }
    });
  }

}
