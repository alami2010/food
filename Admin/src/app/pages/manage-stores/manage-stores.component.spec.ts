/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ManageStoresComponent } from './manage-stores.component';

describe('ManageStoresComponent', () => {
  let component: ManageStoresComponent;
  let fixture: ComponentFixture<ManageStoresComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ManageStoresComponent]
    })
      .compileComponents();

    fixture = TestBed.createComponent(ManageStoresComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
