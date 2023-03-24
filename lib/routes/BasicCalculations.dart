import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/LocalBahireHasab.dart';
import 'package:provider/provider.dart';

class BasicCalculations extends StatelessWidget {
  const BasicCalculations();
  @override
  Widget build(BuildContext context) {
    final phone = MediaQuery.of(context);
    if (phone.orientation == Orientation.portrait) {
      return ChangeNotifierProvider<LocalBahireHasab>(
        create: (context) => LocalBahireHasab(),
        child: ListView(
          children: const [
            YearInput(),
            Padding(padding: EdgeInsets.all(10)),
            Basic("ወንበር", 1),
            Padding(padding: EdgeInsets.all(5)),
            Basic("ጥንተ ዮን", 2),
            Padding(padding: EdgeInsets.all(5)),
            Basic("መባጃ ሐመር", 3),
            Padding(padding: EdgeInsets.all(5)),
            Basic("መደብ", 4),
            Padding(padding: EdgeInsets.all(5)),
            Basic("አበቅቴ", 5),
            Padding(padding: EdgeInsets.all(5)),
            Basic("መጥቅዕ", 6),
          ],
        ),
      );
    } else {
      return ChangeNotifierProvider<LocalBahireHasab>(
        create: (context) => LocalBahireHasab(),
        child: GridView.count(
          crossAxisCount: 2,
          children: const [
            YearInput(),
            Basic("ወንበር", 1),
            Basic("ጥንተ ዮን", 2),
            Basic("መባጃ ሐመር", 3),
            Basic("መደብ", 4),
            Basic("አበቅቴ", 5),
            Basic("መጥቀዕ", 6),
          ],
        ),
      );
    }
  }
}

class YearInput extends StatelessWidget {
  const YearInput();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 30, right: 10, bottom: 20),
              child: Consumer<LocalBahireHasab>(
                builder: (_, value, __) {
                  return TextField(
                    // maxLength: 4,
                    keyboardType: TextInputType.number,
                    onChanged: (textvalue) => value.update(textvalue),
                    decoration: const InputDecoration(
                      prefixText: "የ",
                      suffixText: "ዓ.ም",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                    ),
                    style: const TextStyle(fontSize: 25),
                  );
                },
              )),
        ),
        const Expanded(
            child: Text(
          " መሠረታዊ ስሌቶች",
          style: TextStyle(fontFamily: "Power Geez Unicode 1", fontSize: 25),
        ))
      ],
    );
  }
}

class Basic extends StatelessWidget {
  final basicName;
  final index;
  const Basic(this.basicName, this.index);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<LocalBahireHasab>(
        builder: (_, value, __) {
          return ListTile(
            enabled: false,
            contentPadding: const EdgeInsets.only(left: 30, right: 100),
            title: Text(basicName, style:const TextStyle(fontSize: 20)),
            subtitle: Text(value.valid ? value.getBasic(index) : "የተሳሳተ ግብዓት",
                style: TextStyle(
                    color: value.valid ? Colors.lightBlue : Colors.red,
                    fontSize: 20)),
          );
        },
      ),
    );
  }
}
