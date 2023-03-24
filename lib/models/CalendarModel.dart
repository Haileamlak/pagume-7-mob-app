// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:abushakir/abushakir.dart';
import 'package:flutter/cupertino.dart';
import 'package:project1/models/DateConvertorModel.dart';
import 'LocalBahireHasab.dart';

class CalendarModel with ChangeNotifier {
  EtDatetime etDate = EtDatetime.now();
  bool valid = true;
  int dayCounter = 0;
  int dayStop = 30;
  void change(int m, String y) {
    int? yy = int.tryParse(y);
    if (yy == null) {
      valid = false;
    } else if (!DateConvertorModel.isEtDate(1, m, yy)) {
      valid = false;
    } else {
      etDate = EtDatetime(year: yy, month: m);
      final ty = LocalBahireHasab();
      int ddd = (1 + 2 * etDate.month + ty.TinteYon(etDate.year)) % 7;
      dayCounter = (ddd == 0 ? -5 : (2 - ddd));
      if (m == 13 && !DateConvertorModel.etLeap(yy + 1))
        dayStop = 5;
      else if (m == 13 && DateConvertorModel.etLeap(yy + 1))
        dayStop = 6;
      else
        dayStop = 30;
      valid = true;
    }
    print("notified");
    notifyListeners();
  }
}
