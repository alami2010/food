/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ElementRef, ViewChild, HostListener, ChangeDetectorRef } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ModalDirective } from 'angular-bootstrap-md';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';
import { orderBy, uniqBy } from 'lodash';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss']
})
export class ListComponent implements OnInit {
  @ViewChild('topBanners', { read: ElementRef }) public topBanners: ElementRef<any>;
  @ViewChild('filterModal') public filterModal: ModalDirective;
  tabID = '';

  plt;
  allRest: any[] = [];
  chips: any[] = [];
  showFilter: boolean;
  lat: any;
  lng: any;
  dummyRest: any[] = [];
  haveLocation: boolean;
  profile: any;
  banners: any[] = [];
  categories: any;
  slideOpts = {
    slidesPerView: 1.2,
    pagination: true
  };
  cityName: any;
  cityId: any;
  activeFilter: any;
  searchKeyword: any = '';
  haveData: boolean;
  apiCalled: boolean = false;
  cusineId: any = '';
  @HostListener('window:beforeunload')
  canDeactivate(): any {
    console.log('ok');
  };
  constructor(
    public util: UtilService,
    public api: ApiService,
    public router: Router,
    public route: ActivatedRoute,
    private chMod: ChangeDetectorRef,
  ) {
    this.haveData = true;
    if (this.route.snapshot.paramMap.get('id')) {
      this.cusineId = this.route.snapshot.paramMap.get('id');
      this.getByCategories();
    }
    this.util.subscribeFitlerCode().subscribe(data => {
      this.addFilter(data);
    });
  }

  getByCategories() {
    const param = {
      "id": this.cusineId,
      lat: localStorage.getItem('lat'),
      lng: localStorage.getItem('lng'),
    };
    this.api.post('v1/user/getNearMeCategories', param).then((data: any) => {
      this.apiCalled = true;
      console.log(data);
      if (data && data.status && data.status == 200 && data.havedata == true) {
        this.haveData = true;
        this.allRest = [];
        this.dummyRest = [];
        this.allRest = data.data;
        this.dummyRest = data.data;
        this.categories = data.categories;
        this.banners = data.banners;

        this.chMod.detectChanges();
      } else {
        this.allRest = [];
        this.dummyRest = [];
        this.haveData = false;
      }
    }, error => {
      this.apiCalled = true;
      console.log(error);
      this.dummyRest = [];
      this.allRest = [];
      this.haveData = false;
    }).catch(error => {
      this.apiCalled = true;
      console.log(error);
      this.haveData = false;
      this.allRest = [];
      this.dummyRest = [];
    });
  }
  ngOnInit(): void {
    window.addEventListener('scroll', this.scroll, true); // third parameter
  }

  onIndexChange(event) {
    console.log(event);
  }

  ngOnDestroy() {
    window.removeEventListener('scroll', this.scroll, true);
  }

  scroll = (event: any): void => {
    const amount = event.srcElement.scrollTop;
    if (amount >= 280) {
      this.util.publishHeader({ header: true, total: this.allRest.length, active: this.activeFilter });
      return;
    } else {
      this.util.publishHeader({ header: false, total: this.allRest.length, active: this.activeFilter });
      return;
    }
  };

  addFilter(index) {
    console.log(index);
    this.activeFilter = index;
    if (index == 0) {
      console.log('rating');
      this.allRest = orderBy(this.allRest, 'ratings', 'desc');
    } else if (index == 1) {
      console.log('fast');
      this.allRest = orderBy(this.allRest, 'time', 'asc');
    } else if (index == 2) {
      console.log('cost');
      this.allRest = orderBy(this.allRest, 'delivery_time', 'asc');
    } else if (index == 3) {
      console.log('A-Z');
      this.allRest = orderBy(this.allRest, 'name', 'asc');
    } else if (index == 4) {
      console.log('Z-A');
      this.allRest = orderBy(this.allRest, 'name', 'desc');
    }
  }

  getAddressName() {
    const location = localStorage.getItem('address');
    if (location && location != null && location !== 'null') {
      return location.length > 30 ? location.slice(0, 30) + '....' : location;;
    }
    localStorage.clear();
    return 'No address';
  }

  showAddressChangePopup() {
    this.util.publishAddressPopup();
  }

  onSearchChange(event) {
    console.log(event);
    if (event !== '') {
      this.allRest = this.dummyRest.filter((ele: any) => {
        return ele.name.toLowerCase().includes(event.toLowerCase());
      });
    } else {
      this.allRest = this.dummyRest;
    }
  }

  openOffers(item) {
    console.log(item);
    if (item.type == 1) {
      console.log('category');
      this.util.publishHeader({ header: false, total: this.allRest.length, active: this.activeFilter });
      this.router.navigate(['list', item.value, 'Offers'])
    } else if (item.type == 2) {
      console.log('single restaurants');
      this.util.publishHeader({ header: false, total: this.allRest.length, active: this.activeFilter });
      this.router.navigate(['order', item.value, 'Offers'])
    } else if (item.type == 3) {
      console.log('multiple restaurants');
      //offers-restaurants
      this.util.publishHeader({ header: false, total: this.allRest.length, active: this.activeFilter });
      this.router.navigate(['offers-restaurants', item.value]);
    } else if (item.type == 4) {
      console.log('links');
      window.open(item.value, '_blank');
    }

  }

  goToRestDetail(item) {
    this.util.publishHeader({ header: false, total: this.allRest.length, active: this.activeFilter });
    this.router.navigate(['order', item.uid, item.name.replace(/\s+/g, '-').toLowerCase()])
  }

  allCategories() {
    this.router.navigate(['categories']);
  }

  getRestaurantList(id: any, name: any) {
    this.util.publishHeader({ header: false, total: this.allRest.length, active: this.activeFilter });
    this.router.navigate(['list', id, name.replace(/\s+/g, '-').toLowerCase()])
  }

}
