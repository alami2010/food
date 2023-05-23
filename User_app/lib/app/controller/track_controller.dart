/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:upgrade/app/backend/api/handler.dart';
import 'package:upgrade/app/backend/parse/track_parse.dart';
import 'package:upgrade/app/env.dart';
import 'package:upgrade/app/util/constant.dart';
import 'package:upgrade/app/util/pin_info.dart';
import 'package:url_launcher/url_launcher.dart';

const double cameraZoom = 16;
const double cameraTilt = 80;
const double cameraBearing = 30;

class TrackingController extends GetxController implements GetxService {
  final TrackParser parser;
  final Completer<GoogleMapController> googleMapsController = Completer();
  final Set<Marker> markers = <Marker>{};
  final Set<Polyline> polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  String googleAPIKey = Environments.googleMapsKey;
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  late LocationData currentLocation =
      LocationData.fromMap({"latitude": 21.530435, "longitude": 71.825037});
  late LocationData destinationLocation =
      LocationData.fromMap({"latitude": 21.536411, "longitude": 71.834638});
  late Location location;
  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: const LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  PinInformation sourcePinInfo = PinInformation(
      locationName: "Start Location".tr,
      location: const LatLng(21.530435, 71.825037),
      pinPath: "assets/images/bike.png",
      avatarPath: "assets/images/bike.png",
      labelColor: Colors.blueAccent);
  PinInformation destinationPinInfo = PinInformation(
      locationName: "End Location".tr,
      location: const LatLng(21.536411, 71.834638),
      pinPath: "assets/images/dest.png",
      avatarPath: "assets/images/dest.png",
      labelColor: Colors.purple);
  late CameraPosition initialCameraPosition;

  bool isLocationClosed = false;
  late StreamSubscription<LocationData> locationSubscription;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  String googleMapsType = '';
  String storeName = '';
  String storeAddress = '';
  String storeCover = '';
  double storeLat = 0.0;
  double storeLng = 0.0;
  String storeMobile = '';
  double storeAmount = 0.0;

  String driverName = '';
  String driverCover = '';
  int driverId = 0;
  String driverMobile = '';
  double userLat = 0.0;
  double userLng = 0.0;
  double driverLat = 0.0;
  double driverLng = 0.0;
  double driverAmountPay = 0.0;

