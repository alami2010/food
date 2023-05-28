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
@Component({
  selector: 'app-foods',
  templateUrl: './foods.component.html',
  styleUrls: ['./foods.component.scss']
})
export class FoodsComponent implements OnInit {
  @ViewChild('myModal') public myModal: ModalDirective;
  @ViewChild('myModal2') public myModal2: ModalDirective;
  @ViewChild('myModal3') public myModal3: ModalDirective;

  list: any[] = [];
  dummy: any[] = [];
  page: number = 1;

  cate_id: any = '';

  categories: any[] = [];
  cate_kind: any = '';
  kindInfo = [
    '',
    this.util.translate('Breakfast'),
    this.util.translate('Lunch'),
    this.util.translate('Dinner'),
    this.util.translate('None')
  ];

  action: any = 'create';

  realID: any = '';
  from_cate: any = '';
  recommended: boolean = false;
  variations: any[] = [];
  size: any = 0;
  haveVariations: boolean = false;

  cover: any = '';
  name: any = '';
  details: any = '';
  price: any = '';
  discount: any = '';
  veg: any = '';

  kind: any = '';
  id: any = '';


  what: any = '';
  why: any = '';
  newMainItem: boolean;

  variation_title: any = '';
  variations_price: any = '';

  subNewItem: boolean;
  variation_type: any = 'radio';

  mainVariationIndex: any = '';
  subVariationIndex: any = '';
  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.newMainItem = false;
    this.subNewItem = false;

