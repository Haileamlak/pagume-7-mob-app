import 'package:flutter/material.dart';
import 'package:project1/models/LocalBahireHasab.dart';
import 'package:provider/provider.dart';

class Fastings extends StatelessWidget {
  const Fastings();
  @override
  Widget build(BuildContext context) {
    final phone = MediaQuery.of(context);
    if (phone.orientation == Orientation.portrait) {
      return ChangeNotifierProvider<LocalBahireHasab>(
        create: (context) => LocalBahireHasab(),
        child: ListView(
          children: const [
            YearInput(),
            Padding(padding: EdgeInsets.all(20)),
            Fast("ጾመ ድኅነት", 1),
            Padding(padding: EdgeInsets.all(10)),
            Fast("ጾመ ነነዌ", 2),
            Padding(padding: EdgeInsets.all(10)),
            Fast("ዐቢይ ጾም", 3),
            Padding(padding: EdgeInsets.all(10)),
            Fast("ጾመ ሐዋርያት", 4),
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
            Fast("ጾመ ድኅነት", 1),
            Fast("ጾመ ነነዌ", 2),
            Fast("ዐቢይ ጾም", 3),
            Fast("ጾመ ሐዋርያት", 4),
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
                onChanged: (textvalue) => value.update(textvalue),
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
          "የአጽዋማት ማውጫ",
          style: TextStyle(fontFamily: "Power Geez Unicode 1", fontSize: 25),
        ))
      ],
    );
  }
}


class Fast extends StatelessWidget {
  final fastName;
  final index;
  const Fast(this.fastName, this.index);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<LocalBahireHasab>(
        builder: (_, value, __) {
          return ListTile(
            enabled: false,
            contentPadding: const EdgeInsets.only(left: 30, right: 100),
            title: Text(fastName, style: const TextStyle(fontSize: 20)),
            subtitle: Text(value.valid ? value.getFast(index) : "የተሳሳተ ግብዓት",
                style:  TextStyle(color:value.valid ? Colors.lightBlue:Colors.red, fontSize: 20)),
          );
        },
      ),
    );
  }
}
