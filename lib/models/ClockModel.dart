import 'dart:io';
import 'package:abushakir/abushakir.dart';
import 'package:flutter/cupertino.dart';

class ClockModel with ChangeNotifier {
  var time = DateTime.now();
  var second = DateTime.now().second;
  var minute = DateTime.now().minute;
  var hour =  DateTime.now().hour - 18;


  void update() async {
    await Future.delayed(const Duration(seconds: 1));
    second++;
    if (second == 60) {
      second = 0;
      minute++;
    }
    if (minute == 60) {
      minute = 0;
      hour++;
    }
  }
}
