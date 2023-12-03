// import 'package:cashfuse/controllers/splashController.dart';
import 'dart:convert';

import 'package:cashfuse/controllers/couponController.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

HomeController homeController = Get.find<HomeController>();
CouponController couponController = Get.find<CouponController>();

class CountrySelectWidget extends StatefulWidget {
  const CountrySelectWidget() : super();

  @override
  State<CountrySelectWidget> createState() => _CountrySelectWidgetState();
}

class _CountrySelectWidgetState extends State<CountrySelectWidget> {
  @override
  Widget build(BuildContext context) {
    // log(homeController.isHomeDataLoaded().toString());
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          // alignment: Alignment.topCenter,
          // clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: () async {
                global.showCountryPopUp = false;
                setState(() {});
                Get.to(() => BottomNavigationBarScreen(),
                    preventDuplicates: false, routeName: 'home');
              },
              child: CircleAvatar(
                radius: 15,
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 20,
                ),
                backgroundColor: Colors.white,
              ),
            ),
            Container(
              width: global.getPlatFrom() ? Get.width / 4 : Get.width / 1.3,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  global.country == null &&
                          global.countrySlug.isEmpty &&
                          global.appInfo.countryselection == 1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Divider(
                            height: 0,
                            thickness: 0.9,
                          ),
                        )
                      : SizedBox(),
                  global.appInfo.countryselection == 1
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text('Please select country from below list',
                            style:
                                Get.theme.primaryTextTheme.bodySmall!.copyWith(
                              // fontWeight: FontWeight.w600,
                              color: Colors.red,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : SizedBox(),
                  global.appInfo.countryselection == 1
                      ? ListView.builder(
                          padding: EdgeInsets.only(top: 5),
                          shrinkWrap: true,
                          itemCount: global.appInfo.countries!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(global
                                      .appInfo.countries![index].countryName!),
                                ),
                                Radio(
                                  groupValue: global.country,
                                  value: global.appInfo.countries![index],
                                  onChanged: (value) async {
                                    if (value != null) {
                                       Get.to(() => BottomNavigationBarScreen(),
                                          preventDuplicates: false,
                                          routeName: 'home');
                                      global.country = value;
                                      global.appInfo.countries!
                                          .map((e) => e.isSelected = false)
                                          .toList();
                                      global.appInfo.countries![index]
                                          .isSelected = true;

                                      global.showCountryPopUp = false;
                                      homeController.isDataAvailable = false;

                                      setState(() {});

                                      global.country = value;
                                      global.countrySlug =
                                          global.country!.slug!;
                                      await global.sp!.setString(
                                          'country',
                                          json.encode(
                                              global.country!.toJson()));
                                      await global.sp!.setString(
                                          'countrySlug', global.countrySlug);

                                      setState(() {});

                                      homeController.topBannerList = [];
                                      homeController.topCategoryList = [];
                                      couponController.couponList = [];
                                      homeController.topCashbackList = [];
                                      homeController.exclusiveOfferList = [];
                                      homeController.productList = [];
                                      homeController.trendingProductList = [];
                                      homeController.newFlashOfferList = [];
                                      homeController.homeAdvList = [];
                                      homeController.allAdvList = [];

                                      await couponController.getCouponList();
                                      await homeController.init();

                                      setState(() {});
                                     
                                    }
                                  },
                                )
                              ],
                            );
                          },
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
