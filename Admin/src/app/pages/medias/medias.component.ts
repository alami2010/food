/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ModalDirective } from 'ngx-bootstrap/modal';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';

@Component({
  selector: 'app-medias',
  templateUrl: './medias.component.html',
  styleUrls: ['./medias.component.scss']
})
export class MediasComponent implements OnInit {
  @ViewChild('myModal') public myModal: ModalDirective;
  list: any[] = [];
  dummy: any = Array(20);
  name: any = '';
  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.getAll();
  }


  getAll() {
    this.api.get_private('v1/medias/getAll').then((data: any) => {
      console.log(data);
      this.dummy = [];
      if (data && data.status && data.data && data.data.length) {
        this.list = data.data;
      }
    }, error => {
      console.log(error);
      this.dummy = [];
      this.list = [];
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.dummy = [];
      this.list = [];
      this.util.apiErrorHandler(error);
    });
  }

  ngOnInit(): void {
  }

  uploadFile(files: any) {
    console.log('fle', files);
    if (files.length === 0) {
      return;
    }
    const mimeType = files[0].type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }
    if (files) {
      this.util.show();
      this.api.uploadFile(files).subscribe((data: any) => {
        console.log('==>>>>>>', data.data);
        this.util.hide();
        if (data && data.data.image_name) {
          const param = {
            name: data.data.image_name,
            status: 1
          };
          this.util.show();
          this.api.post_private('v1/medias/create', param).then((data: any) => {
            console.log(data);
            this.util.hide();
            this.getAll();
          }, error => {
            console.log(error);
            this.util.hide();
            this.util.apiErrorHandler(error);
          }).catch(error => {
            console.log(error);
            this.util.hide();
            this.util.apiErrorHandler(error);
          });
          // this.cover = data.data.image_name;
        }
      }, err => {
        console.log(err);
        this.util.hide();
      });
    } else {
      console.log('no');
    }
  }

  openModal(item: any) {
    console.log(item);
    this.name = item.name;
    this.myModal.show();
  }

  copy() {
    try {
      navigator.clipboard.writeText(this.name).then(data => {
        console.log('Async: Copying to clipboard was successful!');
        this.util.success('Copied to clipboard');
      }, error => {
        console.error('Async: Could not copy text: ', error);
      });
    } catch (error) {
      console.log(error);
    }
  }
}
