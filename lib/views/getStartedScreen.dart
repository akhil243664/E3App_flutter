import 'package:cashfuse/controllers/authController.dart';
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/views/loginOrSignUpScreen.dart';
import 'package:cashfuse/views/loginWithEmail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cashfuse/utils/global.dart' as global;
// import 'package:video_player/video_player.dart';

import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/images.dart';

class GetStartedScreen extends StatelessWidget {
  final bool fromMenu;
  GetStartedScreen({required this.fromMenu});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        fromMenu ? Get.back() : SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        // drawer: global.getPlatFrom() ? WebDrawerWidget() : null,
        appBar: fromMenu
            ? AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Get.theme.secondaryHeaderColor,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              )
            : null,
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Images.logo,
                  fit: BoxFit.contain,
                  scale: 2,
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar:
            GetBuilder<AuthController>(builder: (authController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetPlatform.isIOS
                  ? InkWell(
                      onTap: () async {
                        await authController.signInWithApple(fromMenu);
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.appleLogo,
                              height: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              AppLocalizations.of(context)!.login_apple,
                              style: Get.theme.primaryTextTheme.titleMedium!
                                  .copyWith(
                                color: Get.theme.secondaryHeaderColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        await authController.googleSignInFun(fromMenu);

                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.google,
                              height: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              AppLocalizations.of(context)!.login_google,
                              style: Get.theme.primaryTextTheme.titleMedium!
                                  .copyWith(
                                color: Get.theme.secondaryHeaderColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              InkWell(
                onTap: () async {
                  if (global.getPlatFrom()) {
                    Get.dialog(Dialog(
                      child: SizedBox(
                          width: Get.width / 3,
                          child: LoginOrSignUpScreen(
                            fromMenu: fromMenu,
                          )
                          // LoginOrSignUpScreen(
                          //   fromMenu: true,
                          // ),
                          ),
                    ));
                  } else {
                    Get.to(
                      () => LoginOrSignUpScreen(
                        fromMenu: fromMenu,
                      ),
                      routeName: 'login',
                      preventDuplicates: false,
                    );
                  }

                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 20,
                        color: Colors.blue[800],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.login_phone,
                        style: Get.theme.primaryTextTheme.titleMedium!.copyWith(
                          color: Get.theme.secondaryHeaderColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (global.getPlatFrom()) {
                    Get.dialog(Dialog(
                      child: SizedBox(
                          width: Get.width / 3,
                          child: LoginWithEmailScreen(
                            fromMenu: fromMenu,
                          )
                          // LoginOrSignUpScreen(
                          //   fromMenu: true,
                          // ),
                          ),
                    ));
                  } else {
                    Get.to(
                      () => LoginWithEmailScreen(
                        fromMenu: fromMenu,
                      ),
                      routeName: 'login',
                      preventDuplicates: false,
                    );
                  }

                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: Container(
                  height: 50,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        size: 20,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.login_email,
                        style: Get.theme.primaryTextTheme.titleMedium!.copyWith(
                          color: Get.theme.secondaryHeaderColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              fromMenu
                  ? SizedBox()
                  : InkWell(
                      onTap: () {
                        Get.offAll(
                          () => BottomNavigationBarScreen(),
                          routeName: 'home',
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 10),
                        child: Text(
                          AppLocalizations.of(context)!.skip,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Get.theme.secondaryHeaderColor,
                              fontSize: 16),
                        ),
                      ),
                    )
            ],
          );
        }),
      ),
    );
  }
}
