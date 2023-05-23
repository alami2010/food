/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Injectable } from '@angular/core';
import { ApiService } from './api.service';
import { UtilService } from './util.service';

@Injectable({
  providedIn: 'root'
})
export class CartService {
  public cart: any[] = [];
  public storeInfo: any;
  public storeData: any;
  public itemId: any[] = [];
  public coupon: any;

  public totalPrice: any = 0;
  public totalItemsInCart: any;
  public discount: any = 0;
  public total: any = 0;
  public deliveryCharge: any = 0.0;
  public grandTotal: any = 0.0;
  public deliveredAddress: any;

  public freeDeliveryCharge = 0.0;
  public orderTax = 0.0;
  public shippingPrice = 0.0;
  public shippingMethod = 0; // 0 = KM 1 = fixed
  public orderTo = 0; // 0 = home // 1 = self pickup

  public walletDiscount: any = 0.0;
  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.util.getCouponObservable().subscribe(data => {
      if (data) {
        console.log('------------->>', data);
        this.coupon = data;
        this.coupon.discount = parseFloat(data.discount);
        this.coupon.min_cart_value = parseFloat(data.min_cart_value);
        this.calcuate();
      }
    });

    this.util.getKeys('userCart').then((data: any) => {
      if (data && data !== null && data !== 'null') {
        const userCart = JSON.parse(data);
        if (userCart && userCart.length > 0) {
          this.cart = userCart;
          this.itemId = [...new Set(this.cart.map(item => item.id))];
          console.log('-- user cart');
          console.log(this.cart);
          console.log('-- user cart');
          this.getStoreInfo();
          this.calcuate();
        } else {
          this.calcuate();
        }
      } else {
        this.calcuate();
      }
    });
  }

  getStoreInfo() {
    this.api.post_private('v1/store/getStoreInfoByUid', { id: this.cart[0].store_id }).then((data: any) => {
      console.log('/////////////');
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.storeInfo = data.data;
        this.storeData = data.user;
      }
    }, error => {
      console.log(error);
    }).catch(error => {
      console.log(error);
    });
  }

  calcuate() {
    const item = this.cart.filter(x => x.quantity > 0);
    console.log('totla itms', this.itemId);
    console.log(item);
    this.totalItemsInCart = 0;
    this.total = 0;
    item.forEach(element => {
      console.log('itemsss----->>>', element);
      this.totalItemsInCart = this.totalItemsInCart + element.quantity;
      if (element.size == 0) {
        if (element.discount > 0) {
          this.total = this.total + element.discount * element.quantity;
        } else {
          this.total = this.total + element.price * element.quantity;
        }
      } else if (element.size == 1 && element.savedVariationsList.length > 0) {
        element.savedVariationsList.forEach((variations: any) => {
          this.total = this.total + variations.price * variations.quantity;
        });
      }

    });
    if (this.coupon && this.coupon.discount && this.coupon.discount > 0) {
      function percentage(numFirst: any, per: any) {
        return (numFirst / 100) * per;
      }
      this.discount = percentage(this.total, this.coupon.discount);
      if (this.total <= this.discount) {
        this.discount = this.total;
      }
    } else {
      this.discount = 0;
    }
    this.calculateAllCharges();
    console.log(this.total);

    // akhand
    localStorage.removeItem('userCart');
    localStorage.setItem('userCart', JSON.stringify(this.cart));
    this.util.clearKeys('userCart');
    this.util.setKeys('userCart', JSON.stringify(this.cart));
    // akhand
  }

  clearCart() {
    this.cart = [];
    this.itemId = [];
    this.grandTotal = 0.0;
    this.totalPrice = 0.0;
    this.discount = 0.0
    this.coupon = null;
    this.deliveredAddress = null;
    this.deliveryCharge = 0.0;
    localStorage.removeItem('userCart');
  }

  calculateAllCharges() {
    let total = parseFloat(this.total) + parseFloat(this.orderTax.toString()) + parseFloat(this.deliveryCharge);
    console.log('sub totall', total);

    this.grandTotal = total - this.discount;

    if (this.grandTotal <= this.walletDiscount) {
      this.walletDiscount = this.grandTotal;
      this.grandTotal = this.grandTotal - this.walletDiscount;
    } else {
      this.grandTotal = this.grandTotal - this.walletDiscount;
    }
  }

  addItem(item: any) {
    this.cart.push(item);
    this.itemId.push(item.id);
    this.calcuate();
  }

  addQuantity(quantity: any, id: any) {
    this.cart.forEach(element => {
      if (element.id == id) {
        element.quantity = quantity;
      }
    });
    this.cart = this.cart.filter(x => x.quantity > 0);
    this.calcuate();
  }

  updateVariationsIndex(productId: any, uuid: any, quantity: any) {
    console.log(this.cart);
    this.cart.forEach(element => {
      element.savedVariationsList.forEach((sub: any) => {
        if (sub.uuid == uuid && element.id == productId) {
          sub.quantity = quantity;
        }
      });
    });
    this.cart.forEach(element => {
      element.savedVariationsList = element.savedVariationsList.filter((x: any) => x.quantity > 0);
    });
    this.cart = this.cart.filter((x: any) => x.size == 1 ? x.savedVariationsList.length > 0 : x.quantity > 0);
    this.itemId = [...new Set(this.cart.map(item => item.id))];

    this.calcuate();
  }

  removeItem(id: any) {
    this.cart = this.cart.filter(x => x.id !== id);
    this.itemId = this.itemId.filter(x => x !== id);
    this.calcuate();
  }

  degreesToRadians(degrees: any) {
    return degrees * Math.PI / 180;
  }

  distanceInKmBetweenEarthCoordinates(lat1: any, lon1: any, lat2: any, lon2: any) {
    console.log(lat1, lon1, lat2, lon2);
    const earthRadiusKm = 6371;

    const dLat = this.degreesToRadians(lat2 - lat1);
    const dLon = this.degreesToRadians(lon2 - lon1);

    lat1 = this.degreesToRadians(lat1);
    lat2 = this.degreesToRadians(lat2);

    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  async calculateDistance() {
    let distance;
    if (this.deliveredAddress && this.deliveredAddress.address && this.storeInfo && this.storeInfo.address) {
      distance = await this.distanceInKmBetweenEarthCoordinates(this.deliveredAddress.lat, this.deliveredAddress.lng,
        this.storeInfo.lat, this.storeInfo.lng);
    } else {
      distance = 0;
    }
    console.log('allowd',);
    console.log('user distance', distance);
    //if (distance > parseFloat(this.util.allowDistance)) {
    if (false) {
      this.util.errorMessage(this.util.translate('Sorry we deliver the order near to') +
        this.util.allowDistance +
        this.util.translate('KM'));
      this.deliveredAddress = null;
    } else {
      if (this.freeDeliveryCharge > this.total) {
        if (this.shippingMethod == 0) {
          const distancePricer = distance * this.shippingPrice;
          this.deliveryCharge = Math.floor(distancePricer).toFixed(2);
          // this.deliveryCharge = parseFloat(this.deliveryCharge.toString).toFixed(2);
        } else {
          this.deliveryCharge = this.shippingPrice;
          // this.deliveryCharge = parseFloat(this.deliveryCharge.toString).toFixed(2);
        }
      } else {
        this.deliveryCharge = 0;
      }
      this.calculateAllCharges();
    }

  }
}
