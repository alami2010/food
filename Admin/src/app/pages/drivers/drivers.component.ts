/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ModalDirective } from 'ngx-bootstrap/modal';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';
import Swal from 'sweetalert2';
import { Router, NavigationExtras } from '@angular/router';

@Component({
  selector: 'app-drivers',
  templateUrl: './drivers.component.html',
  styleUrls: ['./drivers.component.scss']
})
export class DriversComponent implements OnInit {
  @ViewChild('myModal3') public myModal3: ModalDirective;
  @ViewChild('myModal2') public myModal2: ModalDirective;
  @ViewChild('largeModal') public largeModal: ModalDirective;
  dummy = Array(10);
  dummyUsers = [];
  users: any[] = [];
  page: number = 1;

  haveData: boolean = false;

  email: any = '';
  submited: boolean = false;
  fname: any = '';
  lat: any = '';
  lng: any = '';
  lname: any = '';
  password: any = '';
  phone: any = '';
  country_code: any = '';
  id: any = '';
  countries: any[] = [];
  dummyCC: any[] = [];
  dummyLoad: any[] = [];
  displayed: any = '';
  action: any = '';
  gender: any = 1;
  cover: any = '';
  constructor(
    private router: Router,
    public api: ApiService,
    public util: UtilService) {
    this.getAllUsers();
  }

  ngOnInit(): void {
  }

