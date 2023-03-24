import 'package:flutter/material.dart';
import 'package:project1/models/FindDayModel.dart';
import 'package:provider/provider.dart';
import 'DateConvertor.dart';

class FindTheDay extends StatelessWidget {
  const FindTheDay();
  @override
  Widget build(BuildContext context) {
    final phone = MediaQuery.of(context);
    if (phone.orientation == Orientation.portrait) {
      return ChangeNotifierProvider<FindDayModel>(
        create: (context) => FindDayModel(),
        child: ListView(
          children: [
            const Padding(padding: EdgeInsets.all(20)),
            const Center(
              child: ConverType(),
            ),
            EthioDateInput(),
            const DayInfo()
          ],
        ),
      );
    } else {
      return ChangeNotifierProvider<FindDayModel>(
        create: (context) => FindDayModel(),
        child: Wrap(
          children: [
            const ConverType(),
            Expanded(
              child: EthioDateInput(),
            ),
            const Expanded(child: DayInfo())
          ],
        ),
      );
    }
  }
}

class ConverType extends StatelessWidget {
  const ConverType();
  final _items = const [
    DropdownMenuItem<int>(
      value: 1,
      child: Text(
        "የኢትዮጵያውያን",
        style:
            TextStyle(fontSize: 23, color: Color.fromARGB(255, 229, 137, 10)),
      ),
    ),
    DropdownMenuItem<int>(
      value: 2,
      child: Text(
        "የጎርጎሮሳውያን",
        style: TextStyle(fontSize: 23, color: Colors.lightBlue),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<FindDayModel>(
        builder: (_, value, __) {
          return DropdownButton(
            items: _items,
            value: value.type,
            borderRadius: BorderRadius.circular(25),
            iconSize: 30,
            onChanged: (itemValue) {
              if (itemValue != value.type) {
                value.changeType(itemValue ?? 1);
                if (itemValue == 1 && value.valid) {
                  value.update("${value.date.day}", "${value.date.month}",
                      "${value.date.year}");
                } else if (itemValue == 2 && value.valid) {
                  value.update("${value.etDate.day}", "${value.etDate.month}",
                      "${value.etDate.year}");
                }
              }
            },
          );
        },
      ),
    );
  }
}

class DayInfo extends StatelessWidget {
  const DayInfo();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<FindDayModel>(
        builder: (context, value, child) {
          return Chip(
            backgroundColor: Colors.white,
            avatar:const Icon(Icons.calendar_today_rounded),
            deleteIcon: const Icon(Icons.delete),
            // onDeleted: () => Transform.rotate(angle: 4),
            label: value.valid
                ? Text(
                    value.type == 1
                        ? value.getDay(value.etDate.day)
                        : value.getDay(value.date.day),
                    style: const TextStyle(fontSize: 30))
                : const Text(
                    "የተሳሳተ ግብዓት",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
          );
        },
      ),
    );
  }
}

class EthioDateInput extends StatelessWidget {
  String _day = "", _month = "", _year = "";
  EthioDateInput();

  @override
  Widget build(BuildContext context) {
    return Consumer<FindDayModel>(builder: (context, value, child) {
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
                    onSubmitted: (textValue) {
                      _day = textValue;
                      value.update(_day, _month, _year);
                    },
                    style: const TextStyle(fontSize: 40),
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
                    onSubmitted: (textValue) {
                      _month = textValue;
                      value.update(_day, _month, _year);
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
                    onSubmitted: (textValue) {
                      _year = textValue;
                      value.update(_day, _month, _year);
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
