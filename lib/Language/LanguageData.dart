class AllTextData {
  List<AllText> allText;

  AllTextData({this.allText});

  AllTextData.fromJson(Map<String, dynamic> json) {
    if (json['allText'] != null) {
      allText = <AllText>[];
      json['allText'].forEach((v) {
        allText.add(new AllText.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allText != null) {
      data['allText'] = this.allText.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllText {
  String textId = '';
  String gr = '';
  String bg = '';
  String en = '';
  String tm = '';

  AllText(
      {this.textId = '',
      this.gr = '',
      this.en = '',
      this.bg = '',
      this.tm = ''});

  AllText.fromJson(Map<String, dynamic> json) {
    textId = json['textId'] ?? '';
    if (json['languageTextList'] != null) {
      json['languageTextList'].forEach((text) {
        if (text["gr"] != null) {
          gr = text["gr"] ?? textId;
        }
        if (text["bg"] != null) {
          bg = text["bg"] ?? textId;
        }
        if (text["en"] != null) {
          en = text["en"] ?? textId;
        }
        if (text["tm"] != null) {
          tm = text["tm"] ?? textId;
        }
      });
      if (gr == '') {
        gr = textId;
      }
      if (bg == '') {
        bg = textId;
      }
      if (en == '') {
        en = textId;
      }
      if (tm == '') {
        tm = textId;
      }
    } else {
      gr = textId;
      bg = textId;
      en = textId;
      tm = textId;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['textId'] = this.textId;
    data['gr'] = this.gr;
    data['bg'] = this.bg;
    data['en'] = this.en;
    data['tm'] = this.tm;
    return data;
  }
}
