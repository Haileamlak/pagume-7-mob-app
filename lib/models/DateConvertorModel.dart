// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'package:abushakir/abushakir.dart';
import 'package:flutter/cupertino.dart';

class DateConvertorModel with ChangeNotifier {
  DateTime date = DateTime.now();
  EtDatetime etDate = EtDatetime.now();
  bool valid = true;
  int type = 1;
  static final grMonths = [
    "ጥር",
    "የካቲት",
    "መጋቢት",
    "ሚያዝያ",
    "ግንቦት",
    "ሰኔ",
    "ሐምሌ",
    "ነሐሴ",
    "መስከረም",
    "ጥቅምት",
    "ኅዳር",
    "ታኅሣሥ"
  ];

  String get get_greg_month {
    return grMonths[date.month - 1];
  }

  static bool leap_year(int yy) {
    if (yy % 400 == 0) return true;
    if (yy % 4 == 0 && yy % 100 != 0) return true;
    return false;
  }

  static bool etLeap(int yy) {
    if (yy % 4 == 0) return true;
    return false;
  }

  static bool is_date(int d, int m, int y) {
    if (d <= 0 || m < 1 || 12 < m) return false;
    int days_in_month = 31; // most months have 31 days
    switch (m) {
      case 2: // the length of February varies
        days_in_month = (leap_year(y)) ? 29 : 28;
        break;
      case 4:
      case 6:
      case 9:
      case 11:
        days_in_month = 30; // the rest have 30 days
        break;
    }
    if (days_in_month < d) return false;
    return true;
  }

  static bool isEtDate(int d, int m, int y) {
    if (d <= 0 ||
        d > 30 ||
        m <= 0 ||
        m > 13 ||
        (m == 13 && !etLeap(y + 1) && d > 5) ||
        (m == 13 && etLeap(y + 1) && d > 6)) {
      return false;
    }
    if (y < 1 || y > 2500) return false;
    return true;
  }

  void changeType(int type) {
    this.type = type;
    notifyListeners();
  }

  void convert(String d, String m, String y) {
    int? dd = int.tryParse(d);
    int? mm = int.tryParse(m);
    int? yy = int.tryParse(y);
    if (dd == null || mm == null || yy == null) {
      valid = false;
    } else {
      try {
        if (type == 1) {
          if (!isEtDate(dd, mm, yy)) throw Exception("Invalid date");
          etDate = EtDatetime(year: yy, month: mm, day: dd);
          date = DateTime.fromMillisecondsSinceEpoch(etDate.moment);
        } else if (type == 2) {
          if (!is_date(dd, mm, yy)) throw Exception("Invalid date");
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
