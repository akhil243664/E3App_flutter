class LanguageModel {
  String? key;
  String? imageUrl;
  String? languageName;
  String? languageCode;
  String? countryCode;
  bool? isLangShown;

  LanguageModel(
      {this.key,
      this.imageUrl,
      this.languageName,
      this.countryCode,
      this.languageCode,
      this.isLangShown});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    try {
      languageCode = json["languageCode"] != null ? json["languageCode"] : '';
      languageName = json["languageName"] != null ? json["languageName"] : '';
    } catch (e) {
      print("Exception - LanguageModel.dart - LanguageModel.fromJson():" +
          e.toString());
    }
  }
}
