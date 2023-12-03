// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'dart:convert';
import 'dart:developer';

import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/authController.dart';
import 'package:cashfuse/controllers/couponController.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/controllers/localizationController.dart';
import 'package:cashfuse/controllers/searchController.dart';
import 'package:cashfuse/l10n/l10n.dart';
import 'package:cashfuse/provider/local_provider.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/views/aboutUsScreen.dart';
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/views/getHelpScreen.dart';
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/views/homeScreen.dart';
import 'package:cashfuse/views/paymentHistoryScreen.dart';
import 'package:cashfuse/views/paymentScreen.dart';
import 'package:cashfuse/views/privacyPolicyScreen.dart';
import 'package:cashfuse/views/recentClicksScreen.dart';
import 'package:cashfuse/views/referralNetworkScreen.dart';
import 'package:cashfuse/views/webScreen/webAccountSettingScreen.dart';
import 'package:cashfuse/views/webScreen/webMyEarningScreen.dart';
import 'package:cashfuse/views/webScreen/webSearchScreen.dart';
import 'package:cashfuse/widget/confirmationDialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:provider/provider.dart';

class WebTopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  WebTopBarWidget({this.scaffoldKey});

  AuthController authController = Get.find<AuthController>();
  HomeController homeController = Get.find<HomeController>();
  CouponController couponController = Get.find<CouponController>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocaleProvider>(context);
    var locale = provider.locale;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      height: 80,
      child: SizedBox(
        width: AppConstants.WEB_MAX_WIDTH,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                scaffoldKey!.currentState!.openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  MdiIcons.sortVariant,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(
                  () => HomeScreen(),
                  routeName: 'home',
                );
              },
              child: Image.asset(
                Images.text_logo,
                height: 35,
                // width: 100,
              ),
            ),
            Expanded(
              flex: 2,
              child:
                  GetBuilder<SearchGetController>(builder: (searchController) {
                return Container(
                  //height: 45,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: searchController.searchString,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search,
                          size: 25, color: Theme.of(context).disabledColor),
                      hintText: 'What do you want to buy today?',
                      border: InputBorder.none,
                    ),
                    onTap: () {
                      Get.dialog(
                          Dialog(
                            child: SizedBox(
                              width: AppConstants.WEB_MAX_WIDTH,
                              child: WebSearchScreen(),
                            ),
                          ),
                          barrierDismissible: false);
                    },
                    onFieldSubmitted: (text) {},
                  ),
                );
              }),
            ),
            Expanded(child: SizedBox()),
            GetBuilder<LocalizationController>(
                builder: (localizationController) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.only(top: 20, right: 10, bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  value: global.languageCode,
                  alignment: AlignmentDirectional.center,
                  elevation: 0,
                  underline: SizedBox(),
                  borderRadius: BorderRadius.circular(10),
                  items:
                      List.generate(L10n.all.length, (index) {
                    return DropdownMenuItem(
                        alignment: AlignmentDirectional.center,
                        value: L10n.all[index].languageCode,
                        child: Text(
                            L10n.languageListName[index]));
                  }),
                  onChanged: (value) {
                    Get.back();
                    Get.to(() => BottomNavigationBarScreen(),
                        preventDuplicates: false, routeName: 'home');
                    homeController.update();
                    // localizationController.setLanguage(value!);
                    // localizationController.refresh();

                    global.languageCode = value!;
                    final provider =
                        Provider.of<LocaleProvider>(context, listen: false);
                    locale = Locale(global.languageCode);
                    provider.setLocale(locale!);
                    global.languageCode = locale!.languageCode;
                    if (global.languageCode == 'ar') {
                      global.isRTL = false;
                    } else {
                      global.isRTL = true;
                    }
                    Get.updateLocale(locale!);
                  },
                ),
              );
            }),
            global.country != null
                ? GetBuilder<HomeController>(
                    builder: (controller) => PopupMenuButton(
                      onSelected: (value) async {
                        if (global.appInfo.countryselection == 1) {
                          Get.to(() => BottomNavigationBarScreen(),
                              preventDuplicates: false, routeName: 'home');
                          global.country = value;
                          global.appInfo.countries!
                              .map((e) => e.isSelected = false)
                              .toList();
                          // global.appInfo.countries![index].isSelected = true;

                          global.showCountryPopUp = false;
                          homeController.isDataAvailable = false;

                          homeController.update();

                          global.country = value;
                          global.countrySlug = global.country!.slug!;
                          await global.sp!.setString(
                              'country', json.encode(global.country!.toJson()));
                          await global.sp!
                              .setString('countrySlug', global.countrySlug);

                          homeController.update();

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

                          homeController.update();
                        }
                      },
                      position: PopupMenuPosition.under,
                      padding: EdgeInsets.zero,
                      child: Container(
                        width: 35,
                        height: 35,
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Get.theme.secondaryHeaderColor),
                        ),
                        child: Text(
                          global.country!.countryCode!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      itemBuilder: (context) {
                        return List.generate(global.appInfo.countries!.length,
                            (index) {
                          return PopupMenuItem(
                            height: 40,
                            value: global.appInfo.countries![index],
                            padding: EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(global
                                      .appInfo.countries![index].countryName!),
                                ),
                                Divider(
                                  height: 0,
                                ),
                              ],
                            ),
                          );
                        });
                      },
                    ),
                  )
                : SizedBox(),
            InkWell(
              onTap: () {
                Get.to(
                  () => GetHelpScreen(),
                  routeName: 'faq',
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(AppLocalizations.of(context)!.how_it_works),
              ),
            ),
            VerticalDivider(
              endIndent: 20,
              indent: 20,
              color: Get.theme.primaryColor,
            ),
            global.currentUser.id != null
                ? InkWell(
                    onTap: () {
                      showAlignedDialog(
                        context: context,
                        builder: _localDialogBuilder,
                        followerAnchor: Alignment.topRight,
                        targetAnchor: Alignment.topRight,
                        barrierColor: Colors.black54,
                        avoidOverflow: true,
                        duration: Duration.zero,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Text(
                            '  My Account',
                          ),
                        ],
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      Get.dialog(Dialog(
                        child: SizedBox(
                            width: Get.width / 3,
                            child: GetStartedScreen(
                              fromMenu: true,
                            )
                            // LoginOrSignUpScreen(
                            //   fromMenu: true,
                            // ),
                            ),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(AppLocalizations.of(context)!.login),
                    ),
                  ),
            global.currentUser.id != null
                ? InkWell(
                    onTap: () {
                      Get.to(
                        () => WebMyEarningSceen(),
                        routeName: 'earning',
                      );
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          Images.payments,
                          height: 25,
                        )),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  success(pos) {
    try {
      print(pos.coords.latitude);
      print(pos.coords.longitude);
    } catch (ex) {
      print("Exception thrown : " + ex.toString());
    }
  }

  WidgetBuilder get _localDialogBuilder {
    return (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Card(
          margin: EdgeInsets.only(top: 70, right: 170),
          child: SizedBox(
            width: 150,
            child: DefaultTextStyle(
              style: Get.theme.primaryTextTheme.titleSmall!,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                        authController.name.text = global.currentUser.name!;
                        authController.email.text = global.currentUser.email!;
                        authController.contactNo.text =
                            global.currentUser.phone!;
                        if (global.currentUser.phone != null &&
                            global.currentUser.phone!.isNotEmpty) {
                          final phoneNumber =
                              PhoneNumber.parse(global.currentUser.phone!);

                          authController.coutryDialCode =
                              '+' + phoneNumber.countryCode;

                          authController.contactNo.text = phoneNumber.nsn;

                          log(phoneNumber.countryCode);
                        }
                        Get.to(
                          () => WebAccountSettingScreen(),
                          routeName: 'account',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.account_settings,
                        style: Get.theme.primaryTextTheme.bodySmall!.copyWith(
                          letterSpacing: 0,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => WebMyEarningSceen(),
                          routeName: 'earning',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.my_earnings,
                        style: Get.theme.primaryTextTheme.bodySmall!.copyWith(
                          letterSpacing: 0,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => PaymentScreen(),
                          routeName: 'payment',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.payments,
                        style: Get.theme.primaryTextTheme.bodySmall!.copyWith(
                          letterSpacing: 0,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => PaymentHistoryScreen(),
                          routeName: 'payment-history',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.payment_history,
                        style: Get.theme.primaryTextTheme.bodySmall!.copyWith(
                          letterSpacing: 0,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => RecentClickScreen(),
                          routeName: 'recent-clicks',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.recents_clicks,
                        style: Get.theme.primaryTextTheme.bodySmall!.copyWith(
                          letterSpacing: 0,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => ReferralNetworkScreen(),
                          routeName: 'referral-network',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.referral_network,
                        style: Get.theme.primaryTextTheme.bodySmall!.copyWith(
                          letterSpacing: 0,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => GetHelpScreen(),
                          routeName: 'faq',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.get_help,
                        style: Get.theme.primaryTextTheme.bodySmall!.copyWith(
                          letterSpacing: 0,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => AboutUsScreen(),
                          routeName: 'about',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.about_us,
                        style: Get.theme.primaryTextTheme.bodySmall!.copyWith(
                          letterSpacing: 0,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => PrivacyPolicyScreen(),
                          routeName: 'privacy',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.privacy_policy,
                        style: Get.theme.primaryTextTheme.bodySmall!.copyWith(
                          letterSpacing: 0,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Get.back();
                        showConfirmationDialog(
                          context,
                          AppLocalizations.of(context)!.logout,
                          AppLocalizations.of(context)!.logout_desc,
                          [
                            CupertinoDialogAction(
                              child: Text(
                                AppLocalizations.of(context)!.yes,
                                style: Get.theme.primaryTextTheme.titleSmall!
                                    .copyWith(color: Colors.red),
                              ),
                              onPressed: () {
                                Get.back();
                                authController.logout();
                                Get.offAll(
                                  () => BottomNavigationBarScreen(),
                                  // preventDuplicates: false,
                                  routeName: 'home',
                                );
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text(
                                AppLocalizations.of(context)!.no,
                                style: Get.theme.primaryTextTheme.titleSmall!
                                    .copyWith(color: Colors.blue),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.logout,
                        style: Get.theme.primaryTextTheme.bodyMedium!.copyWith(
                          letterSpacing: -0.5,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    };
  }

  @override
  Size get preferredSize => Size(
        AppConstants.WEB_MAX_WIDTH,
        85,
      );
}
