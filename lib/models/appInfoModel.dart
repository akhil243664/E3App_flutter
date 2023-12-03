import 'package:cashfuse/models/baseUrlsModel.dart';
import 'package:cashfuse/models/countryModel.dart';
import 'package:cashfuse/models/languageModel.dart';

class AppInfo {
  String? admob;
  String? facebookAd;
  String? businessName;
  String? logo;
  String? currency;
  String? country;
  String? phoneCode;
  String? countryCode;
  String? perOrderReferPercentage;
  String? minimumRedeemValue;
  BaseUrls? baseUrls;
  List<LanguageModel>? languages;
  List<CountryModel>? countries;
  int? countryselection;
  String? dummyImage;

  AppInfo({
    this.admob,
    this.facebookAd,
    this.businessName,
    this.logo,
    this.currency,
    this.perOrderReferPercentage,
    this.minimumRedeemValue,
    this.baseUrls,
    this.languages,
    this.countries,
    this.countryselection,
    this.dummyImage,
  });

  AppInfo.fromJson(Map<String, dynamic> json) {
    try {
      admob = json['admob'];
      facebookAd = json['facebook_ad'];
      businessName = json["business_name"] != null ? json["business_name"] : '';
      logo = json["logo"] != null ? json["logo"] : '';
      country = json["country"] != null ? json["country"].toString() : '';
      phoneCode =
          json["phone_code"] != null ? json["phone_code"].toString() : '';
      countryCode =
          json["country_code"] != null ? json["country_code"].toString() : '';
      currency = json["currency"] != null ? json["currency"] : '';
      perOrderReferPercentage = json["per_order_refer_percentage"] != null
          ? json["per_order_refer_percentage"]
          : '';
      minimumRedeemValue = json["minimum_redeem_value"] != null
          ? json["minimum_redeem_value"]
          : '';
      baseUrls = json["base_urls"] != null
          ? BaseUrls.fromJson(json["base_urls"])
          : BaseUrls();
      languages = json['languages'] != null && json['languages'] != []
          ? List<LanguageModel>.from(
              json['languages'].map((x) => LanguageModel.fromJson(x)))
          : [];
      countries = json['countries'] != null && json['countries'] != []
          ? List<CountryModel>.from(
              json['countries'].map((x) => CountryModel.fromJson(x)))
          : [];
      countryselection =
          json['countryselection'] != null ? json['countryselection'] : 0;
      dummyImage = json["dummy_image"] != null ? json["dummy_image"] : '';
    } catch (e) {
      print("Exception - AppInfo.dart - AppInfo.fromJson():" + e.toString());
    }
  }
}
