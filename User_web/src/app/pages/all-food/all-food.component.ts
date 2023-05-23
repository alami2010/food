/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ChangeDetectorRef, Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ModalDirective } from 'angular-bootstrap-md';
import * as moment from 'moment';
import { ApiService } from 'src/app/services/api.service';
import { CartService } from 'src/app/services/cart.service';
import { UtilService } from 'src/app/services/util.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-all-food',
  templateUrl: './all-food.component.html',
  styleUrls: ['./all-food.component.scss']
})
export class AllFoodComponent implements OnInit {
  @ViewChild('variantModal') public variantModal: ModalDirective;

  id: any = '';
  apiCalled: boolean = false;

  tab: any = 1;
  name: any;
  descritions: any;
  cover: any = '';
  address: any;
  Rating: any;
  time: any;
  totalRating: any;
  dishPrice: any;
  cusine: any[] = [];
  foods: any[] = [];
  dummyFoods: any[] = [];
  categories: any[] = [];
  dummy = Array(5);
  dumyCates: any[] = Array(10);
  veg: boolean;
  deliveryAddress: any = '';

  restDetail;
  caetId: any;

  productName: any = '';
  desc: any = '';
  total: any = 0;
  lists: any;
  carts: any[] = [];
  userCart: any[] = [];

  sameProduct: boolean = false;
  removeProduct: boolean = false;

  radioSelected: any;
  haveSize: boolean;


  newItem: boolean = false;

  sameCart: any[] = [];
  images: any[] = [];
  variantIndex: any = '';

  viewAcc = false;
  activeTab = 'home';
  uid: any;
  open: any;
  close: any;
  contactNo: any;
  reviews: any[] = [];
  haveData: boolean = false;
  haveReview: boolean = false;
  havePhotos: boolean = false;

  isNewVariantions = false;
  variations: any[] = [];
  olderVariations: any[] = [];
  productIndex: any = 0;
  categoryIndex: any = 0;

  minOrder: any = 0;
  constructor(
    private router: Router,
    public util: UtilService,
    public api: ApiService,
    private navParam: ActivatedRoute,
    public chMod: ChangeDetectorRef,
    private route: ActivatedRoute,
    public cart: CartService
  ) {
    console.log('-/', this.route.snapshot.paramMap.get('id'))
    if (this.route.snapshot.paramMap.get('id')) {
      this.id = this.route.snapshot.paramMap.get('id');
      this.getVenueDetails();
    }
  }

