class LanguageCode {
  final String name;
  final String code;

  const LanguageCode(this.name, this.code);
}

class AppStrings {
  static const List<LanguageCode> appLanguageList = [
    LanguageCode('English', 'en'),
    LanguageCode('हिन्दी', 'hi'),
  ];
}
