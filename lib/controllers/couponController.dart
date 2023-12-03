// ignore_for_file: unnecessary_null_comparison

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/models/couponModel.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:get/get.dart';
import 'package:cashfuse/utils/global.dart' as global;

class CouponController extends GetxController {
  APIHelper apiHelper = new APIHelper();
  NetworkController networkController = Get.find<NetworkController>();
  HomeController homeController = Get.put(HomeController());
  List<Coupon> couponList = [];

  bool isDataLoaded = false;

  @override
  void onInit() async {
    await getCouponList();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getCouponList() async {
    try {
      isDataLoaded = false;
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.getCoupons().then((response) {
          if (response.status == "1") {
            couponList = response.data;

            if (global.country != null &&
                global.countrySlug.isNotEmpty &&
                couponList != null &&
                couponList.length > 0) {
              homeController.isDataAvailable = true;
            } else if (homeController.isDataAvailable) {
              homeController.isDataAvailable = true;
            } else {
              homeController.isDataAvailable = false;
            }

            if (couponList != null && couponList.length > 0) {
              for (var i = 0; i < couponList.length; i++) {
                int diff;
                if (couponList[i].endDate != null) {
                  diff =
                      couponList[i].endDate!.difference(DateTime.now()).inDays;
                  print(diff);
                  couponList[i].dayDifference = diff;
                }
              }
            }
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isDataLoaded = true;
      update();
    } catch (e) {
      isDataLoaded = true;
      update();
      print("Exception - CouponController.dart - getCouponList():" +
          e.toString());
    }
  }
}