  getVenueDetails() {
    this.api.post('v1/user/getStoreProductsById', { id: this.id }).then((data: any) => {
      console.log(data);

      this.apiCalled = true;
      this.dummy = [];
      this.dumyCates = [];
      if (data && data.status && data.status == 200 && data.data) {
        if (data.data.length) {
          this.haveData = true;
        }
        this.cart.storeInfo = data.store;
        this.name = data.store.name;
        this.descritions = data.store.short_descriptions;
        this.cover = data.store.cover;
        this.minOrder = data.store.min_order_price;
        this.address = data.store.address;
        this.Rating = data.store.ratings ? data.store.ratings : 0;
        this.totalRating = data.store.total_ratings ? data.store.total_ratings : 0;
        this.dishPrice = data.store.cost_for_two;
        this.contactNo = data.store.mobile;
        this.categories = data.data;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(data.store.images)) {
          var images = JSON.parse(data.store.images);
          console.log(images);
          if (images && images.length > 0) {
            this.havePhotos = true;
            this.images = images.filter(x => x != '');
          } else {
            this.havePhotos = false;
          }
        } else {
          this.havePhotos = false;
        }
        this.categories.forEach((element: any) => {
          element.products.forEach((products: any) => {
            if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(products.variations)) {
              if (this.cart.itemId.includes(products.id)) {
                const index = this.cart.cart.filter(x => x.id == products.id);
                if (index && index.length) {
                  products['quantity'] = index[0].quantity;
                  products['savedVariationsList'] = [];
                } else {
                  products['quantity'] = 0;
                  products['savedVariationsList'] = [];
                }
              } else {
                products['quantity'] = 0;
                products['savedVariationsList'] = [];
              }

              products.variations = JSON.parse(products.variations);
              if (products.variations && products.variations.length) {
                products.variations.forEach((item: any) => {
                  item.items.forEach((itemInside: any) => {
                    itemInside['isChecked'] = false;
                  });
                });
              }
            } else {
              products.variations = [];
              if (this.cart.itemId.includes(products.id)) {
                const index = this.cart.cart.filter(x => x.id == products.id);
                console.log(index);
                if (index && index.length) {
                  products['quantity'] = index[0].quantity;
                  products['savedVariationsList'] = [];
                } else {
                  products['quantity'] = 0;
                  products['savedVariationsList'] = [];
                }
              } else {
                products['quantity'] = 0;
                products['savedVariationsList'] = [];
              }
            }
          });
        });
        if (this.categories.length > 0) {
          this.caetId = this.categories[0].cate_id;
        }
        console.log(this.categories);
        this.getReviews();
      }

    }, error => {
      this.apiCalled = true;
      console.log('Error', error);
      this.haveData = false;
      this.dumyCates = [];
      this.dummy = [];
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.apiCalled = true;
      console.log('Err', error);
      this.haveData = false;
      this.dumyCates = [];
      this.dummy = [];
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  ngOnInit(): void { }

  goToFoodDetail() {
    this.router.navigate(['/food-detail']);
  }

  getReviews() {
    const param = {
      id: this.id,
    };
    this.api.post('v1/get_store/getStoreReviews', param).then((data: any) => {
      console.log(data);
      if (data && data.status == 200 && data.data && data.data.length) {
        this.haveReview = true;
        this.reviews = data.data;
      } else {
        this.haveReview = false;
      }
    }, error => {
      console.log(error);
      this.haveReview = false;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  getDate(date) {
    return moment(date).format('lll');
  }

  goToPayment() {
    this.router.navigate(['/payment']);
  }

  getQuantity(cateIndex: any, subIndex: any) {
    // return this.categories[cateIndex].products[subIndex].quantity;
    if (this.categories[cateIndex].products[subIndex].size == 0) {
      let cartIndex: any = this.cart.cart.filter((x: any) => x.id == this.categories[cateIndex].products[subIndex].id);
      // console.log(cartIndex);
      if (cartIndex.length > 0) {
        return cartIndex[0].quantity;
      } else {
        return 1;
      }
    } else {
      let cartIndex: any = this.cart.cart.filter((x: any) => x.id == this.categories[cateIndex].products[subIndex].id);
      let totalQuantity = 0;
      cartIndex.forEach((element: any) => {
        totalQuantity = totalQuantity + element.savedVariationsList[0].quantity;
      });
      return totalQuantity;
    }
    // return 1;
  }

  onOpenVariations(index: any, subIndex: any) {
    this.variations = [];
    this.isNewVariantions = false;
    this.categoryIndex = index;
    this.productIndex = subIndex;
    if (this.cart.itemId.includes(this.categories[index].products[subIndex].id)) {
      this.isNewVariantions = false;
      const savedVariationsList = this.cart.cart.filter(x => x.id == this.categories[index].products[subIndex].id);
      console.log(savedVariationsList);
      this.olderVariations = [];
      this.olderVariations = savedVariationsList;
      console.log(this.olderVariations);
    } else {
      this.isNewVariantions = true;
      this.variations = this.categories[index].products[subIndex].variations;
    }
    console.log(this.variations);
    this.variantModal.show();
  }

  updateVariationsItem(index: any, type: any, quantity: any) {
    console.log(quantity);
    if (type == 'remove') {
      if (quantity > 0) {
        this.olderVariations[index].savedVariationsList.forEach((element: any) => {
          element.quantity = element.quantity - 1;
        });
      }
    } else {
      this.olderVariations[index].savedVariationsList.forEach((element: any) => {
        element.quantity = element.quantity + 1;
      });
    }

  }

  updateVariations() {
    this.olderVariations.forEach(element => {
      element.savedVariationsList.forEach((sub: any) => {
        this.cart.updateVariationsIndex(element.id, sub.uuid, sub.quantity);
      });
    });
    this.isNewVariantions = false;
    this.olderVariations = [];
    this.variantModal.hide();
    this.checkQuantity();
  }

  addToCart(index: any, subIndex: any) {
    const uid = localStorage.getItem('uid');
    console.log('uid', localStorage.getItem('uid'));
    if (uid && uid != null && uid !== 'null') {
      if (this.cart.cart.length == 0) {
        if (this.categories[index].products[subIndex].size == 1 && this.categories[index].products[subIndex].variations && this.categories[index].products[subIndex].variations.length) {
          console.log('open model');
          console.log(this.categories[index].products[subIndex]);
          this.onOpenVariations(index, subIndex);
        } else {
          console.log('on simple cart');
          this.categories[index].products[subIndex].quantity = 1;
          this.cart.addItem(this.categories[index].products[subIndex]);
        }
      } else {
        console.log('cart is full');
        console.log(this.cart.cart);
        console.log(this.id);
        const restIds = this.cart.cart.filter(x => x.store_id == this.id);
        console.log(restIds);
        if (restIds && restIds.length > 0) {
          if (this.categories[index].products[subIndex].size == 1 && this.categories[index].products[subIndex].variations && this.categories[index].products[subIndex].variations.length) {
            console.log('open model');
            console.log(this.categories[index].products[subIndex]);
            this.onOpenVariations(index, subIndex);
          } else {
            console.log('on simple cart');
            this.categories[index].products[subIndex].quantity = 1;
            this.cart.addItem(this.categories[index].products[subIndex]);
          }
        } else {
          this.dummy = [];
          this.presentAlertConfirm();
        }
      }
    } else {
      this.util.onLoginPop();
    }
  }

  async presentAlertConfirm() {
    console.log('present alert to clear');
    Swal.fire({
      title: this.util.translate('Warning'),
      text: this.util.translate(`you already have item's in cart with different restaurant`),
      icon: 'error',
      showConfirmButton: true,
      showCancelButton: true,
      confirmButtonText: this.util.translate('Clear cart'),
      backdrop: false,
      background: 'white'
    }).then(status => {
      if (status && status.value) {
        console.log('clear');
        this.cart.clearCart();
      }
    });

  }

  checkQuantity() {
    this.categories.forEach((element: any) => {
      element.products.forEach((products: any) => {
        if (this.cart.itemId.includes(products.id)) {
          const index = this.cart.cart.filter(x => x.id == products.id);
          if (index && index.length) {
            products['quantity'] = index[0].quantity;
          } else {
            products['quantity'] = 0;
          }
        } else {
          products['quantity'] = 0;
        }
      })
    });
  }

  addNewVariatons() {
    this.isNewVariantions = true;
    this.categories[this.categoryIndex].products[this.productIndex].variations.forEach((element: any) => {
      element.items.forEach((sub: any) => {
        sub.isChecked = false;
      });
    });
    console.log(this.categories[this.categoryIndex].products[this.productIndex].variations);
    this.variations = this.categories[this.categoryIndex].products[this.productIndex].variations;
  }

  radioGroupChange(index: any, subIndex: any) {
    console.log(index, subIndex);
    console.log(this.variations);
    this.variations[index].items.forEach((element: any) => {
      element.isChecked = false;
    });
    this.variations[index].items[subIndex].isChecked = true;
  }

  checkedEvent(event: any, index: any, subIndex: any) {
    this.variations[index].items[subIndex].isChecked = event.target.checked;
  }

  saveVariations() {
    if (this.categories[this.categoryIndex].products[this.productIndex].size == 1) {
      var sizeItem = this.variations.filter((x: any) => x.title == 'size');
      if (sizeItem && sizeItem.length > 0) {
        var savedSize = sizeItem[0].items.filter((x: any) => x.isChecked == true);
        if (savedSize.length == 0) {
          this.util.errorMessage(this.util.translate('Please select size'));
          return false;
        }
      }
    }

    var product = this.categories[this.categoryIndex].products[this.productIndex];
    product.savedVariationsList = [];
    console.log(this.variations);
    this.variations.forEach((variations: any) => {
      variations.items.forEach((items: any) => {
        if (items.isChecked == true) {
          var param = {
            "title": items.title.toString(),
            "price": items.price,
            "type": variations.type,
            "quantity": 1,
            "uuid": this.getUniqueId(4)
          };
          product.savedVariationsList.push(param);

        }
      });
    });
    console.log(product);
    product.quantity = 1;
    this.cart.addItem(product);
    this.variantModal.hide();
    this.reload();
  }

  reload() {
    this.router.routeReuseStrategy.shouldReuseRoute = () => false;
    this.router.onSameUrlNavigation = 'reload';
    this.router.navigate(['./'], { relativeTo: this.route });
  }

  getUniqueId(parts: number): string {
    const stringArr: any[] = [];
    for (let i = 0; i < parts; i++) {
      const S4 = (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
      stringArr.push(S4);
    }
    return stringArr.join('-');
  }

  updateQuantity(index: any, subIndex: any, type: any) {
    this.categoryIndex = index;
    this.productIndex = subIndex;
    if (this.categories[index].products[subIndex].size == 1 && this.categories[index].products[subIndex].variations && this.categories[index].products[subIndex].variations.length) {
      console.log('open model');
      this.onOpenVariations(index, subIndex);
    } else if (type == 'remove') {
      // remove quntiy

      if (this.categories[this.categoryIndex].products[this.productIndex].quantity !== 0) {
        this.categories[this.categoryIndex].products[this.productIndex].quantity = this.categories[this.categoryIndex].products[this.productIndex].quantity - 1;
        if (this.categories[this.categoryIndex].products[this.productIndex].quantity == 0) {
          this.categories[this.categoryIndex].products[this.productIndex].quantity = 0;
          this.cart.removeItem(this.categories[this.categoryIndex].products[this.productIndex].id);
        } else {
          this.cart.addQuantity(this.categories[this.categoryIndex].products[this.productIndex].quantity, this.categories[this.categoryIndex].products[this.productIndex].id);
        }
        this.chMod.detectChanges();

      } else {
        this.categories[this.categoryIndex].products[this.productIndex].quantity = 0;
        this.cart.removeItem(this.categories[this.categoryIndex].products[this.productIndex].id);
        this.chMod.detectChanges();
      }
    } else {
      // add new quntiy
      this.categories[this.categoryIndex].products[this.productIndex].quantity = this.categories[this.categoryIndex].products[this.productIndex].quantity + 1;
      this.cart.addQuantity(this.categories[this.categoryIndex].products[this.productIndex].quantity, this.categories[this.categoryIndex].products[this.productIndex].id);
      this.chMod.detectChanges();
    }

  }

  removeVariations(index: any) {
    if (this.cart.cart[index].size == 1 && this.cart.cart[index].savedVariationsList.length > 0) {
      console.log('remove combined item');
      this.cart.cart[index].savedVariationsList.forEach((sub: any) => {
        sub.quantity = sub.quantity - 1;
        this.cart.updateVariationsIndex(this.cart.cart[index].id, sub.uuid, sub.quantity);
      });
    } else {
      console.log('remove solo item');
      this.cart.cart[index].quantity = this.cart.cart[index].quantity - 1;
      this.cart.addQuantity(this.cart.cart[index].quantity, this.cart.cart[index].id);
    }
    this.chMod.detectChanges();
  }

  addVariations(index: any) {
    if (this.cart.cart[index].size == 1 && this.cart.cart[index].savedVariationsList.length > 0) {
      this.cart.cart[index].savedVariationsList.forEach((sub: any) => {
        sub.quantity = sub.quantity + 1;
        this.cart.updateVariationsIndex(this.cart.cart[index].id, sub.uuid, sub.quantity);
      });
    } else {
      this.cart.cart[index].quantity = this.cart.cart[index].quantity + 1;
      this.cart.addQuantity(this.cart.cart[index].quantity, this.cart.cart[index].id);
    }
    this.chMod.detectChanges();
  }

  openCart() {
    if (this.cart.total < this.minOrder) {
      let text;
      if (this.util.cside == 'left') {
        text = this.util.currecny + ' ' + this.minOrder;
      } else {
        text = this.minOrder + ' ' + this.util.currecny;
      }
      Swal.fire({
        title: this.util.translate('Error'),
        text: this.util.translate('Minimum order amount must be ') + text + this.util.translate(' or more'),
        icon: 'error',
        showConfirmButton: true,
        confirmButtonText: this.util.translate('OK'),
        backdrop: false,
        background: 'white'
      }).then(status => {
        if (status && status.value) {

        }
      });

      return false;
    }
    this.router.navigate(['cart']);
  }
}
