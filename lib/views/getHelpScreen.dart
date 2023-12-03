// ignore_for_file: unnecessary_null_comparison
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/commonController.dart';
import 'package:cashfuse/views/helpDetailSceen.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:cashfuse/widget/web/webDrawerWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:shimmer_animation/shimmer_animation.dart';

class GetHelpScreen extends StatelessWidget {
  final fSeachNode = new FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: global.getPlatFrom() ? WebDrawerWidget() : null,
      appBar: global.getPlatFrom()
          ? WebTopBarWidget(
              scaffoldKey: scaffoldKey,
            )
          : AppBar(
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
              title: Text(
                AppLocalizations.of(context)!.get_help,
                style: Get.theme.primaryTextTheme.titleSmall!
                    .copyWith(color: Colors.white),
              ),
            ),
      body: Center(
        child: SizedBox(
          width: AppConstants.WEB_MAX_WIDTH,
          child: GetBuilder<CommonController>(builder: (controller) {
            return Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Get.theme.primaryColor.withOpacity(0.8),
                    Get.theme.secondaryHeaderColor.withOpacity(0.7),
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.zero,
                      child: TextFormField(
                        controller: controller.searchString,
                        focusNode: fSeachNode,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Get.theme.primaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          border: InputBorder.none,
                          hintText: 'What are you looking for?',
                          hintStyle: Get.theme.primaryTextTheme.bodySmall!
                              .copyWith(color: Colors.black54, fontSize: 11),
                          prefixIcon: Icon(
                            Icons.search,
                            color: fSeachNode.hasFocus
                                ? Get.theme.primaryColor
                                : Colors.grey,
                          ),
                          prefixIconColor: fSeachNode.hasFocus
                              ? Get.theme.primaryColor
                              : Colors.grey,
                        ),
                        onFieldSubmitted: (value) {
                          controller.faqLocalSearch();
                        },
                      ),
                    ),
                  ),
                  controller.isfaqLoaded
                      ? controller.faqList != null &&
                              controller.faqList.length > 0
                          ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: global.getPlatFrom() ? 5 : 2,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15.0,
                                childAspectRatio: 1.3,
                              ),
                              itemCount: controller.faqList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 15),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => HelpDetailSceen(
                                        faq: controller.faqList[index],
                                      ),
                                      routeName: 'detail',
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImage(
                                          image:
                                              '${global.appInfo.baseUrls!.faqImageUrl}/${controller.faqList[index].image}',
                                          height:
                                              global.getPlatFrom() ? 80 : 40,
                                          //width: Get.width,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          controller.faqList[index].ques!,
                                          textAlign: TextAlign.center,
                                          style: global.getPlatFrom()
                                              ? Get.theme.primaryTextTheme
                                                  .titleMedium
                                              : Get.theme.primaryTextTheme
                                                  .titleSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Expanded(
                              child: Center(
                                child:Text(
                                        AppLocalizations.of(context)!.no_data_found,
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                            )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: global.getPlatFrom() ? 5 : 2,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                            childAspectRatio: 1.3,
                          ),
                          itemCount: 8,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 15),
                          itemBuilder: (context, index) {
                            return Shimmer(
                              duration: Duration(seconds: 2),
                              child: Container(
                                // width: Get.width - 120,
                                // height: 165,
                                // margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
