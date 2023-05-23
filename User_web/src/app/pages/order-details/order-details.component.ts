/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { ModalDirective } from 'angular-bootstrap-md';
import { ActivatedRoute, Router, NavigationExtras } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';
import { Location } from '@angular/common';
import Swal from 'sweetalert2';
declare var google: any;
@Component({
  selector: 'app-order-details',
  templateUrl: './order-details.component.html',
  styleUrls: ['./order-details.component.scss']
})
export class OrderDetailsComponent implements OnInit {
  @ViewChild('tracker') public tracker: ModalDirective;
  @ViewChild('trackerStore') public trackerStore: ModalDirective;

  @ViewChild('map', { static: true }) mapElement: ElementRef;
  orderId: any;
  storeInfo: any;
  storeName: any;
  storeCover: any;
  storeAddress: any;
  storeMobile: any = '';
  orders: any[] = [];
  itemTotal: any;
  taxCharge: any;
  deliveryCharge: any;
  discount: any;
  grandTotal: any;
  payMethod: any;
  orderNumber: any;
  deliverTo: any;
  addressName = ['home', 'work', 'other'];  // 1 = home , 2 = work , 3 = other
  orderOn: any;
  paymentBy = ['NA', 'COD', 'Stripe', 'PayPal', 'PayTM', 'Razorpay', 'Instamojo', 'Paystack', 'Flutterwave']
  driverId: any = '';
  dCover: any = '';
  driverName: any = '';
  address: any = '';
  apiCalled: boolean = false;
  status: any = '';
  interval: any;
  driverMobile: any = '';
  driverLat: any = '';
  driverLng: any = '';

  store
  myLat: any = '';
  myLng: any = '';
  orderStatus = [
    'Created', // 0
    'Accepted', // 1
    'Prepared', // 2
    'Ongoing', // 3
    'Delivered', // 4
    'Cancelled', // 5
    'Rejected', // 6
    'Refunded', // 7
    'Pending Payments', // 8
  ];
  constructor(
    public util: UtilService,
    public api: ApiService,
    private navParam: ActivatedRoute,
    private navCtrl: Location,
    private router: Router
  ) {
    this.navParam.queryParams.subscribe((data: any) => {
      if (data && data.id && data.id != '') {
        this.orderId = data.id;
        this.getOrderDetail();
      }
    });
  }

  closeInterval() {
    this.tracker.hide();
    clearInterval(this.interval);
  }

  ngOnInit(): void {
  }

  locate() {
    if (window.navigator && window.navigator.geolocation) {
      this.util.start();
      window.navigator.geolocation.getCurrentPosition(
        position => {
          this.util.stop();
          console.log(position);
          this.trackerStore.show();
          this.loadMapStore(position.coords.latitude, position.coords.longitude, parseFloat(this.storeInfo.lat), parseFloat(this.storeInfo.lng));
          // this.getAddress(position.coords.latitude, position.coords.longitude);
        },
        error => {
          this.util.stop();
          switch (error.code) {
            case 1:
              console.log('Permission Denied');
              this.util.errorMessage(this.util.translate('Location Permission Denied'));
              break;
            case 2:
              console.log('Position Unavailable');
              this.util.errorMessage(this.util.translate('Position Unavailable'));
              break;
            case 3:
              console.log('Timeout');
              this.util.errorMessage(this.util.translate('Failed to fetch location'));
              break;
            default:
              console.log('defual');
          }
        }
      );
    };
  }

