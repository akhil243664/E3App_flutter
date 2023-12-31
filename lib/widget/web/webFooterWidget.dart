import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/utils/images.dart';
import 'package:cashfuse/views/aboutUsScreen.dart';
import 'package:cashfuse/views/getHelpScreen.dart';
import 'package:cashfuse/views/privacyPolicyScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WebFooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Color(0xFF333333),
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${global.appName}',
                              style:
                                  TextStyle(fontSize: 28, color: Colors.white),
                            ),
                            Text(
                              '',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.quick_links,
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => AboutUsScreen(),
                              routeName: 'about',
                            );
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Text(
                            AppLocalizations.of(context)!.about_us,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => GetHelpScreen(),
                              routeName: 'faq',
                            );
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Text(
                            AppLocalizations.of(context)!.get_help,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => PrivacyPolicyScreen(),
                              routeName: 'privacy',
                            );
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Text(
                            AppLocalizations.of(context)!.privacy_policy,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.download_app,
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  launchUrl(Uri.parse(
                                      'https://play.google.com/store/apps/details?id=${global.appPackageName}'));
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        Images.playStore,
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .get_it_on,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'Play Store',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  launchUrl(Uri.parse(
                                      'https://apps.apple.com/in/app/cashfuse/id'));
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        Images.appleLogo,
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .get_it_on,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'App Store',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!
                                                .contact_us,
                              style:
                                  TextStyle(fontSize: 28, color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      'New Delhi Railway Station,New Delhi',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'support@codefuse.org',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.call,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    '0xxxxxxxxxxx',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        Container(
          width: AppConstants.WEB_MAX_WIDTH,
          color: Color(0xFF292929),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          child: Text(
            '(©) Copyright 2022 ${global.appName}. All Rights Reserved.',
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
