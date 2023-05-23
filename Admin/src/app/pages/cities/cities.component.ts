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
import Swal from 'sweetalert2';

@Component({
  selector: 'app-cities',
  templateUrl: './cities.component.html',
  styleUrls: ['./cities.component.scss']
})
export class CitiesComponent implements OnInit {
  action = 'create';
  dummy = Array(10);
  cities: any[] = [];
  dummyCities: any[] = [];
  name: any = '';
  status = '-1';
  cityId: any = '';
  lat: any = '';
  lng: any = '';
  page: number = 1;
  cover: any = '';
  constructor(
    public api: ApiService,
    public util: UtilService) {
    this.getAllCities();
  }


  ngOnInit(): void {
  }


  getAllCities() {
    this.cities = [];
    this.dummy = Array(10);
    this.api.get_private('v1/cities/getAll').then((data: any) => {
      this.dummy = [];
      if (data && data.status && data.status === 200 && data.success) {
        console.log(">>>>>", data);
        if (data.data.length > 0) {
          this.cities = data.data;
          this.dummyCities = data.data;
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

  search(str: any) {
    this.resetChanges();
    console.log('string', str);
    this.cities = this.filterItems(str);
  }

  protected resetChanges = () => {
    this.cities = this.dummyCities;
  }

  filterItems(searchTerm: any) {
    return this.cities.filter((item) => {
      return item.name.toLowerCase().indexOf(searchTerm.toLowerCase()) > -1;
    });
  }

  setFilteredItems() {
    console.log('clear');
    this.cities = [];
    this.cities = this.dummyCities;
  }

  deleteItem(item: any) {
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
        console.log(item);
        this.util.show();
        this.api.post_private('v1/cities/destroy', { id: item.id }).then((data: any) => {
          console.log(data);
          this.util.hide();
          if (data && data.status && data.status === 200) {
            this.getAllCities();
          }
        }).catch(error => {
          console.log(error);
          this.util.hide();
          this.util.apiErrorHandler(error);
        });
      }
    });

  }


  statusUpdate(val: any) {
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
        this.cityId = val.id;
        const body = {
          id: this.cityId,
          status: val.status === 0 ? 1 : 0
        };
        console.log("===========", body);
        this.util.show();
        this.api.post_private('v1/cities/update', body).then((data: any) => {
          this.util.hide();
          console.log("+++++++++++++++", data);
          if (data && data.status && data.status === 200 && data.success) {
            this.util.success(this.util.translate('Status Updated !'));
            this.getAllCities();
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

  updateInfo(id: any) {
    this.action = 'update';
    this.cityId = id;
    const body = {
      id: this.cityId,
    };
    console.log("CAT BY ID => ", body);
    this.util.show();
    this.api.post_private('v1/cities/getById', body).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status === 200 && data.success) {
        this.name = data.data.name;
        this.status = data.data.status;
        this.cover = data.data.cover;
        this.lat = data.data.lat;
        this.lng = data.data.lng;
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

  clearData() {
    console.log("CLEAR DATA");
    this.name = '';
    this.cover = '';
    this.status = '-1';
    this.lat = '';
    this.lng = '';
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

  createCity() {
    if (this.name === '' || this.cover === '' || this.status === '-1' || this.name === null || this.cover === null || this.status === null ||
      this.lat == '' || this.lng == '' || this.lat == null || this.lng == null) {
      this.util.error(this.util.translate('All Fields are required'));
    } else {
      const slugs = this.convertToSlug(this.name);
      const body = {
        name: this.name,
        cover: this.cover,
        status: this.status,
        slugs: slugs,
        lat: this.lat,
        lng: this.lng
      };
      this.util.show();
      this.api.post_private('v1/cities/create', body).then((data: any) => {
        console.log("+++++++++++++++", data);
        this.util.hide();
        if (data && data.status && data.status === 200 && data.success) {
          this.clearData();
          this.util.success(this.util.translate('City added !'));
          this.getAllCities();
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

  convertToSlug(Text: any) {
    return Text
      .toLowerCase()
      .replace(/ /g, '-')
      .replace(/[^\w-]+/g, '')
      ;
  }

  updateCity() {
    if (this.name === '' || this.cover === '' || this.status === '-1' || this.name === null || this.cover === null || this.status === null ||
      this.lat == '' || this.lng == '' || this.lat == null || this.lng == null) {
      this.util.error(this.util.translate('All fields are required'));
    }
    else {

      const body = {
        id: this.cityId,
        name: this.name,
        cover: this.cover,
        status: this.status,
      };
      console.log("===========", body);
      this.util.show();
      this.api.post_private('v1/cities/update', body).then((data: any) => {
        console.log("+++++++++++++++", data);
        this.util.hide();
        if (data && data.status && data.status === 200 && data.success) {
          this.clearData();
          this.util.success(this.util.translate('City Updated !'));
          this.action = 'create';
          this.getAllCities();
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

}
