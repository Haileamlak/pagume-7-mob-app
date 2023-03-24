// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'package:abushakir/abushakir.dart';
import 'package:flutter/cupertino.dart';

final tewsak = [7, 6, 5, 4, 3, 2, 8];
final Wer = [
  "መስከረም",
  "ጥቅምት",
  "ኅዳር",
  "ታኅሣሥ",
  "ጥር",
  "የካቲት",
  "መጋቢት",
  "ሚያዝያ",
  "ግንቦት",
  "ሰኔ",
  "ሐምሌ",
  "ነሐሴ",
  "ጳጉሜ"
];

class LocalBahireHasab with ChangeNotifier {
  EtDatetime date = EtDatetime.now();
  bool valid = true;

  void update(String y) {
    int? d = int.tryParse(y);
    if (d != null && d > 0 && d <= 2500) {
      try {
        date = EtDatetime(year: d);
        valid = true;
      } on Exception {
        valid = false;
      }
    } else {
      valid = false;
    }
    notifyListeners();
  }

  String getHoly(int index) {
    BahireHasab bh = BahireHasab(year: date.year);
    switch (index) {
      case 1:
        final debreZeyt = bh.getSingleBealOrTsom("ደብረ ዘይት");
        return debreZeyt?["month"] + " " + debreZeyt?["date"].toString();
      case 2:
        final hosaina = bh.getSingleBealOrTsom("ሆሣዕና");
        return hosaina?["month"] + " " + hosaina?["date"].toString();
      case 3:
        final siklet = bh.getSingleBealOrTsom("ስቅለት");
        return siklet?["month"] + " " + siklet?["date"].toString();
      case 4:
        final tnsae = bh.getSingleBealOrTsom("ትንሳኤ");
        return tnsae?["month"] + " " + tnsae?["date"].toString();
      case 5:
        final peraklitos = bh.getSingleBealOrTsom("ጰራቅሊጦስ");
        return peraklitos?["month"] + " " + peraklitos?["date"].toString();
      case 6:
        final erget = bh.getSingleBealOrTsom("ዕርገት");
        return erget?["month"] + " " + erget?["date"].toString();
      default:
        return "error";
    }
  }

  String getFast(int index) {
    BahireHasab bh = BahireHasab(year: date.year);
    switch (index) {
      case 1:
        final dihnet = bh.getSingleBealOrTsom("ጾመ ድህነት");
        return dihnet?["month"] + " " + dihnet?["date"].toString();
      case 2:
        final nenewie = bh.getSingleBealOrTsom("ነነዌ");
        return nenewie?["month"] + " " + nenewie?["date"].toString();
      case 3:
        final abiy = bh.getSingleBealOrTsom("ዓቢይ ጾም");
        return abiy?["month"] + " " + abiy?["date"].toString();
      case 4:
        final hawaryat = bh.getSingleBealOrTsom("ጾመ ሐዋርያት");
        return hawaryat?["month"] + " " + hawaryat?["date"].toString();
      default:
        return "error";
    }
  }

  String getBasic(int index) {
    BahireHasab bh = BahireHasab(year: date.year);
    switch (index) {
      case 1:
        return "${bh.wenber}";
      case 2:
        return "${TinteYon(date.year)}";
      case 3:
        return "${MebajaHamer(date.year)}";
      case 4:
        return "${Medeb(date.year)}";
      case 5:
        return "${bh.abekte}";
      case 6:
        return "${bh.metkih}";
      default:
        return "error";
    }
  }

  String get_Wer(int month) {
    return Wer[month - 1];
  }

  int wenber(int y) {
    return (5500 + y) % 19 - 1;
  }

  int Medeb(int y) {
    return (5500 + y) % 19;
  }

  int Abektie(int y) {
    return (11 * wenber(y)) % 30;
  }

  int Metki(int y) {
    if (Abektie(y) == 0) return 30;
    return (19 * wenber(y)) % 30;
  }

