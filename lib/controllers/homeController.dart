// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/authController.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/models/admitedoffersModal.dart';
import 'package:cashfuse/models/adsModel.dart';
import 'package:cashfuse/models/bannerModel.dart';
import 'package:cashfuse/models/campaignModel.dart';
import 'package:cashfuse/models/categoryModel.dart';
import 'package:cashfuse/models/clickModel.dart';
import 'package:cashfuse/models/commonModel.dart';
import 'package:cashfuse/models/offerModel.dart';
import 'package:cashfuse/models/productModel.dart';
import 'package:cashfuse/services/apiHelper.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/widget/customLoader.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  APIHelper apiHelper = new APIHelper();
  NetworkController networkController = Get.put(NetworkController());
  List<CategoryModel> topCategoryList = [];

  List<CategoryModel> topCashbackList = [];

  List<CategoryModel> homeAdvList = [];

  List<CategoryModel> allAdvList = [];

  List<OfferModel> exclusiveOfferList = [];

  List<OfferModel> newFlashOfferList = [];

  List<BannerModel> topBannerList = [];

  List<ClickModel> recentClickList = [];

  List<CampaignModel> seeMoreCampaignList = [];

  List<AdmitedOffersModal> seeMoreAdmitedList = [];

  List<OfferModel> seeMoreOfferList = [];

  List<AdsModel> seeMoreAdsList = [];

  OfferModel offer = new OfferModel();

  AdsModel ads = new AdsModel();

  CampaignModel campaign = new CampaignModel();

  AdmitedOffersModal admitedOffer = new AdmitedOffersModal();

  List<ProductModel> productList = [];

  List<ProductModel> trendingProductList = [];

  bool isCategoryLoaded = false;
  bool isBannerLoaded = false;
  bool isTopCashbackLoaded = false;
  bool isOfferLoaded = false;
  bool isHomeAdvLoaded = false;
  bool isFlashOffersLoaded = false;
  bool isProductsLoaded = false;
  bool isTrendingProductsLoaded = false;

  bool isCategoryExpand = false;
  bool isRoted = true;
  bool isOffer = false;
  int webBottomIndex = 0;
  int bannerIndex = 0;
  int page = 1;
  int catPage = 0;

  var isMoreDataAvailable = true.obs;
  var isAllDataLoaded = false.obs;
  var isClickDataLoaded = false.obs;

  String createdLink = '';
  ScrollController catScrollController = ScrollController();

  int catPageListIndex = 0;

  bool isDataAvailable = true;

  @override
  void onInit() async {
    await init();

    super.onInit();
  }

  bool isExist = false;

  init() async {
    try {
      if (global.appInfo.baseUrls == null) {
        await apiHelper.getAppInfo().then((response) {
          if (response.statusCode == 200) {
            global.appInfo = response.data;
            update();
          }
        });
      }

      if (global.country != null) {
        await getTopBanners();

        await getTopCategories();
        await getTopCashBack();
        await getProducts();
        await getTrendingProducts();

        await getExclusiveOffers();

        await getNewFlashOffers();
        await getHomeAdv();

        await getAllAdv();
        if (global.currentUser.id != null) {
          await getClick();
          await Get.find<AuthController>().getProfile();
        }
      }
      // catPage = 1;
    } catch (e) {
      print("Exception - HomeController.dart - _init():" + e.toString());
    }
  }

  bool isHomeDataLoaded() {
    try {
      if (topBannerList != null &&
          topBannerList.length > 0 &&
          topCategoryList != null &&
          topCashbackList.length > 0 &&
          topCashbackList != null &&
          topCashbackList.length > 0 &&
          productList != null &&
          productList.length > 0 &&
          trendingProductList != null &&
          trendingProductList.length > 0 &&
          homeAdvList != null &&
          homeAdvList.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Exception - HomeController.dart - isHomeDataLoaded():" +
          e.toString());
      return true;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCategoryExpand(bool val) {
    isCategoryExpand = val;
    update();
  }

  void setIsOffer(bool val) {
    isOffer = val;
    update();
  }

  void setWebBottomIndex(int val) {
    webBottomIndex = val;
    update();
  }

  void updtaeRotate(bool val) async {
    isRoted = val;
    update();
  }

  void setBannerIndex(int val) {
    bannerIndex = val;
    update();
  }

  Future getTopCategories() async {
    try {
      isCategoryLoaded = false;
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        if (topCategoryList != null &&
            topCategoryList != [] &&
            topCategoryList.length > 0) {
          catPage++;
        } else {
          catPage = 1;
        }

        await apiHelper.getTopCategory(catPage).then((response) {
          if (response.statusCode == 200) {
            List<CategoryModel> _tCatList = response.data;
            if (_tCatList.isEmpty) {
              isMoreDataAvailable.value = false;
              isAllDataLoaded.value = true;
            } else {
              topCategoryList.addAll(_tCatList);

              if (global.country != null &&
                  global.countrySlug.isNotEmpty &&
                  topCategoryList != null &&
                  topCategoryList.length > 0) {
                isDataAvailable = true;
              } else if (isDataAvailable) {
                isDataAvailable = true;
              } else {
                isDataAvailable = false;
              }

              update();

              if (topCategoryList != []) {
                for (var i = 0; i < topCategoryList.length; i++) {
                  // topCategoryList[i].commonList = [];
                  if (topCategoryList[i].ads != []) {
                    List<AdsModel> _tList = topCategoryList[i]
                        .ads!
                        .where((element) => element.status == 1)
                        .toList();
                    if (_tList != null && _tList.length > 0) {
                      for (var j = 0; j < _tList.length; j++) {
                        topCategoryList[i].commonList.add(
                              CommonModel(
                                  name: _tList[j].name!,
                                  image:
                                      '${global.appInfo.baseUrls!.offerImageUrl}/${_tList[j].image}',
                                  buttonText: _tList[j].buttonText!,
                                  trackingLink: _tList[j].landingPage!,
                                  adId: _tList[j].id.toString(),
                                  from: "ads"),
                            );
                      }
                    }
                  }

                  if (topCategoryList[i].cuecampaigns != []) {
                    List<CampaignModel> _tList = topCategoryList[i]
                        .cuecampaigns!
                        .where((element) => element.status == 1)
                        .toList();

                    if (_tList != null && _tList.length > 0) {
                      for (var k = 0; k < _tList.length; k++) {
                        topCategoryList[i].commonList.add(
                              CommonModel(
                                  name: _tList[k].name!,
                                  image:
                                      '${global.appInfo.baseUrls!.offerImageUrl}/${_tList[k].image}',
                                  buttonText: _tList[k].buttonText!,
                                  trackingLink: _tList[k].url!,
                                  campaignId: _tList[k].id!,
                                  from: "cue"),
                            );
                      }
                    }
                  }

                  if (topCategoryList[i].admitedoffers != []) {
                    List<AdmitedOffersModal> _tList = topCategoryList[i]
                        .admitedoffers!
                        .where((element) => element.status == 1)
                        .toList();
                    if (_tList != null && _tList.length > 0) {
                      for (var k = 0; k < _tList.length; k++) {
                        topCategoryList[i].commonList.add(
                              CommonModel(
                                  name: _tList[k].name!,
                                  image:
                                      '${global.appInfo.baseUrls!.offerImageUrl}/${_tList[k].image}',
                                  buttonText: "Grab Now",
                                  trackingLink: _tList[k].gotourl!,
                                  campaignId: _tList[k].id!,
                                  from: "admit"),
                            );
                      }
                    }
                  }
                }
              }
            }
          } else {
            showCustomSnackBar(response.message);
          }
        });
        isCategoryLoaded = true;
        update();
      } else {
        isCategoryLoaded = true;
        update();
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      isCategoryLoaded = true;
      update();
      print("Exception - HomeController.dart - getTopCategories():" +
          e.toString());
    }
  }

  Future getTopCashBack() async {
    try {
      isTopCashbackLoaded = false;

      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.getTopCashBack().then((response) {
          if (response.statusCode == 200) {
            topCashbackList = response.data;

            if (global.country != null &&
                global.countrySlug.isNotEmpty &&
                topCashbackList != null &&
                topCashbackList.length > 0) {
              isDataAvailable = true;
            } else if (isDataAvailable) {
              isDataAvailable = true;
            } else {
              isDataAvailable = false;
            }

            update();
            if (topCashbackList != []) {
              for (var i = 0; i < topCashbackList.length; i++) {
                // topCategoryList[i].commonList = [];
                if (topCashbackList[i].ads != []) {
                  List<AdsModel> _tList = topCashbackList[i]
                      .ads!
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var j = 0; j < _tList.length; j++) {
                      topCashbackList[i].commonList.add(
                            CommonModel(
                                name: _tList[j].name!,
                                image:
                                    '${global.appInfo.baseUrls!.offerImageUrl}/${_tList[j].image}',
                                buttonText: _tList[j].buttonText!,
                                trackingLink: _tList[j].landingPage!,
                                adId: _tList[j].id.toString(),
                                from: "ads"),
                          );
                    }
                  }
                }

                if (topCashbackList[i].cuecampaigns != []) {
                  List<CampaignModel> _tList = topCashbackList[i]
                      .cuecampaigns!
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var k = 0; k < _tList.length; k++) {
                      topCashbackList[i].commonList.add(
                            CommonModel(
                                name: _tList[k].name!,
                                image:
                                    '${global.appInfo.baseUrls!.offerImageUrl}/${_tList[k].image}',
                                buttonText: _tList[k].buttonText!,
                                trackingLink: _tList[k].url!,
                                campaignId: _tList[k].id!,
                                from: "cue"),
                          );
                    }
                  }
                }

                if (topCashbackList[i].admitedoffers != []) {
                  List<AdmitedOffersModal> _tList = topCashbackList[i]
                      .admitedoffers!
                      .where((element) => element.status == 1)
                      .toList();

                  if (_tList != null && _tList.length > 0) {
                    for (var p = 0; p < _tList.length; p++) {
                      topCashbackList[i].commonList.add(
                            CommonModel(
                                name: _tList[p].name!,
                                image:
                                    '${global.appInfo.baseUrls!.offerImageUrl}/${_tList[p].image}',
                                buttonText: 'Grab Now',
                                trackingLink: _tList[p].gotourl!,
                                campaignId: _tList[p].id!,
                                from: "admit"),
                          );
                    }
                  }
                }
              }
            }
          } else {
            showCustomSnackBar(response.message);
          }
        });
        isTopCashbackLoaded = true;
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      isTopCashbackLoaded = true;
      update();
      print(
          "Exception - HomeController.dart - getTopCashBack():" + e.toString());
    }
  }

  Future getHomeAdv() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.getHomeAdv().then((response) {
          if (response.statusCode == 200) {
            homeAdvList = response.data;

            if (global.country != null &&
                global.countrySlug.isNotEmpty &&
                homeAdvList != null &&
                homeAdvList.length > 0) {
              isDataAvailable = true;
            } else if (isDataAvailable) {
              isDataAvailable = true;
            } else {
              isDataAvailable = false;
            }

            if (homeAdvList != []) {
              for (var i = 0; i < homeAdvList.length; i++) {
                if (homeAdvList[i].ads != []) {
                  List<AdsModel> _tList = homeAdvList[i]
                      .ads!
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var j = 0; j < _tList.length; j++) {
                      homeAdvList[i].commonList.add(
                            CommonModel(
                              name: _tList[j].name!,
                              image: _tList[j].image!,
                              buttonText: _tList[j].buttonText!,
                              trackingLink: _tList[j].landingPage!,
                              adId: _tList[j].id.toString(),
                            ),
                          );
                    }
                  }
                }

                if (homeAdvList[i].cuecampaigns != []) {
                  List<CampaignModel> _tList = homeAdvList[i]
                      .cuecampaigns!
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var k = 0; k < _tList.length; k++) {
                      homeAdvList[i].commonList.add(
                            CommonModel(
                              name: _tList[k].name!,
                              image: _tList[k].image!,
                              buttonText: _tList[k].buttonText!,
                              trackingLink: _tList[k].url!,
                              campaignId: _tList[k].id!,
                            ),
                          );
                    }
                  }
                }

                if (homeAdvList[i].admitedoffers != []) {
                  List<AdmitedOffersModal> _tList = homeAdvList[i]
                      .admitedoffers!
                      .where((element) => element.status == 1)
                      .toList();
                  if (_tList != null && _tList.length > 0) {
                    for (var p = 0; p < _tList.length; p++) {
                      homeAdvList[i].commonList.add(
                            CommonModel(
                                name: _tList[p].name!,
                                image: _tList[p].image!,
                                buttonText: 'Grab Now',
                                trackingLink: _tList[p].gotourl!,
                                campaignId: _tList[p].id!,
                                from: "admit"),
                          );
                    }
                  }
                }
              }
            }
          } else {
            showCustomSnackBar(response.message);
          }
        });
        isHomeAdvLoaded = true;
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      isHomeAdvLoaded = true;
      update();
      print("Exception - HomeController.dart - getHomeAdv():" + e.toString());
    }
  }

  Future getAllAdv() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        if (allAdvList.length > 0) {
          page++;
        } else {
          page = 1;
        }
        await apiHelper.getAllAdv(page).then((response) {
          if (response.statusCode == 200) {
            List<CategoryModel> _tList = response.data;
            if (_tList.isEmpty) {
              isMoreDataAvailable.value = false;
            } else {
              allAdvList.addAll(_tList);

              update();
              if (allAdvList != []) {
                for (var i = 0; i < allAdvList.length; i++) {
                  if (allAdvList[i].ads != []) {
                    List<AdsModel> _tList = allAdvList[i]
                        .ads!
                        .where((element) => element.status == 1)
                        .toList();
                    if (_tList != null && _tList.length > 0) {
                      for (var j = 0; j < _tList.length; j++) {
                        allAdvList[i].commonList.add(
                              CommonModel(
                                name: _tList[j].name!,
                                image:
                                    '${global.appInfo.baseUrls!.offerImageUrl}/${_tList[j].image}',
                                buttonText: _tList[j].buttonText!,
                                trackingLink: _tList[j].landingPage!,
                                adId: _tList[j].id.toString(),
                              ),
                            );
                      }
                    }
                  }
                  if (allAdvList[i].cuecampaigns != []) {
                    List<CampaignModel> _tList = allAdvList[i]
                        .cuecampaigns!
                        .where((element) => element.status == 1)
                        .toList();
                    if (_tList != null && _tList.length > 0) {
                      for (var k = 0; k < _tList.length; k++) {
                        allAdvList[i].commonList.add(
                              CommonModel(
                                name: _tList[k].name!,
                                image:
                                    '${global.appInfo.baseUrls!.offerImageUrl}/${_tList[k].image}',
                                buttonText: _tList[k].buttonText!,
                                trackingLink: _tList[k].url!,
                                campaignId: _tList[k].id!,
                              ),
                            );
                      }
                    }
                  }
                  if (allAdvList[i].admitedoffers != []) {
                    List<AdmitedOffersModal> _tList = allAdvList[i]
                        .admitedoffers!
                        .where((element) => element.status == 1)
                        .toList();
                    if (_tList != null && _tList.length > 0) {
                      for (var p = 0; p < _tList.length; p++) {
                        allAdvList[i].commonList.add(
                              CommonModel(
                                  name: _tList[p].name!,
                                  image:
                                      '${global.appInfo.baseUrls!.offerImageUrl}/${_tList[p].image}',
                                  buttonText: 'Grab Now',
                                  trackingLink: _tList[p].gotourl!,
                                  campaignId: _tList[p].id!,
                                  from: "admit"),
                            );
                      }
                    }
                  }
                }
              }
            }

            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - getAllAdv():" + e.toString());
    }
  }

  Future getExclusiveOffers() async {
    try {
      isOfferLoaded = false;
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.getExclusiveOffers().then((response) {
          if (response.statusCode == 200) {
            exclusiveOfferList = response.data;

            if (global.country != null &&
                global.countrySlug.isNotEmpty &&
                exclusiveOfferList != null &&
                exclusiveOfferList.length > 0) {
              isDataAvailable = true;
            } else if (isDataAvailable) {
              isDataAvailable = true;
            } else {
              isDataAvailable = false;
            }

            if (exclusiveOfferList != null && exclusiveOfferList.length > 0) {
              for (var i = 0; i < exclusiveOfferList.length; i++) {
                int diff;
                if (exclusiveOfferList[i].endDate != null) {
                  diff = exclusiveOfferList[i]
                      .endDate!
                      .difference(DateTime.now())
                      .inDays;
                  print(diff);
                  exclusiveOfferList[i].dayDifference = diff;
                }
              }
            }
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isOfferLoaded = true;
      update();
    } catch (e) {
      isOfferLoaded = true;
      update();
      print("Exception - HomeController.dart - getExclusiveOffers():" +
          e.toString());
    }
  }

  Future getNewFlashOffers() async {
    try {
      isFlashOffersLoaded = false;
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.getNewFlashOffers().then((response) {
          if (response.statusCode == 200) {
            newFlashOfferList = response.data;

            if (global.country != null &&
                global.countrySlug.isNotEmpty &&
                newFlashOfferList != null &&
                newFlashOfferList.length > 0) {
              isDataAvailable = true;
            } else if (isDataAvailable) {
              isDataAvailable = true;
            } else {
              isDataAvailable = false;
            }

            if (newFlashOfferList != null && newFlashOfferList.length > 0) {
              for (var i = 0; i < newFlashOfferList.length; i++) {
                int diff;
                if (newFlashOfferList[i].endDate != null) {
                  diff = newFlashOfferList[i]
                      .endDate!
                      .difference(DateTime.now())
                      .inDays;
                  print(diff);
                  newFlashOfferList[i].dayDifference = diff;
                }
              }
            }
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isFlashOffersLoaded = true;
      update();
    } catch (e) {
      isFlashOffersLoaded = true;
      update();
      print("Exception - HomeController.dart - getNewFlashOffers():" +
          e.toString());
    }
  }

  Future getTopBanners() async {
    try {
      isBannerLoaded = false;
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.getTopBanners().then((response) {
          if (response.statusCode == 200) {
            topBannerList = response.data;

            if (global.country != null &&
                global.countrySlug.isNotEmpty &&
                topBannerList != null &&
                topBannerList.length > 0) {
              isDataAvailable = true;
            } else if (isDataAvailable) {
              isDataAvailable = true;
            } else {
              isDataAvailable = false;
            }

            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
        isBannerLoaded = true;
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      isBannerLoaded = true;
      update();
      print(
          "Exception - HomeController.dart - getTopBanners():" + e.toString());
    }
  }

  Future getOfferDetails(String offerId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getOfferDetails(offerId).then((response) {
          Get.back();
          if (response.statusCode == 200) {
            offer = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
          getMoreOffers(offerId);
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - getOfferDetails():" +
          e.toString());
    }
  }

  Future getAdDetails(String adId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getAdDetails(adId).then((response) {
          Get.back();
          if (response.statusCode == 200) {
            ads = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
          getMoreAds(adId);
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - getAdDetails():" + e.toString());
    }
  }

  Future getCampignDetails(String campaignId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getCampignDetails(campaignId).then((response) {
          Get.back();
          if (response.statusCode == 200) {
            campaign = response.data;

            update();
          } else {
            showCustomSnackBar(response.message);
          }
          getMoreCampaign(campaignId);
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - getCampignDetails():" +
          e.toString());
    }
  }

  Future getAdmitedDetails(int admitedId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getAdmitedOfferDetails(admitedId).then((response) {
          Get.back();
          if (response.statusCode == 200) {
            admitedOffer = response.data;

            // update();
          } else {
            showCustomSnackBar(response.message);
          }
          getMoreAdmited(admitedId.toString());
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print("Exception - HomeController.dart - getAdmitedDetails():" +
          e.toString());
    }
  }

  Future getTrackingLink(String url, String type, {String? cId}) async {
    try {
      createdLink = '';
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper
            .getTrackingLink(url, type, cId: cId != null ? cId : null)
            .then((response) {
          Get.back();
          if (response.statusCode == 200) {
            createdLink = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - getTrackingLink():" +
          e.toString());
    }
  }

  Future addClick(String name, String image, String trackingLink) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        await apiHelper.addClick(name, image, trackingLink).then((response) {
          if (response.statusCode == 200) {
            getClick();
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - addClick():" + e.toString());
    }
  }

  Future getClick() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        isClickDataLoaded.value = false;
        await apiHelper.getClick().then((response) {
          if (response.statusCode == 200) {
            recentClickList = response.data;
            update();
          } else {
            showCustomSnackBar(response.message);
          }
        });
        isClickDataLoaded.value = true;
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - getClick():" + e.toString());
    }
  }

  Future deleteClicks() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.deleteClicks().then((response) {
          Get.back();
          if (response.statusCode == 200) {
            //_recentClickList = response.data;
            showCustomSnackBar(response.message);
            getClick();
          } else {
            showCustomSnackBar(response.message);
          }
        });
        update();
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
    } catch (e) {
      print("Exception - HomeController.dart - deleteClicks():" + e.toString());
    }
  }

  String clickDialogText(ClickModel click) {
    try {
      String value = '';
      if (DateTime.now().difference(click.createdAt!).inDays == 0) {
        value =
            'All is Well\nit will take upto 72 hours to track your rewards till then keep shopping so #yougetmore ';
      } else if (DateTime.now().difference(click.createdAt!).inDays == 1) {
        value =
            'All is Well\nit will take upto 36 hours to track your rewards till then keep shopping so #yougetmore ';
      } else if (DateTime.now().difference(click.createdAt!).inDays == 2) {
        value =
            'All is Well\nit will take upto 24 hours to track your rewards till then keep shopping so #yougetmore';
      } else {
        value =
            "your earnings will show on My Orders Details.\nif you don't see your earnings there , please click below.";
      }
      return value;
    } catch (e) {
      print("Exception - HomeController.dart - clickDialogText():" +
          e.toString());
      return '';
    }
  }

  String clickTime(ClickModel click) {
    try {
      String value = '';
      if (DateTime.now().difference(click.createdAt!).inDays > 0) {
        value = '${DateTime.now().difference(click.createdAt!).inDays} day ago';
      } else if (DateTime.now().difference(click.createdAt!).inHours > 0) {
        value =
            '${DateTime.now().difference(click.createdAt!).inHours} hour ago';
      } else if (DateTime.now().difference(click.createdAt!).inMinutes > 0) {
        value =
            '${DateTime.now().difference(click.createdAt!).inMinutes} min ago';
      } else if (DateTime.now().difference(click.createdAt!).inSeconds > 0) {
        value = 'Just Now';
      }

      return value;
    } catch (e) {
      print("Exception - HomeController.dart - clickTime():" + e.toString());
      return '';
    }
  }

  Future getMoreCampaign(String campaignId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        //Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getMoreCampaign(campaignId).then((response) {
          //Get.back();
          if (response.statusCode == 200) {
            seeMoreCampaignList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print("Exception - HomeController.dart - getMoreCampaign():" +
          e.toString());
    }
  }

  Future getMoreOffers(String offerId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        // Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getMoreOffers(offerId).then((response) {
          //Get.back();
          if (response.statusCode == 200) {
            seeMoreOfferList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print(
          "Exception - HomeController.dart - getMoreOffers():" + e.toString());
    }
  }

  Future getMoreAds(String adId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        //Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getMoreAds(adId).then((response) {
          //Get.back();
          if (response.statusCode == 200) {
            seeMoreAdsList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print("Exception - HomeController.dart - getMoreAds():" + e.toString());
    }
  }

  Future getMoreAdmited(String campaignId) async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        //Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getMoreAmited(campaignId).then((response) {
          //Get.back();
          if (response.statusCode == 200) {
            seeMoreAdmitedList = response.data;
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      update();
    } catch (e) {
      print(
          "Exception - HomeController.dart - getMoreAdmited():" + e.toString());
    }
  }

  Future getProducts() async {
    try {
      isProductsLoaded = false;
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        //Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getProducts().then((response) {
          //Get.back();
          if (response.statusCode == 200) {
            productList = response.data;
            if (global.country != null &&
                global.countrySlug.isNotEmpty &&
                productList != null &&
                productList.length > 0) {
              isDataAvailable = true;
            } else if (isDataAvailable) {
              isDataAvailable = true;
            } else {
              isDataAvailable = false;
            }
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isProductsLoaded = true;
      update();
    } catch (e) {
      print("Exception - HomeController.dart - getProducts():" + e.toString());
    }
  }

  Future getTrendingProducts() async {
    try {
      if (networkController.connectionStatus.value == 1 ||
          networkController.connectionStatus.value == 2) {
        //Get.dialog(CustomLoader(), barrierDismissible: false);
        await apiHelper.getTrendingProducts().then((response) {
          //Get.back();
          if (response.statusCode == 200) {
            trendingProductList = response.data;

            if (global.country != null &&
                global.countrySlug.isNotEmpty &&
                trendingProductList != null &&
                trendingProductList.length > 0) {
              isDataAvailable = true;
            } else if (isDataAvailable) {
              isDataAvailable = true;
            } else {
              isDataAvailable = false;
            }
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        showCustomSnackBar(AppConstants.NO_INTERNET);
      }
      isTrendingProductsLoaded = true;
      update();
    } catch (e) {
      print("Exception - HomeController.dart - getTrendingProducts():" +
          e.toString());
    }
  }
}
