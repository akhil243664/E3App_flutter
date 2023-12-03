import 'package:cashfuse/controllers/networkController.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController {
  LocalizationController() {
    _loadCurrentTheme();
  }
  NetworkController networkController = Get.put(NetworkController());

  String languageCode = 'en';

  void _loadCurrentTheme() async {
    global.sp = await SharedPreferences.getInstance();
    if (global.sp!.getString('languageCode') != null) {
      languageCode = global.sp!.getString('languageCode')!;
    } else {
      languageCode = 'en';
    }

    if (global.rtlLanguageCodeLList.contains(languageCode)) {
      global.isRTL = true;
    } else {
      global.isRTL = false;
    }

    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