  getOrderDetail() {
    this.api.post_private('v1/orders/getByOrderId', { id: this.orderId }).then((data: any) => {
      this.apiCalled = true;
      console.log(data, 'data',);
      if (data && data.status == 200) {
        this.storeInfo = data.storeInfo;
        this.storeName = this.storeInfo.name;
        this.storeCover = this.storeInfo.cover;
        this.storeAddress = this.storeInfo.address;
        this.storeMobile = this.storeInfo.mobile;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(data.data.items)) {
          this.orders = JSON.parse(data.data.items);
          console.log(this.orders);
        } else {
          this.orders = [];
        }

        if (data.data.order_to == 0) {
          this.driverId = data.data.driver_id;
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(data.data.address)) {
            var address = JSON.parse(data.data.address);
            console.log(address);
            this.address = address.house + ' ' + address.landmark + ' ' + address.address + ' ' + address.pincode;
            this.myLat = address.lat;
            this.myLng = address.lng;
            if (data && data.driverInfo && data.driverInfo.first_name) {
              this.driverName = data.driverInfo.first_name;
              this.driverLat = data.driverInfo.lat;
              this.driverLng = data.driverInfo.lng;
            }
          }
        }
        this.itemTotal = data.data.total;
        this.taxCharge = data.data.serviceTax;
        this.deliveryCharge = data.data.delivery_charge;
        this.discount = data.data.discount;
        this.grandTotal = data.data.grand_total;
        this.payMethod = data.data.pay_method;
        this.orderNumber = data.data.id;
        this.deliverTo = data.data.order_to;
        this.orderOn = data.userInfo.created_at;

        this.status = data.data.status;
      }
    }, error => {
      this.apiCalled = true;
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.apiCalled = true;
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  printInvoice() {
    window.open(this.api.baseUrl + 'v1/orders/printInvoice?id=' + this.orderId + '&token=' + localStorage.getItem('token'), '_blank');
  }

  trackMyOrder() {
    this.tracker.show();
    this.loadMap(parseFloat(this.myLat), parseFloat(this.myLng), parseFloat(this.driverLat), parseFloat(this.driverLng));
  }

  loadMap(latOri, lngOri, latDest, lngDest) {

    const directionsService = new google.maps.DirectionsService;
    let directionsDisplay = new google.maps.DirectionsRenderer;
    directionsDisplay = new google.maps.DirectionsRenderer();
    const bounds = new google.maps.LatLngBounds;

    const origin1 = { lat: parseFloat(latOri), lng: parseFloat(lngOri) };
    const destinationA = { lat: latDest, lng: lngDest };

    const maps = new google.maps.Map(this.mapElement.nativeElement, {
      center: { lat: latOri, lng: lngOri },
      disableDefaultUI: true,
      zoom: 100
    });

    const custPos = new google.maps.LatLng(latOri, lngOri);
    const restPos = new google.maps.LatLng(latDest, lngDest);

    const logo = {
      url: 'assets/pin.png',
      scaledSize: new google.maps.Size(50, 50), // scaled size
      origin: new google.maps.Point(0, 0), // origin
      anchor: new google.maps.Point(0, 0) // anchor
    };
    const marker = new google.maps.Marker({
      map: maps,
      position: custPos,
      animation: google.maps.Animation.DROP,
      icon: logo,
    });
    const markerCust = new google.maps.Marker({
      map: maps,
      position: restPos,
      animation: google.maps.Animation.DROP,
      icon: logo,
    });
    marker.setMap(maps);
    markerCust.setMap(maps);

    directionsDisplay.setMap(maps);
    // directionsDisplay.setOptions({ suppressMarkers: true });
    directionsDisplay.setOptions({
      polylineOptions: {
        strokeWeight: 4,
        strokeOpacity: 1,
        strokeColor: '#ff384c'
      },
      suppressMarkers: true
    });
    const geocoder = new google.maps.Geocoder;

    const service = new google.maps.DistanceMatrixService;

    service.getDistanceMatrix({
      origins: [origin1],
      destinations: [destinationA],
      travelMode: 'DRIVING',
      unitSystem: google.maps.UnitSystem.METRIC,
      avoidHighways: false,
      avoidTolls: false
    }, function (response, status) {
      if (status !== 'OK') {
        alert('Error was: ' + status);
      } else {
        const originList = response.originAddresses;
        const destinationList = response.destinationAddresses;
        const showGeocodedAddressOnMap = function (asDestination) {
          return function (results, status) {
            if (status === 'OK') {
              maps.fitBounds(bounds.extend(results[0].geometry.location));
            } else {
              alert('Geocode was not successful due to: ' + status);
            }
          };
        };

        directionsService.route({
          origin: origin1,
          destination: destinationA,
          travelMode: 'DRIVING'
        }, function (response, status) {
          if (status === 'OK') {
            directionsDisplay.setDirections(response);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });


        for (let i = 0; i < originList.length; i++) {
          const results = response.rows[i].elements;
          geocoder.geocode({ 'address': originList[i] },
            showGeocodedAddressOnMap(false));
          for (let j = 0; j < results.length; j++) {
            geocoder.geocode({ 'address': destinationList[j] },
              showGeocodedAddressOnMap(true));
          }
        }
      }
    });
    this.interval = setInterval(() => {
      this.changeMarkerPosition(marker, maps);
    }, 12000);
  }

  loadMapStore(latOri, lngOri, latDest, lngDest) {

    const directionsService = new google.maps.DirectionsService;
    let directionsDisplay = new google.maps.DirectionsRenderer;
    directionsDisplay = new google.maps.DirectionsRenderer();
    const bounds = new google.maps.LatLngBounds;

    const origin1 = { lat: parseFloat(latOri), lng: parseFloat(lngOri) };
    const destinationA = { lat: latDest, lng: lngDest };

    const maps = new google.maps.Map(this.mapElement.nativeElement, {
      center: { lat: latOri, lng: lngOri },
      disableDefaultUI: true,
      zoom: 100
    });

    const custPos = new google.maps.LatLng(latOri, lngOri);
    const restPos = new google.maps.LatLng(latDest, lngDest);

    const logo = {
      url: 'assets/pin.png',
      scaledSize: new google.maps.Size(50, 50), // scaled size
      origin: new google.maps.Point(0, 0), // origin
      anchor: new google.maps.Point(0, 0) // anchor
    };
    const marker = new google.maps.Marker({
      map: maps,
      position: custPos,
      animation: google.maps.Animation.DROP,
      icon: logo,
    });
    const markerCust = new google.maps.Marker({
      map: maps,
      position: restPos,
      animation: google.maps.Animation.DROP,
      icon: logo,
    });
    marker.setMap(maps);
    markerCust.setMap(maps);

    directionsDisplay.setMap(maps);
    // directionsDisplay.setOptions({ suppressMarkers: true });
    directionsDisplay.setOptions({
      polylineOptions: {
        strokeWeight: 4,
        strokeOpacity: 1,
        strokeColor: '#ff384c'
      },
      suppressMarkers: true
    });
    const geocoder = new google.maps.Geocoder;

    const service = new google.maps.DistanceMatrixService;

    service.getDistanceMatrix({
      origins: [origin1],
      destinations: [destinationA],
      travelMode: 'DRIVING',
      unitSystem: google.maps.UnitSystem.METRIC,
      avoidHighways: false,
      avoidTolls: false
    }, function (response, status) {
      if (status !== 'OK') {
        alert('Error was: ' + status);
      } else {
        const originList = response.originAddresses;
        const destinationList = response.destinationAddresses;
        const showGeocodedAddressOnMap = function (asDestination) {
          return function (results, status) {
            if (status === 'OK') {
              maps.fitBounds(bounds.extend(results[0].geometry.location));
            } else {
              alert('Geocode was not successful due to: ' + status);
            }
          };
        };

        directionsService.route({
          origin: origin1,
          destination: destinationA,
          travelMode: 'DRIVING'
        }, function (response, status) {
          if (status === 'OK') {
            directionsDisplay.setDirections(response);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });


        for (let i = 0; i < originList.length; i++) {
          const results = response.rows[i].elements;
          geocoder.geocode({ 'address': originList[i] },
            showGeocodedAddressOnMap(false));
          for (let j = 0; j < results.length; j++) {
            geocoder.geocode({ 'address': destinationList[j] },
              showGeocodedAddressOnMap(true));
          }
        }
      }
    });
  }

  changeMarkerPosition(marker, map) {
    const param = {
      id: this.driverId
    };
    this.api.post_private('v1/profile/getByID', param).then((data: any) => {
      console.log('driver info--->>', data);
      if (data && data.status === 200) {
        const info = data.data;
        console.log('---->>>>>', info);
        this.driverName = info.first_name + ' ' + info.last_name;
        this.dCover = info.cover;
        this.driverMobile = info.mobile;
        this.driverLat = info.lat;
        this.driverLng = info.lng;
        const latlng = new google.maps.LatLng(parseFloat(this.driverLat), parseFloat(this.driverLng));
        map.setCenter(latlng);
        marker.setPosition(latlng);
      }
    }, error => {
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch((error) => {
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });

  }

  callStore() {
    if (this.storeMobile) {
      window.open('tel:' + this.storeMobile);
    } else {
      this.util.errorMessage(this.util.translate('Number not found'));
    }
  }

  callDriver() {
    if (this.driverMobile) {
      window.open('tel:' + this.driverMobile);
    } else {
      this.util.errorMessage(this.util.translate('Number not found'));
    }
  }

  changeStatus() {
    this.util.start();
    this.api.post_private('v1/orders/cancelMyOrder', { id: this.orderId, status: 5 }).then((data: any) => {
      console.log(data);
      this.util.stop();
      this.util.suucessMessage('Updated');
      this.navCtrl.back();
    }, error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  async presentAlertConfirm() {
    Swal.fire({
      title: this.util.translate('How was your experience?'),
      text: this.util.translate('Rate ' + this.storeName + ' and ' + this.driverName),
      showCancelButton: true,
      cancelButtonText: this.util.translate('Cancel'),
      showConfirmButton: true,
      confirmButtonText: this.util.translate('Yes'),
      backdrop: false,
      background: 'white'
    }).then((data) => {
      console.log(data);
      if (data && data.value) {
        console.log('ok');
        const param: NavigationExtras = {
          queryParams: {
            id: this.orderId
          }
        }
        this.router.navigate(['rate'], param);
      }
    });
  }
}
