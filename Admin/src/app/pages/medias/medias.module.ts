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

import { MediasRoutingModule } from './medias-routing.module';
import { MediasComponent } from './medias.component';
import { ModalModule } from 'ngx-bootstrap/modal';
import { FormsModule } from '@angular/forms';
import { NgxSpinnerModule } from 'ngx-spinner';

@NgModule({
  declarations: [
    MediasComponent
  ],
  imports: [
    CommonModule,
    MediasRoutingModule,
    ModalModule.forRoot(),
    FormsModule,
    NgxSpinnerModule,
  ]
})
export class MediasModule { }