  bool BealeMetki(int y) {
    if (Metki(y) > 14) return true;
    return false;
  }

  int TinteYon(int y) {
    int yon;
    num n = ((5500 + y) + (5500 + y) / 4);

    yon = ((n.toInt()) % 7 - 1);
    if (yon == 0) yon = 7;
    if (yon == -1) yon = 1;
    return yon;
  }

  int MebajaHamer(int y) {
    if (BealeMetki(y)) {
      return (Metki(y) + Tewsak(Metki(y), 1, y)) % 30;
    }
    return (Metki(y) + Tewsak(Metki(y), 2, y)) % 30;
  }

  int Tewsak(int Day, int month, int y) {
    int sereke;
    sereke = Day + 2 * month + TinteYon(y);
    if (sereke > 7) {
      sereke %= 7;
      if (sereke == 0) return 0;
    }
    return tewsak[sereke - 1];
  }

//   Date TsomeNenewie(int y) {
//     if (BealeMetki(y))
//       return Date.dmy(MebajaHamer(y), 5, 2015);
//     else
//       return Date.dmy(MebajaHamer(y), 6, 2015);
//   }

//   Date AbiyTsom(int y) {
//     int d;
//     d = (14 + MebajaHamer(y));
//     if (d > 30)
//       return Date.dmy(d % 30, 7, 2015);
//     else {
//       if (BealeMetki(y))
//         return Date.dmy(d, 5, 2015);
//       else
//         return Date.dmy(d, 6, 2015);
//     }
//   }

//   Date DebreZeit(int y) {
//     int d;
//     d = 27 + ((14 + MebajaHamer(y)) % 30);
//     if (d <= 30)
//       return Date.dmy(d, 6, 2015);
//     else if (30 < d && d <= 60) {
//       d = d % 30;
//       if (d == 0)
//         return Date.dmy(30, 7, 2015);
//       else
//         return Date.dmy(d % 30, 7, 2015);
//     } else // if (d > 60)
//       return Date.dmy(d % 30, 8, 2015);
//   }

//   Date Hosaina(int y) {
//     int d;
//     d = 18 + ((14 + MebajaHamer(y)) % 30);
//     if (d > 30)
//       return Date.dmy(d % 30, 8, 2015);
//     else
//       return Date.dmy(d, 7, 2015);
//   }

//   Date Siklet(int y) {
//     int d;
//     d = 23 + ((14 + MebajaHamer(y)) % 30);
//     if (d > 30)
//       return Date.dmy(d % 30, 8, 2015);
//     else
//       return Date.dmy(d, 7, 2015);
//   }

//   Date Tinsae(int y) {
//     int d;
//     d = 25 + ((14 + MebajaHamer(y)) % 30);
//     if (d > 30)
//       return Date.dmy(d % 30, 8, 2015);
//     else
//       return Date.dmy(d, 7, 2015);
//   }

//   Date Erget(int y) {
//     int d;
//     d = 18 + MebajaHamer(y);
//     if (d > 30)
//       return Date.dmy(d % 30, 10, 2015);
//     else
//       return Date.dmy(d, 9, 2015);
//   }

//   Date Peraklitos(int y) {
//     int d;
//     d = 28 + MebajaHamer(y);
//     if (d > 30)
//       return Date.dmy(d % 30, 10, 2015);
//     else
//       return Date.dmy(d, 9, 2015);
//   }

//   Date TsomeHawariyat(int y) {
//     int d;
//     d = 29 + MebajaHamer(y);
//     if (d > 30)
//       return Date.dmy(d % 30, 10, 2015);
//     else
//       return Date.dmy(d, 9, 2015);
//   }

//   Date TsomeDihnet(int y) {
//     int d;
//     d = 1 + MebajaHamer(y);
//     if (d > 30)
//       return Date.dmy(d % 30, 10, 2015);
//     else
//       return Date.dmy(d, 9, 2015);
//   }
}
