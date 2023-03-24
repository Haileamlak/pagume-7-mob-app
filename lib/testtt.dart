import 'package:abushakir/abushakir.dart';

void main(List<String> args) {
  EtDatetime date = EtDatetime.now();
  BahireHasab bh = BahireHasab(year: date.year);
  final allHolyFast = bh.allAtswamat;
  allHolyFast.forEach((element) {
    print(element);
  });
  
}
