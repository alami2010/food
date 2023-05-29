/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foodies_user/app/controller/track_controller.dart';
import 'package:foodies_user/app/env.dart';
import 'package:foodies_user/app/util/map_style.dart';
import 'package:foodies_user/app/util/theme.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late GoogleMapController _mapController;
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.setMapStyle(Utils.mapStyles);

    Get.find<TrackingController>().googleMapsController.complete(controller);
    Get.find<TrackingController>().showPinsOnMap();
  }

  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (Get.find<TrackingController>().googleMapsType == 'driver') {
      timer = Timer.periodic(const Duration(seconds: 20), (Timer t) {
        Get.find<TrackingController>().getDriverInfo();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (Get.find<TrackingController>().googleMapsType == 'driver') {
      debugPrint('disposing');
      timer?.cancel();
      Get.delete<TrackingController>(force: true);
    } else {
      debugPrint('disposing');
      _mapController.dispose();
      Get.find<TrackingController>().cancelLocationSubscription();
      Get.delete<TrackingController>(force: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackingController>(builder: (value) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Text(
              'Tracking Order'.tr,
              style: ThemeProvider.titleStyle,
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: ThemeProvider.whiteColor,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: GoogleMap(
                          myLocationEnabled: true,
                          compassEnabled: true,
                          tiltGesturesEnabled: false,
                          markers: value.markers,
                          polylines: value.polylines,
                          mapType: MapType.normal,
                          initialCameraPosition: value.initialCameraPosition,
                          onTap: (LatLng loc) {
                            value.pinPillPosition = -100;
                          },
                          onMapCreated: _onMapCreated,
                        ),
                      ),
                      value.googleMapsType == 'store'
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: ThemeProvider
                                                .greyColor.shade300))),
                                child: Text('Store Information'.tr,
                                    style: const TextStyle(
                                        fontSize: 14, fontFamily: 'bold')),
                              ),
                            )
                          : const SizedBox(),
                      value.googleMapsType == 'store'
                          ? InkWell(
                              onTap: () {
                                value.openActionModalStore();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(30),
                                            child: FadeInImage(
                                              image: NetworkImage(
                                                  '${Environments.apiBaseURL}storage/images/${value.storeCover}'),
                                              placeholder: const AssetImage(
                                                  "assets/images/error.png"),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    'assets/images/error.png',
                                                    fit: BoxFit.fitWidth);
                                              },
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                value.storeName,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'bold'),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: <Widget>[
                                                  const Icon(
                                                      Icons.payment_outlined,
                                                      size: 17,
                                                      color: ThemeProvider
                                                          .appColor),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('Order Total'.tr,
                                                      style: const TextStyle(
                                                          fontFamily: 'bold',
                                                          color: ThemeProvider
                                                              .appColor)),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  value.currencySide == 'left'
                                                      ? Text(
                                                          value.currencySymbol +
                                                              value.storeAmount
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'bold',
                                                              color:
                                                                  ThemeProvider
                                                                      .appColor),
                                                        )
                                                      : Text(value.storeAmount
                                                              .toString() +
                                                          value.currencySymbol)
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: <Widget>[
                                                  const Icon(
                                                      Icons.payment_outlined,
                                                      size: 17,
                                                      color: ThemeProvider
                                                          .appColor),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('Payment Method : '.tr,
                                                      style: const TextStyle(
                                                          fontFamily: 'bold',
                                                          color: ThemeProvider
                                                              .appColor)),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    value.payMethod == '1'
                                                        ? 'COD'.tr
                                                        : 'PAID'.tr,
                                                    style: const TextStyle(
                                                        fontFamily: 'bold',
                                                        color: ThemeProvider
                                                            .appColor),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: <Widget>[
                                                  const Icon(Icons.call,
                                                      size: 17),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(value.storeMobile
                                                      .toString()),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: <Widget>[
                                                  const Icon(Icons.pin_drop,
                                                      size: 17),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .6,
                                                    child: Text(
                                                      value.storeAddress,
                                                      maxLines: 3,
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            )
                          : const SizedBox(),
                      value.googleMapsType == 'driver'
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: ThemeProvider
                                                .greyColor.shade300))),
                                child: Text('Driver Information'.tr,
                                    style: const TextStyle(
                                        fontSize: 14, fontFamily: 'bold')),
                              ),
                            )
                          : const SizedBox(),
                      value.googleMapsType == 'driver'
                          ? InkWell(
                              onTap: () {
                                value.openDriverModal();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(30),
                                            child: FadeInImage(
                                              image: NetworkImage(
                                                  '${Environments.apiBaseURL}storage/images/${value.driverCover}'),
                                              placeholder: const AssetImage(
                                                  "assets/images/error.png"),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    'assets/images/error.png',
                                                    fit: BoxFit.fitWidth);
                                              },
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                value.driverName,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'bold'),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: <Widget>[
                                                  const Icon(
                                                      Icons.payment_outlined,
                                                      size: 17,
                                                      color: ThemeProvider
                                                          .appColor),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('Order Total'.tr,
                                                      style: const TextStyle(
                                                          fontFamily: 'bold',
                                                          color: ThemeProvider
                                                              .appColor)),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  value.currencySide == 'left'
                                                      ? Text(
                                                          value.currencySymbol +
                                                              value
                                                                  .driverAmountPay
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'bold',
                                                              color:
                                                                  ThemeProvider
                                                                      .appColor),
                                                        )
                                                      : Text(value
                                                              .driverAmountPay
                                                              .toString() +
                                                          value.currencySymbol)
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: <Widget>[
                                                  const Icon(
                                                      Icons.payment_outlined,
                                                      size: 17,
                                                      color: ThemeProvider
                                                          .appColor),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('Payment Method : '.tr,
                                                      style: const TextStyle(
                                                          fontFamily: 'bold',
                                                          color: ThemeProvider
                                                              .appColor)),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    value.payMethod == '1'
                                                        ? 'COD'.tr
                                                        : 'PAID'.tr,
                                                    style: const TextStyle(
                                                        fontFamily: 'bold',
                                                        color: ThemeProvider
                                                            .appColor),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: <Widget>[
                                                  const Icon(Icons.call,
                                                      size: 17),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(value.driverMobile
                                                      .toString()),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ));
    });
  }
}
