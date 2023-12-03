// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/models/countryModel.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/utils/global.dart' as global;
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  NetworkController networkController = Get.put(NetworkController());

  APIHelper apiHelper = new APIHelper();
  // final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void onInit() async {
    super.onInit();
  }

  Future getLocationPermission() async {
    try {
      await getCurrentLocation();
      // if (GetPlatform.isAndroid) {
      //   PermissionStatus permissionStatus;
      //   permissionStatus = await Permission.location.status;
      //   if (permissionStatus.isDenied) {
      //     permissionStatus = await Permission.location.request();
      //   }
      //   if (permissionStatus.isGranted) {
      //     await getCurrentLocation();
      //   }
      // } else if (GetPlatform.isIOS || GetPlatform.isWeb) {
      //   // Geolocation.getCurrentPosition();
      //   //   LocationPermission s = await Geolocator.checkPermission();
      //   //   if (s == LocationPermission.denied ||
      //   //       s == LocationPermission.deniedForever) {
      //   //     s = await Geolocator.requestPermission();
      //   //   }
      //   //   if (s != LocationPermission.denied &&
      //   //       s != LocationPermission.deniedForever) {
      //   await getCurrentLocation();
      //   // }
      // }
    } catch (e) {
      print("Exceptioin - LocationController.dart - _getLocationPermission():" +
          e.toString());
    }
  }

  getCurrentLocation() async {
    try {
      String _country = '';
      // if (GetPlatform.isWeb) {
      //   // final bool hasPermission = await _handlePermission();

      //   // if (!hasPermission) {
      //   //   showCustomSnackBar('Service not enabled');
      //   // }

      //   // final Position position =
      //   //     await _geolocatorPlatform.getCurrentPosition();

      //   // log(position.toJson().toString());
      //   // await apiHelper
      //   //     .getAddressFromGeocode(position.latitude, position.longitude)
      //   //     .then((response) {
      //   //   if (response != null) {
      //   //     if (response.data['address'] != null &&
      //   //         response.data['address']['country'] != null) {
      //   //       _country = response.data['address']['country'];
      //   //     } else {
      //   //       _country = '';
      //   //     }
      //   //   }
      //   // });
      // } else {
      //   await Geolocator.getCurrentPosition(
      //           desiredAccuracy: LocationAccuracy.best)
      //       .then((Position position) async {
      //     final placemarks = await placemarkFromCoordinates(
      //         position.latitude, position.longitude);
      //     _country = placemarks[0].country!;
      //   });
      // }

      await apiHelper.getAddressFromGeocode().then((response) {
        if (response != null) {
          _country = response;
        } else {
          _country = '';
        }
      });

      List<CountryModel> _tList = global.appInfo.countries!
          .where((element) => element.countryName == _country)
          .toList();
      if (_tList != null && _tList.length > 0) {
        global.country =
            _tList.firstWhere((element) => element.countryName == _country);
        _tList.map((e) => e.isSelected = true).toList();
        global.countrySlug = _tList
            .firstWhere((element) => element.countryName == _country)
            .slug!;

        await global.sp!
            .setString('country', json.encode(global.country!.toJson()));
        await global.sp!.setString('countrySlug', global.countrySlug);
      } else {
        global.showCountryPopUp = true;
      }

      // await Get.find<HomeController>().init();
      update();
    } catch (e) {
      print("Exceptioin - LocationController.dart - getCurrentLocation():" +
          e.toString());
    }
  }

  // Future<bool> _handlePermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.

  //     return false;
  //   }

  //   permission = await _geolocatorPlatform.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await _geolocatorPlatform.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.

  //       return false;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.

  //     return false;
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.

  //   return true;
  // }
}
