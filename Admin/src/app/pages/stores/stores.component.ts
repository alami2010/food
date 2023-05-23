/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { NavigationExtras, Router } from '@angular/router';
import * as moment from 'moment';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-stores',
  templateUrl: './stores.component.html',
  styleUrls: ['./stores.component.scss']
})
export class StoresComponent implements OnInit {
  dummy: any[] = [];
  list: any[] = [];
  dummyList: any[] = [];

  deliveryType: any = [
    '',
    this.util.translate('Delivery'),
    this.util.translate('Self Pickup'),
    this.util.translate('Both Delivery & Self Pickup')
  ];
  page: number = 1;
  cities: any[] = [];
  selectedCities: any = '';
  constructor(
    public util: UtilService,
    public api: ApiService,
    private router: Router
  ) {

    this.getStores();
    this.getAllCities();
  }

  ngOnInit(): void {
  }


  exportCSV() {
    let data: any = [];
    this.list.forEach(element => {
      console.log(element);
      const info = {
        'Name': this.replaceWithDot(element.name),
        'City': this.replaceWithDot(element.city_name),
        'Owner': this.replaceWithDot(element.fname) + ' ' + this.replaceWithDot(element.lname),
        'Delivery Type': this.replaceWithDot(this.deliveryType[element.delivery_type]),
        'Is Veg': element.pure_veg == 1 ? 'Yes' : 'No',
        'Have Bookings': element.have_dining == 1 ? 'Yes' : 'No',
        'Status': element.status
      }
      data.push(info);
    });
    console.log(data);
    const name = moment().format('YYYY-MM-DD-HH:mm:SS');
    this.util.downloadFile(data, name, ['Name', 'City', 'Owner', 'Delivery Type', 'Is Veg', 'Have Bookings', 'Status']);
  }

  replaceWithDot(input: string) {
    return input.replace(/,/g, '.')
  }

  filter() {
    console.log(this.selectedCities);
    this.list = this.dummyList.filter(x => x.city_id == this.selectedCities);
  }

  clearFilter() {
    this.selectedCities = '';
    this.list = this.dummyList;
  }
  getAllCities() {
    this.cities = [];
    this.api.get_private('v1/cities/getAll').then((data: any) => {
      this.dummy = [];
      if (data && data.status && data.status === 200 && data.success) {
        console.log(">>>>>", data);
        if (data.data.length > 0) {
          this.cities = data.data;
          console.log("=========", this.cities);
        }
      }
    }, error => {
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  getStores() {
    this.dummy = Array(5);
    this.list = [];
    this.api.get_private('v1/store/getStores').then((data: any) => {
      console.log(data);
      this.dummy = [];
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        this.list = data.data;
        this.dummyList = data.data;
        console.log(Object.keys(this.list[0]));
      }
    }, error => {
      console.log(error);
      this.dummy = [];
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.dummy = [];
      this.util.apiErrorHandler(error);
    });
  }
  addNew() {
    this.router.navigate(['manage-store']);
  }

  getTime(time: any) {
    return moment('1997-07-15 ' + time).format('hh:mm A');
  }

  openStore(item: any) {
    const param: NavigationExtras = {
      queryParams: {
        id: item.id
      }
    };
    this.router.navigate(['manage-store'], param);
  }

  changeStatus(item: any) {
    console.log(item);
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
        const body = {
          id: item.id,
          uid: item.uid,
          status: item.status === 0 ? 1 : 0
        };
        console.log("===========", body);
        this.util.show();
        this.api.post_private('v1/store/updateStatus', body).then((data: any) => {
          this.util.hide();
          console.log("+++++++++++++++", data);
          if (data && data.status && data.status === 200 && data.success) {
            this.util.success(this.util.translate('Status Updated !'));
            this.getStores();
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
    //store/updateStatus
  }

  search(str: any) {
    this.resetChanges();
    console.log('string', str);
    this.list = this.filterItems(str);
  }

  protected resetChanges = () => {
    this.list = this.dummyList;
  }

  filterItems(searchTerm: any) {
    return this.list.filter((item) => {
      return item.name.toLowerCase().indexOf(searchTerm.toLowerCase()) > -1;
    });
  }

  setFilteredItems() {
    console.log('clear');
    this.list = [];
    this.list = this.dummyList;
  }

}