  String payMethod = '';
  bool apiCalled = false;
  TrackingController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    googleMapsType = Get.arguments[0];
    if (googleMapsType == 'store') {
      apiCalled = true;
      storeName = Get.arguments[1];
      storeAddress = Get.arguments[2];
      storeCover = Get.arguments[3];
      storeLat = double.parse(Get.arguments[4]);
      storeLng = double.parse(Get.arguments[5]);
      storeMobile = Get.arguments[6];
      storeAmount = Get.arguments[7];
      payMethod = Get.arguments[8];
      destinationLocation =
          LocationData.fromMap({"latitude": storeLat, "longitude": storeLng});
      var destPosition = LatLng(storeLat, storeLng);
      initialCameraPosition = CameraPosition(
          zoom: cameraZoom,
          tilt: cameraTilt,
          bearing: cameraBearing,
          target: destPosition);
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: cameraZoom,
          tilt: cameraTilt,
          bearing: cameraBearing);
      location = Location();
      polylinePoints = PolylinePoints();
      locationSubscription =
          location.onLocationChanged.listen((LocationData cLoc) {
        currentLocation = cLoc;
        debugPrint(currentLocation.latitude.toString());
        debugPrint(currentLocation.longitude.toString());
        if (isLocationClosed == false) {
          updatePinOnMap();
        }
      });
      setSourceAndDestinationIcons();
      setInitialLocation();
    } else {
      driverId = Get.arguments[1];
      driverName = Get.arguments[2];
      driverCover = Get.arguments[3];
      driverLat = double.parse(Get.arguments[4]);
      driverLng = double.parse(Get.arguments[5]);
      userLat = double.parse(Get.arguments[6]);
      userLng = double.parse(Get.arguments[7]);
      driverMobile = Get.arguments[8];
      driverAmountPay = Get.arguments[9];
      payMethod = Get.arguments[10];

      destinationLocation =
          LocationData.fromMap({"latitude": userLat, "longitude": userLng});
      var destPosition = LatLng(userLat, userLng);
      initialCameraPosition = CameraPosition(
          zoom: cameraZoom,
          tilt: cameraTilt,
          bearing: cameraBearing,
          target: destPosition);
      initialCameraPosition = CameraPosition(
          target: LatLng(driverLat, driverLng),
          zoom: cameraZoom,
          tilt: cameraTilt,
          bearing: cameraBearing);
      location = Location();
      polylinePoints = PolylinePoints();
      updatePinOnMap();
      setSourceAndDestinationIcons();
      setInitialLocation();
      getDriverInfo();
    }
  }

  Future<void> getDriverInfo() async {
    debugPrint('get driver info');
    Response response = await parser.getDriverInfo(driverId);
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic driverInfo = myMap["data"];
      driverLat = double.parse(driverInfo['lat']);
      driverLng = double.parse(driverInfo['lng']);
      currentLocation =
          LocationData.fromMap({"latitude": driverLat, "longitude": driverLng});
      updatePinOnMap();
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  void cancelLocationSubscription() {
    isLocationClosed = true;
    locationSubscription.cancel();
    update();
  }

  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: cameraZoom,
      tilt: cameraTilt,
      bearing: cameraBearing,
      target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
    );

    final GoogleMapController controller = await googleMapsController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    var pinPosition =
        LatLng(currentLocation.latitude!, currentLocation.longitude!);

    sourcePinInfo.location = pinPosition;

    markers.removeWhere((m) => m.markerId.value == 'sourcePin');
    markers.add(Marker(
        markerId: const MarkerId('sourcePin'),
        onTap: () {
          currentlySelectedPin = sourcePinInfo;
          pinPillPosition = 0;
          update();
        },
        position: pinPosition, // updated position
        icon: sourceIcon));
    update();
  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(100, 100)),
            'assets/images/bike.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(100, 100)),
            'assets/images/dest.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }

  void setInitialLocation() async {
    currentLocation = await location.getLocation();
    destinationLocation = LocationData.fromMap({
      "latitude": destinationLocation.latitude,
      "longitude": destinationLocation.longitude
    });
  }

  void showPinsOnMap() {
    var pinPosition =
        LatLng(currentLocation.latitude!, currentLocation.longitude!);
    var destPosition =
        LatLng(destinationLocation.latitude!, destinationLocation.longitude!);

    sourcePinInfo = PinInformation(
        locationName: "Start Location".tr,
        location: pinPosition,
        pinPath: "assets/images/bike.png",
        avatarPath: "assets/images/bike.png",
        labelColor: Colors.blueAccent);

    destinationPinInfo = PinInformation(
        locationName: "End Location".tr,
        location: destPosition,
        pinPath: "assets/images/dest.png",
        avatarPath: "assets/images/dest.png",
        labelColor: Colors.purple);

    markers.add(Marker(
        markerId: const MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          currentlySelectedPin = sourcePinInfo;
          pinPillPosition = 0;
          update();
        },
        icon: sourceIcon));
    // destination pin
    markers.add(Marker(
        markerId: const MarkerId('destPin'),
        position: destPosition,
        onTap: () {
          currentlySelectedPin = destinationPinInfo;
          pinPillPosition = 0;
          update();
        },
        icon: destinationIcon));
    setPolylines();
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(currentLocation.latitude!, currentLocation.longitude!),
      PointLatLng(
          destinationLocation.latitude!, destinationLocation.longitude!),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      polylines.add(Polyline(
          width: 10, // set the width of the polylines
          polylineId: const PolylineId("poly"),
          color: Colors.red,
          points: polylineCoordinates));
      debugPrint(result.points.toString());
      update();
    }
  }

  void openActionModalStore() {
    var context = Get.context as BuildContext;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Contact '.tr + storeName),
        actions: [
          CupertinoActionSheetAction(
            child: Text('Call'.tr),
            onPressed: () {
              Navigator.pop(context);
              makePhoneCall();
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Cancel'.tr,
              style: const TextStyle(fontFamily: 'bold', color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void openDriverModal() {
    var context = Get.context as BuildContext;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Contact '.tr + driverName),
        actions: [
          CupertinoActionSheetAction(
            child: Text('Call'.tr),
            onPressed: () {
              Navigator.pop(context);
              makePhoneCall();
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Cancel'.tr,
              style: const TextStyle(fontFamily: 'bold', color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: googleMapsType == 'store' ? storeMobile : driverMobile,
    );
    await launchUrl(launchUri);
  }
}
