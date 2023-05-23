/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { OffersRestaurantsRoutingModule } from './offers-restaurants-routing.module';
import { OffersRestaurantsComponent } from './offers-restaurants.component';
import { MDBBootstrapModule } from 'angular-bootstrap-md';
import { NgxSpinnerModule } from 'ngx-spinner';
import { SharedModule } from 'src/app/shared/shared.module';
import { IvyCarouselModule } from 'angular-responsive-carousel';


@NgModule({
  declarations: [
    OffersRestaurantsComponent
  ],
  imports: [
    CommonModule,
    OffersRestaurantsRoutingModule,
    MDBBootstrapModule.forRoot(),
    NgxSpinnerModule,
    SharedModule,
    IvyCarouselModule
  ]
})
export class OffersRestaurantsModule { }
