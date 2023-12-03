import 'package:carousel_slider/carousel_slider.dart';
import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/homeController.dart';
import 'package:cashfuse/models/productModel.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/myColors.dart';
import 'package:cashfuse/views/getStartedScreen.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebProductDetailsMobileView extends StatefulWidget {
  final String title;
  final ProductModel product;
  WebProductDetailsMobileView({required this.title, required this.product})
      : super();

  @override
  State<WebProductDetailsMobileView> createState() =>
      _WebProductDetailsMobileViewState(this.product);
}

class _WebProductDetailsMobileViewState
    extends State<WebProductDetailsMobileView> {
  ProductModel product;
  _WebProductDetailsMobileViewState(this.product) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          widget.title,
          style: Get.theme.primaryTextTheme.titleSmall!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: AppConstants.WEB_MAX_WIDTH,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                  options: CarouselOptions(height: 200.0, autoPlay: true),
                  items: product.images!.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: GetPlatform.isWeb
                                ? AppConstants.WEB_MAX_WIDTH / 2
                                : MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                //color: Colors.amber
                                ),
                            child: CustomImage(
                              image:
                                  "${global.appInfo.baseUrls!.productImageurl}/$i",
                              fit: BoxFit.contain,
                            ));
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  color: Colors.grey.shade300,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Choose Best Price",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<HomeController>(builder: (homeController) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: product.productPrices!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomImage(
                                  image:
                                      "${global.appInfo.baseUrls!.productSiteUrl}/${product.productPrices![index].siteIcon}",
                                  height: 40,
                                  width: 100,
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (global.currentUser.id != null) {
                                      await homeController.getTrackingLink(
                                          product.productPrices![index].url!,
                                          product.affiliatePartner!,
                                          cId: product.productPrices![index].cId
                                              .toString());
                                      await homeController.addClick(
                                        product.productPrices![index].siteName!,
                                        global.appInfo.baseUrls!
                                                .productSiteUrl! +
                                            '/' +
                                            product.productPrices![index]
                                                .siteIcon!,
                                        homeController.createdLink.isNotEmpty
                                            ? homeController.createdLink
                                            : product
                                                .productPrices![index].url!,
                                      );

                                      global.launchInBrowser(
                                        homeController.createdLink.isNotEmpty
                                            ? homeController.createdLink
                                            : product
                                                .productPrices![index].url!,
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
                                    padding: EdgeInsets.only(
                                        left: 13, right: 13, bottom: 3, top: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black,
                                    ),
                                    child: Text(
                                      "Grab Now",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 2,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "${global.appInfo.currency} ${product.productPrices![index].mrp}",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "Seller price",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 2,
                                  height: 70,
                                  color: Colors.grey,
                                ),
                                product.productPrices![index].cashback == null
                                    ? Container(
                                        width: 70,
                                        child: Text(
                                          "This is the best Price",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Text(
                                            "${global.appInfo.currency} ${product.productPrices![index].cashback}",
                                            style: TextStyle(
                                                color: Mycolors.orange,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "CashBack",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 2,
                                  height: 70,
                                  color: Colors.grey,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${global.appInfo.currency} ${product.productPrices![index].price}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "Best Price",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
