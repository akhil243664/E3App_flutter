import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/authController.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginOrSignUpScreen extends StatelessWidget {
  final bool fromMenu;
  LoginOrSignUpScreen({required this.fromMenu});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        backgroundColor: Color(0xFFFEF9F3),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: Get.theme.primaryTextTheme.displaySmall!.copyWith(
                    letterSpacing: -1,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  AppLocalizations.of(context)!.login_subtitle,
                  style: Get.theme.primaryTextTheme.titleSmall!.copyWith(
                    letterSpacing: -0.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                child: SizedBox(
                  height: 100,
                  child: IntlPhoneField(
                    pickerDialogStyle: PickerDialogStyle(
                        width: AppConstants.WEB_MAX_WIDTH / 2),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: authController.phoneFocus,
                    showCountryFlag: false,
                    controller: authController.contactNo,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    initialCountryCode: global.countryCode,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    disableLengthCheck: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      // fillColor: AppColor.WHITE_COLOR,
                      label: Text('Enter phone'),
                      labelStyle: TextStyle(color: Colors.black),
                      // hintText: MessageConstants.HNT_PHONE_NUMBER,
                      filled: false,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      counterText: "",
                    ),
                    dropdownTextStyle: TextStyle(color: Colors.black),
                    showDropdownIcon: false,
                    cursorColor: Theme.of(context).primaryColor,
                    onCountryChanged: (country) {
                      FocusScope.of(context).unfocus();

                      authController.coutryDialCode = '+' + country.dialCode;
                      global.countryCode = country.code;

                      global.sp!.setString('countryCode', country.code);
                      authController.update();
                      print('Country changed to: ' + country.name);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                await authController.loginOrRegister(fromMenu);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                margin:
                    EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 15),
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                decoration: BoxDecoration(
                  color: Get.theme.secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.conti,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
