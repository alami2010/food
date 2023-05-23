/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ModalDirective } from 'ngx-bootstrap/modal';
import { UtilService } from './../../services/util.service';
import { ApiService } from './../../services/api.service';
import { Component, OnInit, ViewChild } from '@angular/core';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-categories',
  templateUrl: './categories.component.html',
  styleUrls: ['./categories.component.scss']
})
export class CategoriesComponent implements OnInit {
  @ViewChild('myModal') public myModal: ModalDirective;

  action = 'create';

  dummy = Array(10);
  categories: any[] = [];
  dummyCat: any[] = [];
  name: any = '';
  status = '-1';
  cover: any = '';
  catID: any = '';
  kind: any = 4;
  page: number = 1;

  kindInfo = [
    '',
    this.util.translate('Breakfast'),
    this.util.translate('Lunch'),
    this.util.translate('Dinner'),
    this.util.translate('None')
  ]

  constructor(public api: ApiService, public util: UtilService) { }

  ngOnInit(): void {
    this.getAllCat();
  }

  getAllCat() {
    this.categories = [];
    this.dummy = Array(10);
    this.api.get_private('v1/categories/getAll').then((data: any) => {
      this.dummy = [];
      if (data && data.status && data.status === 200 && data.success) {
        console.log(">>>>>", data);
        if (data.data.length > 0) {
          this.categories = data.data;
          this.dummyCat = data.data;
          console.log("=========", this.categories);
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
        this.catID = val.id;
        const body = {
          id: this.catID,
          status: val.status === 0 ? 1 : 0
        };
        console.log("===========", body);
        this.util.show();
        this.api.post_private('v1/categories/update', body).then((data: any) => {
          this.util.hide();
          console.log("+++++++++++++++", data);
          if (data && data.status && data.status === 200 && data.success) {
            this.util.success(this.util.translate('Status Updated !'));
            this.getAllCat();
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
    this.catID = id;
    const body = {
      id: this.catID,
    };
    console.log("CAT BY ID => ", body);
    this.util.show();
    this.api.post_private('v1/categories/getById', body).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status === 200 && data.success) {
        this.name = data.data.name;
        this.status = data.data.status;
        this.cover = data.data.cover;
        this.kind = data.data.kind;
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

  createCategory() {

    if (this.name === '' || this.cover === '' || this.status === '-1' || this.name === null || this.cover === null || this.status === null) {
      this.util.error(this.util.translate('All Fields are required'));
    } else {

      const body = {
        name: this.name,
        cover: this.cover,
        status: this.status,
        kind: this.kind
      };
      this.util.show();
      this.api.post_private('v1/categories/create', body).then((data: any) => {
        console.log("+++++++++++++++", data);
        this.util.hide();
        if (data && data.status && data.status === 200 && data.success) {
          this.clearData();
          this.util.success(this.util.translate('Category added !'));
          this.getAllCat();
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


  updateCategory() {

    if (this.name === '' || this.cover === '' || this.status === '-1' || this.name === null || this.cover === null || this.status === null) {
      this.util.error(this.util.translate('All fields are required'));
    }
    else {

      const body = {
        id: this.catID,
        name: this.name,
        cover: this.cover,
        status: this.status,
        kind: this.kind
      };
      console.log("===========", body);
      this.util.show();
      this.api.post_private('v1/categories/update', body).then((data: any) => {
        console.log("+++++++++++++++", data);
        this.util.hide();
        if (data && data.status && data.status === 200 && data.success) {
          this.clearData();
          this.util.success(this.util.translate('Category Updated !'));
          this.action = 'create';
          this.getAllCat();
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

  search(str: any) {
    this.resetChanges();
    console.log('string', str);
    this.categories = this.filterItems(str);
  }

  protected resetChanges = () => {
    this.categories = this.dummyCat;
  }

  filterItems(searchTerm: any) {
    return this.categories.filter((item) => {
      return item.name.toLowerCase().indexOf(searchTerm.toLowerCase()) > -1;
    });
  }

  setFilteredItems() {
    console.log('clear');
    this.categories = [];
    this.categories = this.dummyCat;
  }

  pageChanged(eve: any) {
    console.log(">>>>>", eve);
  }

  deleteItem(item: any) {
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
        console.log(item);
        this.util.show();
        this.api.post_private('v1/categories/destroy', { id: item.id }).then((data: any) => {
          console.log(data);
          this.util.hide();
          if (data && data.status && data.status === 200) {
            this.getAllCat();
          }
        }).catch(error => {
          console.log(error);
          this.util.hide();
          this.util.apiErrorHandler(error);
        });
      }
    });

  }
}
