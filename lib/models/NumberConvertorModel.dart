import 'package:abushakir/abushakir.dart';
import 'package:flutter/cupertino.dart';

class NumberConvertorModel with ChangeNotifier {
  String etNum = "፩";
  int num = 1;
  bool valid = true;

  convert(String number) {
    int? temp = int.tryParse(number);
    if (temp != null) {
      num = temp;
      etNum = ConvertToEthiopic(num) ?? "";
      valid = true;
    } else {
      valid = false;
    }
    notifyListeners();
  }
}
