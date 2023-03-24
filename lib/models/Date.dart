class Date {
  late int day, month, year;
  Date.dmy(int d, int m, int y) {
    if (isvalid(d, m, y)) {
      day = d;
      month = m;
      year = y;
    } else {
      throw Exception("Invalid Date");
    }
  }
  Date() {
    day = 01;
    month = 01;
    year = 01;
  }
  bool isvalid(int d, int m, int y) {
    if (d < 1 || d > 30 || m < 1 || m > 13 || y < 1 && y > 2500) return false;
    if (leapYear(y + 1) && m == 13 && d > 6) return false;
    if (!leapYear(y + 1) && m == 13 && d > 5) return false;
    return true;
  }

  int get getDay {
    return day;
  }

  int get getMonth {
    return month;
  }

  int get getYear {
    return year;
  }
}

bool leapYear(int year) {
  if (year % 4 == 0) return true;
  return false;
}
