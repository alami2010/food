/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OffersRestaurantsComponent } from './offers-restaurants.component';

describe('OffersRestaurantsComponent', () => {
  let component: OffersRestaurantsComponent;
  let fixture: ComponentFixture<OffersRestaurantsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [OffersRestaurantsComponent]
    })
      .compileComponents();

    fixture = TestBed.createComponent(OffersRestaurantsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
