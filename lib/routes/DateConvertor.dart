import 'package:abushakir/abushakir.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/DateConvertorModel.dart';
import 'package:provider/provider.dart';

class DateConvertor extends StatelessWidget {
  const DateConvertor();
  @override
  Widget build(BuildContext context) {
    final phone = MediaQuery.of(context);
    DateTime date = DateTime.now();
    if (phone.orientation == Orientation.portrait) {
      return ChangeNotifierProvider<DateConvertorModel>(
        create: (context) => DateConvertorModel(),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            const ConverType(),
            EthioDateInput(),
            const Expanded(child: ConvertedResult())
          ],
        ),
      );
    } else {
      return ChangeNotifierProvider<DateConvertorModel>(
        create: (context) => DateConvertorModel(),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            Expanded(
                child: Column(
              children: [
                const ConverType(),
                EthioDateInput(),
              ],
            )),
            const Expanded(child: ConvertedResult())
          ],
        ),
      );
    }
  }
}

class Heading extends StatelessWidget {
  final String dateType;
  const Heading(this.dateType);

  @override
  Widget build(BuildContext context) {
    return Text(
      dateType,
      style: const TextStyle(fontSize: 20),
    );
  }
}

class ConverType extends StatelessWidget {
  const ConverType();
  final _items = const [
    DropdownMenuItem<int>(
      value: 1,
      child: Text(
        "ከኢትዮጵያውያን ወደ ጎርጎሮሳውያን",
        style:
            TextStyle(fontSize: 23, color: Color.fromARGB(255, 229, 137, 10)),
      ),
    ),
    DropdownMenuItem<int>(
      value: 2,
      child: Text(
        "ከጎርጎሮሳውያን ወደ ኢትዮጵያውያን",
        style: TextStyle(fontSize: 23, color: Colors.lightBlue),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<DateConvertorModel>(
        builder: (_, value, __) => DropdownButton(
          items: _items,
          value: value.type,
          borderRadius: BorderRadius.circular(25),
          iconSize: 30,
          onChanged: (itemValue) {
            if (itemValue != value.type) {
              value.changeType(itemValue ?? 0);

              if (itemValue == 2 && value.valid) {
                value.convert("${value.etDate.day}", "${value.etDate.month}",
                    "${value.etDate.year}");
              } else if (itemValue == 1 && value.valid) {
                value.convert("${value.date.day}", "${value.date.month}",
                    "${value.date.year}");
              }
            }
          },
        ),
      ),
    );
  }
}

class ConvertedResult extends StatelessWidget {
  const ConvertedResult();
  @override
  Widget build(BuildContext context) {
    return Consumer<DateConvertorModel>(
      builder: (_, value, __) => Row(
        children: [
         Expanded(child: Card(
            child: ListTile(
              title: const Text("በኢትዮጵያ አቆጣጠር"),
              subtitle: value.valid
                  ? Text(
                      "${value.etDate.monthGeez ?? ""} ${value.etDate.day} ${value.etDate.year}",
                      style:
                          const TextStyle(color: Colors.orange, fontSize: 20),
                    )
                  : const Text(
                      "የተሳሳተ ግብዓት",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
            ),
          ),
      ),
         Expanded(child:  Card(
            child: ListTile(
              title: const Text("በጎርጎሮሳውያን አቆጣጠር", style: TextStyle(fontSize: 14),),
              subtitle: value.valid
                  ? Text(
                      "${value.get_greg_month} ${value.date.day}, ${value.date.year}",
                      style: const TextStyle(
                          color: Colors.lightBlue, fontSize: 20),
                    )
                  : const Text(
                      "የተሳሳተ ግብዓት",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
            ),
          ),)
        ],
      ),
    );
  }
}

class EthioDateInput extends StatelessWidget {
  String _day = "", _month = "", _year = "";
  EthioDateInput();

  @override
  Widget build(BuildContext context) {
    return Consumer<DateConvertorModel>(builder: (context, value, child) {
      return Container(
        height: 100,
        padding: const EdgeInsets.only(left: 10, right: 10),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 30, top: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), border: Border.all()),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    onChanged: (textValue) {
                      _day = textValue;
                      value.convert(_day, _month, _year);
                    },
                    style: const TextStyle(fontSize: 40, color: Colors.orange),
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        label: Text("ቀን"),
                        contentPadding: EdgeInsets.all(5)),
                  )),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 30),
                  child: TextField(
                    onChanged: (textValue) {
                      _month = textValue;
                      value.convert(_day, _month, _year);
                    },
                    style: const TextStyle(fontSize: 40, color: Colors.orange),
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        label: Text("ወር"),
                        contentPadding: EdgeInsets.all(5)),
                  )),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.zero,
                  child: TextField(
                    onChanged: (textValue) {
                      _year = textValue;
                      value.convert(_day, _month, _year);
                    },
                    style: const TextStyle(fontSize: 40, color: Colors.orange),
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        label: Text("ዓመት"),
                        contentPadding: EdgeInsets.all(5)),
                  )),
            ),
          ],
        ),
      );
    });
  }
}
