import 'package:flutter/material.dart';
import 'package:project1/models/NumberConvertorModel.dart';
import 'package:provider/provider.dart';

class NumberConvertor extends StatelessWidget {
  const NumberConvertor();
  @override
  Widget build(BuildContext context) {
    final phone = MediaQuery.of(context);
    if (phone.orientation == Orientation.portrait) {
      return ChangeNotifierProvider<NumberConvertorModel>(
        create: ((context) => NumberConvertorModel()),
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("ከአረብ ቁጥር ወደ ኢትዮጵያ ቁጥር"),
            ),
            EthioNumInput(),
            ConvertedNum()
          ],
        ),
      );
    } else {
      return ChangeNotifierProvider<NumberConvertorModel>(
        create: ((context) => NumberConvertorModel()),
        child: Row(
          children: const [
            Expanded(
              child: EthioNumInput(),
            ),
            Expanded(child: ConvertedNum()),
          ],
        ),
      );
    }
  }
}

class ConvertedNum extends StatelessWidget {
  const ConvertedNum();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<NumberConvertorModel>(
        builder: (_, value, __) {
          return ListTile(
            title: value.valid
                ? Text("${value.num}" " = ",
                    style:
                        const TextStyle(color: Colors.lightBlue, fontSize: 25))
                : const Text(
                    "የተሳሳተ ግብዓት",
                    style: TextStyle(color: Colors.red),
                  ),
            trailing: value.valid
                ? Text(value.etNum,
                    style: const TextStyle(color: Colors.orange, fontSize: 25))
                : const Text(
                    "የተሳሳተ ግብዓት",
                    style: TextStyle(color: Colors.red),
                  ),
          );
        },
      ),
    );
  }
}

class EthioNumInput extends StatelessWidget {
  const EthioNumInput();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 30, top: 30),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), border: Border.all()),
      child: Consumer<NumberConvertorModel>(
        builder: (_, value, __) {
          return TextField(
            style: const TextStyle(fontSize: 40, color: Colors.lightBlue),
            onChanged: (textValue) {
              value.convert(textValue);
            },
            decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 20),
                label: Text("ቀጥር"),
                contentPadding: EdgeInsets.all(5)),
          );
        },
      ),
    );
  }
}
