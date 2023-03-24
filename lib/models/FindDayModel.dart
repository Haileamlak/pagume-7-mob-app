import 'package:abushakir/abushakir.dart';
import 'package:flutter/cupertino.dart';
import 'package:project1/models/Date.dart';
import 'package:project1/models/DateConvertorModel.dart';
import 'NumberConvertorModel.dart';

class FindDayModel with ChangeNotifier {
  EtDatetime etDate = EtDatetime.now();
  DateTime date = DateTime.now();
  bool valid = false;
  int type = 1;

  static final days = ["ሠኞ", "ማግሠኞ", "ረቡዕ", "ሀሙስ", "ዐርብ", "ቅዳሜ", "እሑድ"];

  String getDay(int day) {
    return days[day - 1];
  }

  void changeType(int type) {
    this.type = type;
    notifyListeners();
  }

  void update(String d, String m, String y) {
    int? dd = int.tryParse(d);
    int? mm = int.tryParse(m);
    int? yy = int.tryParse(y);
    if (dd == null || mm == null || yy == null) {
      valid = false;
    } else {
      try {
        if (type == 1) {
          if (DateConvertorModel.isEtDate(dd, mm, yy))
            throw Exception("Invalid date");
          etDate = EtDatetime(year: yy, month: mm, day: dd);
          date = DateTime.fromMillisecondsSinceEpoch(etDate.moment);
        } else if (type == 2) {
          if (!DateConvertorModel.is_date(dd, mm, yy))
            throw Exception("Invalid date");
          date = DateTime(yy, mm, dd);
          etDate = EtDatetime.fromMillisecondsSinceEpoch(
              date.millisecondsSinceEpoch);
        }
      } on Exception {
        valid = false;
      }
      valid = true;
    }
    notifyListeners();
  }
}
