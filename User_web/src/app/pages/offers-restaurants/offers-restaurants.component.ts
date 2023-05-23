/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-offers-restaurants',
  templateUrl: './offers-restaurants.component.html',
  styleUrls: ['./offers-restaurants.component.scss']
})
export class OffersRestaurantsComponent implements OnInit {
  list: any[] = [];
  apiCalled: boolean = false;
  id: any = '';
  constructor(
    public util: UtilService,
    public api: ApiService,
    private route: ActivatedRoute,
    private router: Router
  ) {
    if (this.route.snapshot.paramMap.get('id')) {
      this.id = this.route.snapshot.paramMap.get('id');
      console.log(this.id);
      this.getList();
    }
  }

  getList() {
    const param = {
      lat: localStorage.getItem('lat'),
      lng: localStorage.getItem('lng'),
      "id": this.id
    };
    this.api.post('v1/user/getOffersRestaurants', param).then((data: any) => {
      console.log(data);
      this.apiCalled = true;
      if (data && data.status && data.status == 200 && data.data) {
        this.list = data.data;
      }
    }, error => {
      console.log(error);
      this.apiCalled = true;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      console.log(error);
      this.apiCalled = true;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  ngOnInit(): void {
  }
  goToRestDetail(item) {
    this.router.navigate(['order', item.uid, item.name.replace(/\s+/g, '-').toLowerCase()])
  }
}
