// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cashfuse/constants/appConstant.dart';
import 'package:cashfuse/controllers/authController.dart';
import 'package:cashfuse/controllers/imageController.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:cashfuse/widget/confirmationDialog.dart';
import 'package:cashfuse/widget/customImage.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cashfuse/widget/web/webDrawerWidget.dart';
import 'package:cashfuse/widget/web/webTopBarWidget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class WebAccountSettingScreen extends StatelessWidget {
  final fnameFocus = new FocusNode();
  final femailFocus = new FocusNode();
  final fnumberFocus = new FocusNode();
  final cPasswordFocus = new FocusNode();
  final newPasswordFocus = new FocusNode();
  final conPasswordFocus = new FocusNode();

  AuthController authController = Get.find<AuthController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (auth) {
      return GetBuilder<ImageControlller>(builder: (imageControlller) {
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          drawer: global.getPlatFrom() ? WebDrawerWidget() : null,
          appBar: global.getPlatFrom()
              ? WebTopBarWidget(
                  scaffoldKey: scaffoldKey,
                )
              : AppBar(
                  elevation: 0,
                  leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.account_settings,
                    style: Get.theme.primaryTextTheme.titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
          body: Center(
            child: Container(
              alignment: Alignment.topCenter,
              color: global.getPlatFrom() ? Colors.white : Colors.transparent,
              width: global.getPlatFrom()
                  ? AppConstants.WEB_MAX_WIDTH / 2
                  : AppConstants.WEB_MAX_WIDTH,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Get.theme.primaryColor.withOpacity(0.2),
                                width: 4,
                              ),
                            ),
                            child: imageControlller.imageFile != null &&
                                    imageControlller.imageFile!.path.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: GetPlatform.isWeb
                                        ? Image.network(
                                            imageControlller.imageFile!.path)
                                        : Image.file(
                                            imageControlller.imageFile!,
                                            fit: BoxFit.cover,
                                            // height: 100,
                                            // width: 120,
                                          ),
                                  )
                                : global.currentUser.userImage != null &&
                                        global.currentUser.userImage!.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CustomImage(
                                          image: global.appInfo.baseUrls!
                                                  .userImageUrl! +
                                              '/' +
                                              global.currentUser.userImage!,
                                          fit: BoxFit.cover,
                                          // height: 150,
                                          // width: 150,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.blue[100],
                                        child: Icon(
                                          Icons.person,
                                          size: 50,
                                        ),
                                      ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 5,
                            child: InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  CupertinoActionSheet(
                                    title: Text(
                                      AppLocalizations.of(context)!.select,
                                      style: Get
                                          .theme.primaryTextTheme.titleLarge!
                                          .copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    actions: [
                                      InkWell(
                                        onTap: () async {
                                          Get.back();
                                          imageControlller
                                              .imageService(ImageSource.camera);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(15),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .take_picture,
                                            style: Get.theme.primaryTextTheme
                                                .titleMedium,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Get.back();
                                          imageControlller.imageService(
                                              ImageSource.gallery);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(15),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .image_from_gallery,
                                            style: Get.theme.primaryTextTheme
                                                .titleMedium,
                                          ),
                                        ),
                                      ),
                                    ],
                                    cancelButton: TextButton(
                                      child: Text(
                                        AppLocalizations.of(context)!.cancel,
                                        style: Get
                                            .theme.primaryTextTheme.titleMedium!
                                            .copyWith(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: Get.theme.secondaryHeaderColor,
                                radius: 18,
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.full_name,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                          TextFormField(
                            focusNode: fnameFocus,
                            controller: authController.name,
                            scrollPadding: EdgeInsets.zero,
                            cursorColor: Get.theme.primaryColor,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Test User',
                              hintStyle: Get.theme.primaryTextTheme.bodySmall!
                                  .copyWith(color: Colors.grey[400]),
                              focusColor: Get.theme.primaryColor,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: fnameFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: fnameFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: fnameFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context)!.email_address,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            focusNode: femailFocus,
                            controller: authController.email,
                            readOnly: global.currentUser.email != null &&
                                    global.currentUser.email!.isNotEmpty
                                ? true
                                : false,
                            scrollPadding: EdgeInsets.zero,
                            cursorColor: Get.theme.primaryColor,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'test@gmail.com',
                              hintStyle: Get.theme.primaryTextTheme.bodySmall!
                                  .copyWith(color: Colors.grey[400]),
                              focusColor: Get.theme.primaryColor,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: femailFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: femailFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: femailFocus.hasFocus
                                    ? Get.theme.primaryColor
                                    : Colors.grey,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context)!.mobile_number,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            // height: 100,
                            child: IntlPhoneField(
                              // readOnly: global.currentUser.phone != null &&
                              //         global.currentUser.phone!.isNotEmpty
                              //     ? true
                              //     : false,

                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              focusNode: authController.phoneFocus,
                              showCountryFlag: false,
                              style: TextStyle(color: Colors.black),

                              controller: authController.contactNo,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              initialCountryCode: global.countryCode,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              disableLengthCheck: false,
                              enabled: global.currentUser.phone != null &&
                                      global.currentUser.phone!.isNotEmpty
                                  ? false
                                  : true,

                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 8),
                                filled: false,
                                focusColor: Get.theme.primaryColor,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: fnumberFocus.hasFocus
                                      ? Get.theme.primaryColor
                                      : Colors.grey,
                                )),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: fnumberFocus.hasFocus
                                      ? Get.theme.primaryColor
                                      : Colors.grey,
                                )),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: fnumberFocus.hasFocus
                                      ? Get.theme.primaryColor
                                      : Colors.grey,
                                )),
                                hintText: '9999999999',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                counterText: "",
                              ),
                              onChanged: (phone) {
                                authController.isNumberChange = true;
                                authController.update();
                              },

                              flagsButtonMargin: EdgeInsets.zero,
                              flagsButtonPadding: EdgeInsets.zero,

                              dropdownTextStyle: TextStyle(color: Colors.black),
                              showDropdownIcon: false,
                              cursorColor: Theme.of(context).primaryColor,
                              onCountryChanged: (country) {
                                FocusScope.of(context).unfocus();

                                authController.coutryDialCode =
                                    '+' + country.dialCode;

                                global.countryCode = country.code;

                                log(authController.isNumberChange.toString());

                                global.sp!
                                    .setString('countryCode', country.code);
                                authController.update();
                                print('Country changed to: ' + country.name);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    !GetPlatform.isWeb
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                showConfirmationDialog(
                                  context,
                                  'Delete My Account',
                                  'Are you sure you want to delete Account ?',
                                  [
                                    CupertinoDialogAction(
                                      child: Text(
                                        AppLocalizations.of(context)!.yes,
                                        style: Get
                                            .theme.primaryTextTheme.titleSmall!
                                            .copyWith(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        authController.removeUserfromDb();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                        AppLocalizations.of(context)!.no,
                                        style: Get
                                            .theme.primaryTextTheme.titleSmall!
                                            .copyWith(color: Colors.blue),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ],
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Delete My Account',
                                      style: Get
                                          .theme.primaryTextTheme.bodyMedium!
                                          .copyWith(
                                        letterSpacing: -0.5,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () async {
                  // String _numberWithCountryCode =
                  //     authController.coutryDialCode! +
                  //         authController.contactNo.text;
                  // bool _isValid = GetPlatform.isAndroid ? false : true;
                  // if (GetPlatform.isAndroid) {
                  //   try {
                  //     PhoneNumber phoneNumber =
                  //         await PhoneNumberUtil().parse(_numberWithCountryCode);
                  //     _numberWithCountryCode = '+' +
                  //         phoneNumber.countryCode +
                  //         phoneNumber.nationalNumber;
                  //     _isValid = true;
                  //   } catch (e) {
                  //     print(
                  //         "Exception - LoginWithPhoneScreen.dart - PhoneNumberUtil():" +
                  //             e.toString());
                  //   }
                  // }
                  // if (!_isValid) {
                  //   showCustomSnackBar('Invalid phone number');
                  // } else
                  if (authController.name.text.isEmpty) {
                    showCustomSnackBar('Please Enter name.');
                  } else if (authController.email.text.isEmpty) {
                    showCustomSnackBar('Please Enter email.');
                  } else if (!EmailValidator.validate(
                      authController.email.text)) {
                    showCustomSnackBar('Please Enter valid email.');
                  } else if (authController.contactNo.text.isEmpty) {
                    showCustomSnackBar('Please Enter phone.');
                  } else if (imageControlller.imageFile != null) {
                    await authController
                        .updateProfile(imageControlller.imageFile!);
                  } else {
                    await authController.updateProfile(null);
                  }
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40,
                    width: global.getPlatFrom()
                        ? AppConstants.WEB_MAX_WIDTH / 2
                        : Get.width,
                    decoration: BoxDecoration(
                      color: Get.theme.secondaryHeaderColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.save_changes,
                      style: Get.theme.primaryTextTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