    this.getFoodList();
  }
  getFoodList() {
    this.categories = [];
    this.list = [];
    this.dummy = Array(10);
    this.api.post_private('v1/storeWeb/getFoodList', { id: localStorage.getItem('storeId') }).then((data: any) => {
      console.log(data);
      this.dummy = [];
      if (data && data.status && data.status == 200) {
        this.list = data.response;
        data.data.forEach((element: any) => {
          const info = {
            id: element.id,
            name: element.name,
            from: 'master'
          };
          this.categories.push(info);
        });
        data.stores.forEach((element: any) => {
          const info = {
            id: element.id + '_store',
            name: element.name,
            from: 'store'
          };
          this.categories.push(info);
        });
      }
      console.log('cates', this.categories);

      if (this.categories && this.categories.length) {
        this.cate_id = this.categories[0].id;
        this.cateChange();
      }
    }, error => {
      this.dummy = [];
      console.log(error);
      this.util.apiErrorHandler(error);
    }).catch((error) => {
      console.log(error);
      this.dummy = [];
      this.util.apiErrorHandler(error);
    });
  }
  ngOnInit(): void {
  }

  search(str: any) {

  }

  addNew() {
    this.action = 'create';
    this.myModal2.show();
  }

  filter() {

  }

  clearFilter() {

  }

  exportCSV() {

  }

  updateStatus(item: any) {
    item.status = item.status == 1 ? 0 : 1;
    this.api.post_private('v1/foods/updateStatus', item).then((data: any) => {
      console.log(data);
    }, error => {
      console.log(error);
      this.util.apiErrorHandler(error);
      item.status = item.status == 1 ? 0 : 1;
    }).catch(error => {
      console.log(error);
      item.status = item.status == 1 ? 0 : 1;
      this.util.apiErrorHandler(error);
    });
  }

  updateInfo(itemId: any) {
    this.id = itemId;
    this.action = 'update';
    const param = {
      id: this.id
    };
    this.util.show();
    this.api.post_private('v1/foods/getProductInfo', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200 && data.data) {
        const info = data.data;
        this.name = info.name;
        this.cover = info.cover;
        this.details = info.details;
        this.price = info.price;
        this.discount = info.discount;
        this.veg = info.veg;
        this.size = info.size;
        this.recommended = info.recommended == 1 ? true : false;
        this.from_cate = info.from_cate;
        if (this.from_cate == 0) { // master
          this.cate_id = info.cate_id;
          this.realID = info.cate_id;
        } else { // store
          this.cate_id = (info.cate_id + '_store').toString();
          this.realID = info.cate_id;
        }
        console.log('cate id,real id', this.cate_id, this.realID);
        if (info && info.variations && info.variations !== '') {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.variations)) {
            this.variations = JSON.parse(info.variations);
            this.haveVariations = true;
          } else {
            this.haveVariations = false;
          }
        }
      }
      this.myModal2.show();
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

  updateStock(item: any) {
    item.outofstock = item.outofstock == 1 ? 0 : 1;
    this.api.post_private('v1/foods/updateStock', item).then((data: any) => {
      console.log(data);
    }, error => {
      console.log(error);
      this.util.apiErrorHandler(error);
      item.outofstock = item.outofstock == 1 ? 0 : 1;
    }).catch(error => {
      console.log(error);
      item.outofstock = item.outofstock == 1 ? 0 : 1;
      this.util.apiErrorHandler(error);
    });
  }

  updateTag(item: any) {
    console.log(item);
    item.recommended = item.recommended == 1 ? 0 : 1;
    this.api.post_private('v1/foods/updateRecommended', item).then((data: any) => {
      console.log(data);
    }, error => {
      console.log(error);
      item.recommended = item.recommended == 1 ? 0 : 1;
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      item.recommended = item.recommended == 1 ? 0 : 1;
      this.util.apiErrorHandler(error);
    });
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


  cateChange() {
    console.log(this.cate_id);
    const id = this.categories.filter(x => x.id == this.cate_id);
    console.log(id);
    if (id && id.length && id[0].from == 'master') {
      console.log('ready', id[0].id);
      this.from_cate = 0;
      this.realID = id[0].id;
    } else {
      console.log('remove extra name');
      try {
        const idReal = id[0].id.split('_store');
        console.log('id', idReal, idReal[0]);
        this.from_cate = 1;
        this.realID = idReal[0];
      } catch (error) {
        console.log(error);
      }
    }
  }


  changeIt() {
    if (!this.haveVariations) {
      this.variations = [];
    }
  }

  changeSize(event: any) {
    console.log('change size');
    console.log(event, this.size);
    if (event == true) {
      const items = this.variations.filter(x => x.isSize == true);

      console.log('length', items);
      if (!items.length) {
        const item = {
          isSize: true,
          title: 'size',
          type: 'radio',
          items: []
        };
        this.variations.push(item);
        console.log(this.variations);
        this.size = 1;
      }
    } else {
      this.variations = this.variations.filter(x => x.isSize !== true);
      this.size = 0;
    }
    console.log('after', this.variations);
  }

  deleteSub(index: any, item: any) {
    console.log('delete sub');
    console.log(index);
    console.log(item);
    const selected = this.variations[index].items;
    console.log('selected', selected);
    const data = selected.filter((x: any) => x.title !== item.title);
    console.log(data);
    this.variations[index].items = data;
    console.log('done', this.variations);
  }


  async openVarations() {
    console.log('open variations');
    this.what = 'main';
    this.why = 'addNew';
    this.newMainItem = true;
    this.myModal.show();
  }

  async editTitle(index: any) {
    console.log('edit title');
    this.mainVariationIndex = index;
    this.what = 'main';
    this.why = 'editTitle';
    this.newMainItem = this.variations[index].isSize == true ? false : true;
    this.variation_title = this.variations[index].title;
    this.variation_type = this.variations[index].type
    this.myModal.show();

  }

  async addItem(index: any) {
    console.log('add new item');
    this.mainVariationIndex = index;
    this.what = 'sub';
    this.why = 'addNew';
    this.subNewItem = true;
    this.myModal.show();
  }

  deleteItem(item: any) {
    console.log('delete item');
    console.log(item);
    if (item.title == 'size') {
      this.size = 0;
    }

    this.variations = this.variations.filter(x => x.title !== item.title);
  }

  async editSub(index: any, items: any, subIndex: any) {
    console.log('edit sub');
    this.mainVariationIndex = index;
    this.subVariationIndex = subIndex;
    this.variation_title = items.title;
    this.variations_price = items.price;
    this.what = 'sub';
    this.why = 'editItem';
    this.subNewItem = false;
    this.myModal.show();
  }


  onVariationsSave() {
    console.log('variations save', this.variations);
    console.log('index', this.mainVariationIndex);
    if (this.what == 'main' && this.newMainItem == true) {
      if (this.variation_title == '') {
        this.util.error('All fields are required');
        return false;
      }
      this.myModal3.show();
      // this.presentAlertRadio(this.variation_title);
      return false;
    }

    if (this.what == 'main' && this.newMainItem == false) {
      if (this.variation_title == '') {
        this.util.error('All fields are required');
        return false;
      }
      console.log('size item chhe title change karvaa aayu chhe');
      // const updateItem = {
      //   title: this.variation_title,
      //   newMainItem: this.newMainItem
      // }
      this.variations[this.mainVariationIndex].title = this.variation_title;
      this.myModal3.hide();
      this.myModal.hide();
      this.cleanVariations();
      // this.modalController.dismiss(updateItem, 'true');
      return false;
    }

    if (this.what == 'sub' && this.subNewItem == true) {
      if (this.variation_title == '' ||   isNaN(this.variations_price) ) {
        this.util.error('All fields are required');
        return false;
      }
      console.log('adding new sub item');
      const data = {
        title: this.variation_title,
        price: this.variations_price
      }
      this.variations[this.mainVariationIndex].items.push(data);
      this.myModal3.hide();
      this.myModal.hide();
      this.cleanVariations();
      // this.modalController.dismiss({ title: this.variation_title, price: this.variations_price }, 'true');
      return false;
    }

    if (this.what == 'sub' && this.subNewItem == false) {
      if (this.variation_title == '' ||isNaN(this.variations_price)) {
        this.util.error('All fields are required');
        return false;
      }
      this.variations[this.mainVariationIndex].items[this.subVariationIndex].title = this.variation_title;
      this.variations[this.mainVariationIndex].items[this.subVariationIndex].price = this.variations_price;
      this.myModal3.hide();
      this.myModal.hide();
      this.cleanVariations();
      // this.modalController.dismiss({ title: this.variation_title, price: this.variations_price }, 'true');
      return false;

    }

    console.log('check if exe');

  }

  cleanStates() {
    this.name = '';
    this.cover = '';
    this.details = '';
    this.price = '';
    this.discount = '';
    this.veg = '';
    this.size = 0;
    this.recommended = false;
    this.from_cate = '';
    this.haveVariations = false;
    this.variations = [];
  }

  cleanVariations() {
    this.variation_type = 'radio';
    this.variation_title = '';
    this.variations_price = '';
    this.mainVariationIndex = '';
    this.subVariationIndex = '';
  }

  saveType() {
    if (this.what == 'main' && this.newMainItem == true && this.why == 'addNew') {
      const data = {
        title: this.variation_title,
        type: this.variation_type,
        items: [],
        isSize: false
      }

      const item = this.variations.filter(x => x.title == data.title);
      if (item && item.length > 0) {
        this.util.error(this.util.translate('Duplicate'));
      } else {
        this.variations.push(data);
      }
      this.myModal3.hide();
      this.myModal.hide();
      this.cleanVariations();
      // this.modalController.dismiss(item, 'true');
    }

    if (this.what == 'main' && this.newMainItem == true && this.why == 'editTitle') {
      const data = {
        title: this.variation_title,
        type: this.variation_type,
        newMainItem: this.newMainItem
      }

      const item = this.variations.filter(x => x.title == data.title);
      if (item && item.length > 0) {
        this.util.error(this.util.translate('Duplicate'));
      } else {
        console.log('edit item');
        if (this.newMainItem == true) {
          this.variations[this.mainVariationIndex].title = data.title;
          this.variations[this.mainVariationIndex].type = data.type;
        }

        if (this.newMainItem != true) {
          this.variations[this.mainVariationIndex].title = data.title;
        }

        this.myModal3.hide();
        this.myModal.hide();
        this.cleanVariations();

      }

      // this.modalController.dismiss(updateItem, 'true');
    }
  }



  saveProduct() {
    console.log(this.variations);

    console.log('1', this.name);
    console.log('2', this.variations);
    console.log('3', this.from_cate);
    console.log('4', this.cate_id);
    console.log('5', this.recommended);
    console.log('6', this.cover);
    console.log('7', this.details);
    console.log('8', this.price);
    console.log('9', this.discount);
    console.log('10', this.veg);
    console.log('11', this.size);
    if (this.name == '' || !this.name || this.cover == '' || !this.cover || this.details == '' || !this.details || this.price == '' || !this.price) {
      this.util.error('All fields are required');
      return false;
    }

    const param = {
      store_id: localStorage.getItem('storeId'),
      from_cate: this.from_cate,
      outofstock: 2,
      recommended: this.recommended == true ? 1 : 0,
      cate_id: this.realID,
      cover: this.cover,
      name: this.name,
      details: this.details,
      price: this.price,
      discount: this.discount != '' ? this.discount : 0,
      rating: 0,
      veg: this.veg,
      variations: JSON.stringify(this.variations),
      size: this.size,
      status: 1
    }
    console.log(param);
    this.util.show();
    this.api.post_private('v1/foods/save', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200 && data.data) {
        Swal.fire(
          this.util.translate('Product added'),
          this.util.translate('Your file has been saved.'),
          this.util.translate('success')
        )
        this.myModal2.hide();
        this.cleanStates();
        this.getFoodList();
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

  updateProduct() {
    console.log(this.variations);

    console.log('1', this.name);
    console.log('2', this.variations);
    console.log('3', this.from_cate);
    console.log('4', this.cate_id);
    console.log('5', this.recommended);
    console.log('6', this.cover);
    console.log('7', this.details);
    console.log('8', this.price);
    console.log('9', this.discount);
    console.log('10', this.veg);
    console.log('11', this.size);
    if (this.name == '' || !this.name || this.cover == '' || !this.cover || this.details == '' || !this.details || this.price == '' || !this.price) {
      this.util.error('All fields are required');
      return false;
    }

    const param = {
      store_id: localStorage.getItem('storeId'),
      from_cate: this.from_cate,
      outofstock: 2,
      recommended: this.recommended == true ? 1 : 0,
      cate_id: this.realID,
      cover: this.cover,
      name: this.name,
      details: this.details,
      price: this.price,
      discount: this.discount != '' ? this.discount : 0,
      rating: 0,
      veg: this.veg,
      variations: JSON.stringify(this.variations),
      size: this.size,
      id: this.id
    }
    console.log(param);
    this.util.show();
    this.api.post_private('v1/foods/update', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200 && data.data) {
        Swal.fire(
          this.util.translate('Product updated'),
          this.util.translate('Your file has been updated.'),
          this.util.translate('success')
        )
        this.myModal2.hide();
        this.cleanStates();
        this.getFoodList();
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
