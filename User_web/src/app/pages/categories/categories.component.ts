/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-categories',
  templateUrl: './categories.component.html',
  styleUrls: ['./categories.component.scss']
})
export class CategoriesComponent implements OnInit {
  list: any[] = [];
  apiCalled: boolean = false;
  constructor(
    public util: UtilService,
    public api: ApiService,
    private router: Router
  ) {
    this.getCategories();
  }

  ngOnInit(): void {
  }

  getCategories() {
    this.api.get('v1/categories/userCategories').then((data: any) => {
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

  getRestaurantList(id: any, name: any) {
    this.router.navigate(['list', id, name.replace(/\s+/g, '-').toLowerCase()])
  }

}
