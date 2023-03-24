import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/LocalBahireHasab.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {}

class Holidays extends StatelessWidget {
  const Holidays();
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
            Holiday("በዓለ ደብረ ዘይት", 1),
            Padding(padding: EdgeInsets.all(5)),
            Holiday("በዓለ ሆሣዕና", 2),
            Padding(padding: EdgeInsets.all(5)),
            Holiday("በዓለ ስቅለት", 3),
            Padding(padding: EdgeInsets.all(5)),
            Holiday("በዓለ ትንሳኤ", 4),
            Padding(padding: EdgeInsets.all(5)),
            Holiday("በዓለ ጰራቅሊጦስ", 5),
            Padding(padding: EdgeInsets.all(5)),
            Holiday("በዓለ ዕርገት", 6)
          ],
        ),
      );
    } else {
      return Provider<LocalBahireHasab>(
        create: (context) => LocalBahireHasab(),
        child: GridView.count(
          crossAxisCount: 2,
          children: const [
            YearInput(),
            Holiday("በዓለ ደብረ ዘይት", 1),
            Holiday("በዓለ ሆሣዕና", 2),
            Holiday("በዓለ ስቅለት", 3),
            Holiday("በዓለ ትንሳኤ", 4),
            Holiday("በዓለ ጰራቅሊጦስ", 5),
            Holiday("በዓለ ዕርገት", 6)
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
          padding:
              const EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 20),
          child: Consumer<LocalBahireHasab>(
            builder: (context, value, child) {
              return TextField(
                // maxLength: 4,
                onChanged: (textvalue) {
                  value.update(textvalue);
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: "የ",
                  suffixText: "ዓ.ም",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                ),
                style: const TextStyle(fontSize: 25),
              );
            },
          ),
        )),
        const Expanded(
            child: Text(
          " የበዓላት ማውጫ",
          style: TextStyle(fontFamily: "Power Geez Unicode 1", fontSize: 25),
        ))
      ],
    );
  }
}

class Holiday extends StatelessWidget {
  final holydayName;
  final index;
  const Holiday(this.holydayName, this.index);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<LocalBahireHasab>(
        builder: (context, value, child) {
          return ListTile(
            enabled: false,
            contentPadding: const EdgeInsets.only(left: 30, right: 100),
            title: Text(holydayName, style: const TextStyle(fontSize: 20)),
            subtitle: Text(value.valid? value.getHoly(index):"የተሳሳተ ግብዓት",
                style:  TextStyle(color: value.valid ? Colors.lightBlue : Colors.red, fontSize: 20)),
          );
        },
      ),
    );
  }
}
