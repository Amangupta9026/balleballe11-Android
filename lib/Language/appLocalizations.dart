import 'package:balleballe11/constance/constance.dart' as constance;

class AppLocalizations {
  static String of(String text, {String ignoreLanguageCode: 'en'}) {
    String myLocale = constance.locale;

    if (constance.allTextData != null &&
        constance.allTextData.allText.length > 0) {
      var newtext = '';
      int index = constance.allTextData.allText
          .indexWhere((note) => note.textId == text);
      if (index != -1) {
        if (myLocale == 'gr') {
          newtext = constance.allTextData.allText[index].gr;
        } else if (myLocale == 'bg') {
          newtext = constance.allTextData.allText[index].bg;
        } else if (myLocale == 'en') {
          newtext = constance.allTextData.allText[index].en;
        } else if (myLocale == 'tm') {
          newtext = constance.allTextData.allText[index].tm;
        }
        if (newtext != '') {
          return newtext;
        } else {
          return text;
        }
      } else {
        return text;
      }
    } else {
      return text;
    }
  }
}
