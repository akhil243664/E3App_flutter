// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/admitedoffersModal.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:cashfuse/widget/web/webDrawerWidget.dart';
import 'package:cashfuse/widget/ratesAndOfferTermsSheetWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class WebAdmitedDetailScreen extends StatefulWidget {
  final bool? fromSeeMore;
  final AdmitedOffersModal? admitedData;
  WebAdmitedDetailScreen({this.fromSeeMore, this.admitedData});

  @override
  State<WebAdmitedDetailScreen> createState() =>
      _WebAdmitedDetailScreenState(this.admitedData!);
}

class _WebAdmitedDetailScreenState extends State<WebAdmitedDetailScreen> {
  HomeController homeController = Get.find<HomeController>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  AdmitedOffersModal admitedData;
  double _scrollingRate = 0.0;

  _WebAdmitedDetailScreenState(this.admitedData) : super();

  @override
  void initState() {
    // _admitedOffers = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController1) {
      return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          drawer: global.getPlatFrom() ? WebDrawerWidget() : null,
          appBar: global.getPlatFrom()
              ? WebTopBarWidget(
                  scaffoldKey: scaffoldKey,
                )
              : null,
          body: Center(
            child: SizedBox(
              width: AppConstants.WEB_MAX_WIDTH,
              child: CustomScrollView(
                slivers: [
                  global.getPlatFrom()
                      ? SliverToBoxAdapter(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                color: Colors.white,
                                width: AppConstants.WEB_MAX_WIDTH,
                                alignment: Alignment.center,
                                //margin: EdgeInsets.only(bottom: 20),
                                child: CustomImage(
                                  image:
                                      '${global.appInfo.baseUrls!.offerImageUrl}/${admitedData.image}',
                                  width: 500,
                                  height: 300,
                                  fit: BoxFit.fill,
                                  admitedOffersModal: admitedData,
                                ),
                                // Image.asset(
                                //   Images.dummyImage,
                                //   width: Get.width,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              Positioned(
                                bottom: -30,
                                child: Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.all(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CustomImage(
                                      image:
                                          '${global.appInfo.baseUrls!.partnerImageUrl}/${admitedData.partner!.image}',
                                      height: 30,
                                      width: 60,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : SliverAppBar(
                          expandedHeight: 170,
                          collapsedHeight: 50.0,
                          toolbarHeight: 50,
                          floating: true,
                          pinned: true,
                          elevation: 0,
                          backgroundColor: _scrollingRate == 1.0
                              ? Get.theme.primaryColor
                              : Colors.transparent,
                          // backgroundColor: Get.theme.primaryColor,
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          title: Text(
                            admitedData.partner!.name!,
                            style: Get.theme.primaryTextTheme.titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                          flexibleSpace: CustomizableSpaceBar(
                              builder: (context, scrollingRate) {
                            Future.delayed(Duration.zero).then(
                              (value) {
                                _scrollingRate = scrollingRate;
                                setState(() {});
                              },
                            );
                            return (scrollingRate != 1.0)
                                ? Stack(
                                    alignment: Alignment.bottomCenter,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        //margin: EdgeInsets.only(bottom: 20),
                                        child: CustomImage(
                                          image:
                                              '${global.appInfo.baseUrls!.offerImageUrl}/${admitedData.image}',
                                          width: Get.width,
                                          fit: BoxFit.fill,
                                          admitedOffersModal: admitedData,
                                        ),
                                        // Image.asset(
                                        //   Images.dummyImage,
                                        //   width: Get.width,
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                      Positioned(
                                        bottom: -30,
                                        child: Card(
                                          color: Colors.white,
                                          margin: EdgeInsets.all(10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: CustomImage(
                                              image:
                                                  '${global.appInfo.baseUrls!.partnerImageUrl}/${admitedData.partner!.image}',
                                              height: 30,
                                              width: 60,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : SizedBox();
                          }),
                          actions: [
                            !GetPlatform.isWeb
                                ? InkWell(
                                    onTap: () async {
                                      if (global.currentUser.id != null) {
                                        await homeController.getTrackingLink(
                                          admitedData.gotourl!,
                                          admitedData.affiliatePartner!,
                                          cId: admitedData.adId.toString(),
                                        );
                                        global.share(
                                          homeController.createdLink.isNotEmpty
                                              ? homeController.createdLink
                                              : admitedData.gotourl!,
                                          admitedData.image!.isNotEmpty &&
                                                  !admitedData.isImageError!
                                              ? '${global.appInfo.baseUrls!.offerImageUrl}/${admitedData.image}'
                                              : '',
                                          '',
                                        );
                                      } else {
                                        if (global.getPlatFrom()) {
                                          Get.dialog(Dialog(
                                            child: SizedBox(
                                              width: Get.width / 3,
                                              child: GetStartedScreen(
                                                fromMenu: true,
                                              ),
                                            ),
                                          ));
                                        } else {
                                          Get.to(
                                            () => GetStartedScreen(
                                              fromMenu: true,
                                            ),
                                            routeName: 'login',
                                          );
                                        }
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      padding:
                                          EdgeInsets.only(left: 10, right: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.green[500],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                              '${AppLocalizations.of(context)!.share}  '),
                                          CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.green[700],
                                            child: Icon(
                                              Icons.share_outlined,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox()
                          ],
                        ),
                  SliverToBoxAdapter(
                    // fillOverscroll: true,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                admitedData.name!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Get.theme.primaryColor),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              HtmlWidget(
                                admitedData.description!,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (global.currentUser.id != null) {
                                    await homeController.getTrackingLink(
                                        admitedData.gotourl!,
                                        admitedData.affiliatePartner!,
                                        cId: admitedData.adId.toString());
                                    await homeController.addClick(
                                      admitedData.name!,
                                      global.appInfo.baseUrls!.offerImageUrl! +
                                          '/' +
                                          admitedData.image!,
                                      homeController.createdLink.isNotEmpty
                                          ? homeController.createdLink
                                          : admitedData.gotourl!,
                                    );

                                    global.launchInBrowser(
                                      homeController.createdLink.isNotEmpty
                                          ? homeController.createdLink
                                          : admitedData.gotourl!,
                                    );
                                  } else {
                                    if (global.getPlatFrom()) {
                                      Get.dialog(Dialog(
                                        child: SizedBox(
                                          width: Get.width / 3,
                                          child: GetStartedScreen(
                                            fromMenu: true,
                                          ),
                                        ),
                                      ));
                                    } else {
                                      Get.to(
                                        () => GetStartedScreen(
                                          fromMenu: true,
                                        ),
                                        routeName: 'login',
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  color: Colors.white,
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 45,
                                    width: global.getPlatFrom()
                                        ? Get.width / 3
                                        : Get.width,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Get.theme.secondaryHeaderColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!.grab_now,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Get.theme.secondaryHeaderColor,
                                    radius: 10,
                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      DottedLine(
                                        lineLength: 130,
                                        dashColor: Colors.grey,
                                      ),
                                      Card(
                                        margin: EdgeInsets.zero,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero),
                                        child: Text(
                                          '>>',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 20,
                                              letterSpacing: -5),
                                        ),
                                      )
                                    ],
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        Get.theme.secondaryHeaderColor,
                                    radius: 10,
                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Purchase',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          'Today',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Cashback tracks in',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          '24 hours',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              widget.fromSeeMore!
                                  ? SizedBox()
                                  : homeController.seeMoreCampaignList !=
                                              null &&
                                          homeController
                                                  .seeMoreCampaignList.length >
                                              0
                                      ? InkWell(
                                          onTap: () async {
                                            //await homeController.getMoreCampaign(campaign.id.toString());
                                            global.getPlatFrom()
                                                ? Get.dialog(
                                                    Dialog(
                                                      child: SizedBox(
                                                        height: 500,
                                                        width: 500,
                                                        // child:
                                                        //     MoreAdmitedOffers(
                                                        //   id: widget
                                                        //       .admitedData['id']
                                                        //       .toString(),
                                                        // ),
                                                      ),
                                                    ),
                                                  )
                                                : Get.bottomSheet(
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        topRight:
                                                            Radius.circular(15),
                                                      ),
                                                      // child: MoreAdmitedOffers(
                                                      //   id: widget
                                                      //       .admitedData['id']
                                                      //       .toString(),
                                                      // ),
                                                    ),
                                                  );
                                          },
                                          child: Container(
                                            width: Get.width,
                                            alignment: Alignment.center,
                                            color: Colors.white,
                                            child: Container(
                                              width: global.getPlatFrom()
                                                  ? Get.width / 3
                                                  : Get.width,
                                              height: 45,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 15),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 7, vertical: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Colors.teal[200]!,
                                                    width: 1.5,
                                                  )),
                                              alignment: Alignment.center,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .see_more_offers,
                                                style: TextStyle(
                                                    color: Colors.teal[200],
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: admitedData.partner != null &&
                      (admitedData.partner!.leftTab != null &&
                          admitedData.partner!.leftTab!.isNotEmpty) ||
                  (admitedData.partner!.rightTab != null &&
                      admitedData.partner!.rightTab!.isNotEmpty)
              ? Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  height: 50,
                  child: SizedBox(
                    height: 50,
                    width: AppConstants.WEB_MAX_WIDTH,
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      color: Get.theme.primaryColor,
                      child: Row(
                        mainAxisAlignment: (admitedData.partner!.leftTab !=
                                        null &&
                                    admitedData.partner!.leftTab!.isNotEmpty) ||
                                (admitedData.partner!.rightTab != null &&
                                    admitedData.partner!.rightTab!.isNotEmpty)
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.find<HomeController>().setIsOffer(false);
                              Get.bottomSheet(
                                SizedBox(
                                  width: AppConstants.WEB_MAX_WIDTH,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: RatesAndOfferTermsSheetWidget(
                                      partner: admitedData.partner!,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              admitedData.partner!.leftTab!,
                              style: Get.theme.primaryTextTheme.titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                            ),
                          ),
                          (admitedData.partner!.leftTab != null &&
                                      admitedData
                                          .partner!.leftTab!.isNotEmpty) ||
                                  (admitedData.partner!.rightTab != null &&
                                      admitedData.partner!.rightTab!.isNotEmpty)
                              ? Icon(
                                  Icons.more_vert,
                                  size: 22,
                                  color: Colors.white.withOpacity(0.3),
                                )
                              : SizedBox(),
                          InkWell(
                            onTap: () {
                              Get.find<HomeController>().setIsOffer(true);
                              Get.bottomSheet(
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: RatesAndOfferTermsSheetWidget(
                                    partner: admitedData.partner!,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              admitedData.partner!.rightTab!.camelCase!,
                              style: Get.theme.primaryTextTheme.titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ),
      );
    });
  }
}
