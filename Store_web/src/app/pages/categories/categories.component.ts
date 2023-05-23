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
import Swal from 'sweetalert2';
import { ModalDirective } from 'ngx-bootstrap/modal';
@Component({
  selector: 'app-categories',
  templateUrl: './categories.component.html',
  styleUrls: ['./categories.component.scss']
})
export class CategoriesComponent implements OnInit {
  @ViewChild('myModal', { static: false }) public myModal: ModalDirective;
  @ViewChild('myModal2', { static: false }) public myModal2: ModalDirective;

  action = 'create';

  dummy = Array(10);
  dummyMaster: any[] = [];
  list: any[] = [];
  categories: any[] = [];
  dummyCat: any[] = [];
  name: any = '';
  status = '-1';
  cover: any = '';
  catID: any = '';
  kind: any = 4;
  page: number = 1;
  stores: any[] = [];
  dummyStore: any[] = [];
  cate_kind: any = 4;
  id: any = '';
  kindInfo = [
    '',
    this.util.translate('Breakfast'),
    this.util.translate('Lunch'),
    this.util.translate('Dinner'),
    this.util.translate('None')
  ];

  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.getList();
  }

  ngOnInit(): void {
  }

  getList() {
    this.dummy = Array(5);
    this.categories = [];
    this.stores = [];
    this.api.post_private('v1/categories/getList', { id: localStorage.getItem('storeId') }).then((data: any) => {
      console.log(data);
      this.dummy = [];
      if (data && data.status && data.status == 200) {
        this.categories = data.data;
        this.stores = data.stores;
        this.dummyCat = this.categories;
        this.dummyStore = this.stores;
      }
      console.log('cates', this.categories);
      console.log('stores', this.stores);
    }, error => {
      console.log(error);
      this.dummy = [];
      this.util.apiErrorHandler(error);
    }).catch((error) => {
      console.log(error);
      this.dummy = [];
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

  searchStore(str: any) {
    this.resetChangesStores();
    console.log('string', str);
    this.stores = this.filterItemsStores(str);
  }

  search(str: any) {
    this.resetChanges();
    console.log('string', str);
    this.categories = this.filterItems(str);
  }

  protected resetChangesStores = () => {
    this.stores = this.dummyStore;
  }


  protected resetChanges = () => {
    this.categories = this.dummyCat;
  }

  filterItemsStores(searchTerm: any) {
    return this.stores.filter((item) => {
      return item.name.toLowerCase().indexOf(searchTerm.toLowerCase()) > -1;
    });
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

  async onChange(item: any, index: any) {
    console.log(item, index);
    Swal.fire({
      title: this.util.translate('Confirm!'),
      text: this.util.translate("After confirming it, this category will disappear from your outlet. later you can activate it by adding it again."),
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, deactivate it!'
    }).then((result) => {
      if (result.isConfirmed) {
        const rest = this.categories.filter(x => x.id != item.id);
        console.log(rest);
        const ids = rest.map(x => x.id);
        console.log('Confirm Okay', ids);
        this.saveId(ids.join());
      }
    })
  }

  async deleteConfirmMaster() {

    Swal.fire({
      title: this.util.translate('Confirm!'),
      text: this.util.translate("Yes Delet it"),
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
      if (result.isConfirmed) {
        console.log('delete code');
      }
    });
  }

  async removeMaster() {
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate("After confirming it, this category and food items associated with this category will be completely deleted from your outlet"),
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes'
    }).then((result) => {
      if (result.isConfirmed) {
        this.util.show();
        setTimeout(() => {
          this.util.hide();
          this.deleteConfirmMaster();
        }, 3000);
      }
    });

  }

  saveId(ids: any) {
    console.log(ids);
    const param = {
      id: localStorage.getItem('storeId'),
      master_categories: ids
    }
    this.util.show();
    this.api.post_private('v1/categories/updateCategories', param).then((data: any) => {
      this.util.hide();
      console.log(data);
      if (data && data.status && data.status == 200 && data.data) {
        Swal.fire(
          'Updated!',
          'Your file has been updated.',
          'success'
        )
        this.getList();
      }
    }, error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    }).catch((error) => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
  }

  getActive() {
    this.dummyMaster = Array(10);
    this.list = [];
    this.api.get_private('v1/categories/get').then((data: any) => {
      console.log(data);
      this.dummyMaster = [];
      if (data && data.status && data.status == 200 && data.data) {
        const ids = this.categories.map(x => x.id);
        console.log(ids);
        data.data.forEach((element: any) => {
          element['active'] = ids.includes(element.id);
        });
        this.list = data.data;
      }
      console.log(this.list);
    }, error => {
      console.log(error);
      this.dummyMaster = [];
      this.util.apiErrorHandler(error);
    }).catch((error) => {
      console.log(error);
      this.dummyMaster = [];
      this.util.apiErrorHandler(error);
    });
  }

  addMaster() {
    this.getActive();
    this.myModal.show();
  }

  saveChanges() {
    this.myModal.hide();
    const items = this.list.filter(x => x.active == true);
    const selected = items.map(x => x.id);
    console.log(selected);
    if (selected && selected.length) {
      this.saveId(selected.join());
    }
  }


  addStore() {
    this.myModal2.show();
  }


  updateCategory() {
    if (!this.name || this.name === '' || !this.cover || this.cover === '') {
      this.util.error(this.util.translate('All fields are required'));
      return false;
    }
    //
    const param = {
      name: this.name,
      cover: this.cover,
      kind: this.cate_kind,
      id: this.id
    };
    this.util.show();
    this.api.post_private('v1/storeCates/updateInfo', param).then((data: any) => {
      this.util.hide();
      this.myModal2.hide();
      console.log(data);
      if (data && data.status && data.status == 200 && data.data) {
        Swal.fire(
          'Updated!',
          'Your file has been updated.',
          'success'
        )
        this.getList();
      }
    }, err => {
      this.util.hide();
      console.log('Error', err);
      this.util.apiErrorHandler(err);
    }).catch(e => {
      this.util.hide();
      console.log('Err', e);
      this.util.apiErrorHandler(e);
    });
  }

  createCategory() {

    if (!this.name || this.name === '' || !this.cover || this.cover === '') {
      this.util.error(this.util.translate('All fields are required'));
      return false;
    }
    const param = {
      store_id: localStorage.getItem('storeId'),
      name: this.name,
      cover: this.cover,
      kind: this.cate_kind,
      status: 1
    };
    this.util.show();
    this.api.post_private('v1/storeCates/create', param).then((data: any) => {
      this.util.hide();
      this.myModal2.hide();
      console.log(data);
      if (data && data.status && data.status == 200 && data.data) {
        Swal.fire(
          'Added!',
          'Your file has been added.',
          'success'
        )
        this.getList();
      }
    }, err => {
      this.util.hide();
      console.log('Error', err);
      this.util.apiErrorHandler(err);
    }).catch(e => {
      this.util.hide();
      console.log('Err', e);
      this.util.apiErrorHandler(e);
    });
  }

  remove(item: any) {
    console.log(item);
  }

  async updateStoreCategories(item: any) {
    console.log(item);
    this.id = item;
    this.util.show();
    this.api.post_private('v1/storeCates/getById', { id: item }).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200 && data.data) {
        const info = data.data;
        this.name = info.name;
        this.cover = info.cover;
        this.cate_kind = info.kind;
        this.action = 'update';
        this.myModal2.show();
      }
    }, err => {
      this.util.hide();
      console.log('Error', err);
      this.util.apiErrorHandler(err);
    }).catch(e => {
      this.util.hide();
      console.log('Err', e);
      this.util.apiErrorHandler(e);
    });
  }


  async onStoreCateChange(item: any) {
    console.log(item);
    Swal.fire({
      title: 'Confirm!',
      text: "After confirming it, this category will disappear from your outlet. later you can activate it again.",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes'
    }).then((result) => {
      if (result.isConfirmed) {
        const status = item.status == 1 ? 0 : 1;
        const param = {
          id: item.id,
          status: status
        }
        this.util.show();
        this.api.post_private('v1/storeCates/updateStatus', param).then((data: any) => {
          this.util.hide();
          console.log(data);
          if (data && data.status && data.status == 200 && data.data) {
            Swal.fire(
              'Updated!',
              'Your file has been updated.',
              'success'
            )
            this.getList();
          }
        }, error => {
          console.log(error);
          this.util.hide();
          this.util.apiErrorHandler(error);
        }).catch((error) => {
          console.log(error);
          this.util.hide();
          this.util.apiErrorHandler(error);
        });
      }
    });

  }
}
