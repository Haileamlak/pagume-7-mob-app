import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/CalendarModel.dart';
import 'package:provider/provider.dart';

const monthsList = [
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
  "ጳጉሜ",
];

final months = List<Widget>.generate(
    13,
    (index) => Text(monthsList[index],
        style: const TextStyle(
            fontFamily: "Power Geez Unicode 1",
            fontSize: 35,
            color: Colors.lightBlue)));

class Calendar extends StatelessWidget {
  const Calendar();
  @override
  Widget build(BuildContext context) {
    final phone = MediaQuery.of(context);
    if (phone.orientation == Orientation.portrait) {
      return ChangeNotifierProvider<CalendarModel>(
        create: (context) => CalendarModel(),
        child: ListView(
          children: [MonthInput(), MonthCal()],
        ),
      );
    } else {
      return ChangeNotifierProvider<CalendarModel>(
        create: (context) => CalendarModel(),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [MonthInput(), MonthCal()],
        ),
      );
    }
  }
}

class MonthInput extends StatelessWidget {
  var _month = 1;
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 350,
      // height: 150,

      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 50, bottom: 50, left: 25, right: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Consumer<CalendarModel>(
        builder: (_, value, __) {
          return GridView.count(shrinkWrap: true, crossAxisCount: 2, children: [
            CupertinoPicker(
              squeeze: 1,
              looping: true,
              itemExtent: 50,
              onSelectedItemChanged: ((pickerValue) {
                print("notifiedhere");
                _month = pickerValue + 1;
                print(pickerValue + 1);
                value.change(_month , controller.text);
              }),
              children: months,
            ),
            Center(
                child: TextField(
                  controller: controller,
                    style: const TextStyle(fontSize: 30),
                    keyboardType: TextInputType.number,
                    onChanged: (textValue) {
                      value.change(_month, textValue);
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        suffixText: "ዓ.ም")))
          ]);
        },
      ),
    );
  }
}

class MonthCal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 350,
      // height: 320,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: ListView(
        shrinkWrap: true,
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 7,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            children: const [
              Center(child: Text("ሠኞ")),
              Center(child: Text("ማክሰኞ")),
              Center(child: Text("ረቡዕ")),
              Center(child: Text("ሐሙስ")),
              Center(child: Text("ዐርብ")),
              Center(child: Text("ቅዳሜ")),
              Center(child: Text("እሁድ")),
            ],
          ),
          Consumer<CalendarModel>(
            builder: (context, value, child) {
              return GridView.count(
                shrinkWrap: true,
                crossAxisCount: 7,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                children: [
                  for (int i = value.dayCounter; i <= value.dayStop; i++)
                    if (i > 0)
                      DateItem(i < 10 ? "0$i" : "$i")
                    else
                      const DateItem("")
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class DateItem extends StatelessWidget {
  final String day;
  const DateItem(this.day);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration:const Duration(seconds: 2),
        curve: Curves.bounceOut,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color.fromARGB(255, 229, 137, 10))),
        child: Center(
          child: Text(
            day,
            style: const TextStyle(color: Colors.lightBlue, fontSize: 20),
          ),
        ));
  }
}
