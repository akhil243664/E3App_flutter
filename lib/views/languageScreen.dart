// ignore_for_file: invalid_use_of_protected_member

import 'package:cashfuse/controllers/localizationController.dart';
import 'package:cashfuse/l10n/l10n.dart';
import 'package:cashfuse/provider/local_provider.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocaleProvider>(context);
    var locale = provider.locale;
    return WillPopScope(
      onWillPop: () async {
        Get.to(
          () => BottomNavigationBarScreen(pageIndex: 4),
          routeName: 'home',
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () async {
              Get.to(
                () => BottomNavigationBarScreen(pageIndex: 4),
                routeName: 'home',
              );
            },
            child: Icon(
              Icons.arrow_back,
            ),
          ),
          title: GetBuilder<LocalizationController>(
            builder: (controller) => Text(
              AppLocalizations.of(context)!.language,
              style: Get.theme.primaryTextTheme.titleSmall!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        body: GetBuilder<LocalizationController>(
          builder: (localizationController) {
            return ListView.builder(
                itemCount: L10n.all.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Column(
                      children: [
                        RadioListTile(
                          onChanged: (val) {
                            global.languageCode = val!;
                            final provider = Provider.of<LocaleProvider>(
                                context,
                                listen: false);
                            locale = Locale(L10n.all[index].languageCode);
                            provider.setLocale(locale!);
                            global.languageCode = locale!.languageCode;
                            if (global.languageCode == 'ar') {
                              global.isRTL = false;
                            } else {
                              global.isRTL = true;
                            }
                            Get.updateLocale(locale!);
                          },
                          value: L10n.all[index].languageCode,
                          groupValue: global.languageCode,
                          title: Text(L10n.languageListName[index]),
                        ),
                        index != global.appInfo.languages!.length - 1
                            ? Divider(
                                color: Color(0xFFDFE8EF),
                              )
                            : SizedBox(),
                      ],
                    ));
          },
        ),
      ),
    );
  }
}