  getAllUsers() {
    this.api.get_private('v1/drivers/getAll').then((data: any) => {
      this.dummy = [];
      if (data && data.status && data.status == 200 && data.success) {
        console.log(">>>>>", data);
        if (data && data.data.length > 0) {
          this.users = data.data;
          this.dummyUsers = data.data;
          console.log("======", this.users);
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
    this.users = this.filterItems(str);
  }


  protected resetChanges = () => {
    this.users = this.dummyUsers;
  }

  filterItems(searchTerm: any) {
    return this.users.filter((item) => {
      var name = item.first_name + " " + item.last_name;
      return name.toLowerCase().indexOf(searchTerm.toLowerCase()) > -1;
    });
  }

  setFilteredItems() {
    console.log('clear');
    this.users = [];
    this.users = this.dummyUsers;
  }

  getClass(item: any) {
    if (item == '1' || item == 1) {
      return 'badge badge-success';
    } else if (item == '0' || item == 0) {
      return 'badge badge-danger';
    }
    return 'badge badge-warning';
  }

  statusUpdate(item: any) {
    console.log(item);
    const text = item.status == 1 ? 'Deactive' : 'Active';
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To') + ' ' + text + ' ' + this.util.translate('this user!'),
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
        this.util.show();
        this.api.post_private('v1/drivers/update', item).then((datas) => {
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
        this.util.show();
        this.api.post_private('v1/drivers/destroy', item).then((datas) => {
          this.util.hide();
          this.util.success('Deleted');
          this.getAllUsers();
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

  addNew() {
    this.action = 'create';
    this.myModal2.show();
  }


  onSearchChange(events: any) {
    console.log(events);
    if (events !== '') {
      this.countries = this.dummyCC.filter((item) => {
        return item.country_name.toLowerCase().indexOf(events.toLowerCase()) > -1;
      });
    } else {
      this.countries = this.dummyCC;
    }
  }

  useCode() {
    console.log(this.country_code);
    this.displayed = '+' + this.country_code;
    this.largeModal.hide();
  }

  exportCSV() {
    let data: any = [];
    this.users.forEach(element => {
      const info = {
        'id': this.util.replaceWithDot(element.id),
        'first_name': this.util.replaceWithDot(element.first_name),
        'last_name': this.util.replaceWithDot(element.last_name),
        'cover': this.util.replaceWithDot(element.cover),
        'country_code': this.util.replaceWithDot(element.country_code),
        'mobile': this.util.replaceWithDot(element.mobile),
        'email': this.util.replaceWithDot(element.email),
      }
      data.push(info);
    });
    const name = 'drivers';
    this.util.downloadFile(data, name, ['id', 'first_name', 'last_name', 'cover', 'country_code', 'mobile', 'email']);
  }


  updateInfo(item: any) {
    console.log('item', item);
    this.action = 'edit';
    this.id = item.id;
    this.fname = item.first_name;
    this.lname = item.last_name;
    this.cover = item.cover;
    this.country_code = item.country_code;
    this.phone = item.mobile;
    this.lat = item.lat;
    this.lng = item.lng;
    this.displayed = item.country_code;
    this.myModal2.show();
  }

  openCountryModel() {
    console.log('open moda');
    this.dummyLoad = Array(10);
    setTimeout(() => {
      this.dummyLoad = [];
      this.dummyCC = this.util.countrys;
      this.countries = this.dummyCC;
      this.util.countrys;
      console.log(this.dummyCC);
    }, 500);
    this.largeModal.show();
  }

  preview_banner(files: any) {
    console.log('fle', files);
    if (files.length == 0) {
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

  editChanges() {
    this.submited = true;

    if (this.fname == '' || this.fname == null || this.lname == '' || this.lname == null ||
      this.lat == null || this.lat == '' || this.lng == '' ||
      this.lng == null) {
      this.util.error('All fields are required');
      return false;
    }

    if (this.cover == '' || this.cover == null) {
      this.util.error('Cover Image is missing');
      return false;
    }

    console.log(typeof this.country_code)
    const cc: string = (this.country_code).toString();
    if (!cc.includes('+')) {
      this.country_code = '+' + this.country_code
    };

    const param = {
      first_name: this.fname,
      last_name: this.lname,
      cover: this.cover,
      lat: this.lat,
      lng: this.lng,
      gender: this.gender,
      id: this.id
    };

    this.util.show();
    this.api.post_private('v1/drivers/update', param).then((data: any) => {
      this.util.hide();
      console.log(data);
      if (data.status == 500) {
        this.util.error(data.message);
      }
      if (data && data.status && data.status == 200) {
        this.myModal2.hide();
        this.getAllUsers();
      } else if (data && data.error && data.error.msg) {
        this.util.error(data.error.msg);
      } else if (data && data.error && data.error.message == 'Validation Error.') {
        for (let key in data.error[0]) {
          console.log(data.error[0][key][0]);
          this.util.error(data.error[0][key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    }, error => {
      console.log(error);
      this.util.hide();
      if (error && error.error && error.error.status == 500 && error.error.message) {
        this.util.error(error.error.message);
      } else if (error && error.error && error.error.error && error.error.status == 422) {
        for (let key in error.error.error) {
          console.log(error.error.error[key][0]);
          this.util.error(error.error.error[key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    }).catch(error => {
      console.log(error);
      this.util.hide();
      if (error && error.error && error.error.status == 500 && error.error.message) {
        this.util.error(error.error.message);
      } else if (error && error.error && error.error.error && error.error.status == 422) {
        for (let key in error.error.error) {
          console.log(error.error.error[key][0]);
          this.util.error(error.error.error[key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    });
  }

  saveChanges() {
    this.submited = true;

    if (this.fname == '' || this.fname == null || this.lname == '' || this.lname == null || this.email == '' || this.email == null ||
      this.password == '' || this.password == null || this.country_code == '' || this.country_code == null || this.phone == '' || this.phone == null ||
      this.lat == null || this.lat == '' || this.lng == '' || this.lng == null) {
      this.util.error('All fields are required');
      return false;
    }
    const regex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
    if (!regex.test(this.email)) {
      this.util.error(this.util.translate('Please enter valid Email ID'));
      return false;
    }
    if (this.cover == '' || this.cover == null) {
      this.util.error('Cover Image is missing');
      return false;
    }

    console.log(typeof this.country_code)
    const cc: string = (this.country_code).toString();
    if (!cc.includes('+')) {
      this.country_code = '+' + this.country_code
    };

    const param = {
      email: this.email,
      first_name: this.fname,
      last_name: this.lname,
      mobile: this.phone,
      cover: this.cover,
      country_code: this.country_code,
      password: this.password,
      lat: this.lat,
      lng: this.lng,
      gender: this.gender
    };

    this.util.show();
    this.api.post_private('v1/drivers/create', param).then((data: any) => {
      this.util.hide();
      console.log(data);
      if (data.status == 500) {
        this.util.error(data.message);
      }
      if (data && data.status && data.status == 200 && data.data && data.data.id) {
        this.myModal2.hide();
        this.getAllUsers();
      } else if (data && data.error && data.error.msg) {
        this.util.error(data.error.msg);
      } else if (data && data.error && data.error.message == 'Validation Error.') {
        for (let key in data.error[0]) {
          console.log(data.error[0][key][0]);
          this.util.error(data.error[0][key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    }, error => {
      console.log(error);
      this.util.hide();
      if (error && error.error && error.error.status == 500 && error.error.message) {
        this.util.error(error.error.message);
      } else if (error && error.error && error.error.error && error.error.status == 422) {
        for (let key in error.error.error) {
          console.log(error.error.error[key][0]);
          this.util.error(error.error.error[key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    }).catch(error => {
      console.log(error);
      this.util.hide();
      if (error && error.error && error.error.status == 500 && error.error.message) {
        this.util.error(error.error.message);
      } else if (error && error.error && error.error.error && error.error.status == 422) {
        for (let key in error.error.error) {
          console.log(error.error.error[key][0]);
          this.util.error(error.error.error[key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    });
  }
}
