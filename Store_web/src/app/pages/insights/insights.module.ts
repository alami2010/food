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

import { InsightsRoutingModule } from './insights-routing.module';
import { InsightsComponent } from './insights.component';
import { ChartjsModule } from '@coreui/angular-chartjs';

@NgModule({
  declarations: [
    InsightsComponent
  ],
  imports: [
    CommonModule,
    InsightsRoutingModule,
    ChartjsModule
  ]
})
export class InsightsModule { }
