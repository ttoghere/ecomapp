enum LanguageType { Turkish, English }

const String Turkish = "tr";
const String English = "en";

extension LanguageTypeExtenxion on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.Turkish:
        return Turkish;
      case LanguageType.English:
        return English;
    }
  }
}
