import 'dart:io';
import 'dart:math';

import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/ClockModel.dart';
import 'package:project1/models/DateConvertorModel.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {}

class HomePage extends StatelessWidget {
  const HomePage();
  @override
  Widget build(BuildContext context) {
    final phone = MediaQuery.of(context);
    return ChangeNotifierProvider<ClockModel>(
      create: (context) => ClockModel(),
      child: ClockDay(phone.orientation),
    );
  }
}

class ClockDay extends StatelessWidget {
  final orientation;
  ClockDay(this.orientation);
  @override
  Widget build(BuildContext context) {
    if (orientation == Orientation.portrait) {
      return ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Clock(constraints.maxWidth);
            }),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return DateTimeWidget(constraints.maxWidth);
            }),
          ),
        ],
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Clock(constraints.maxHeight);
            }),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return DateTimeWidget(constraints.maxHeight);
            }),
          ),
        ],
      );
    }
  }
}

//wall-clock

class Clock extends StatelessWidget {
  final clkRadius;

  const Clock(this.clkRadius);

  @override
  Widget build(BuildContext context) {
    int i = 1;
    return Container(
      width: clkRadius,
      height: clkRadius,
      // margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1),
      ),
      child: Stack(children: <Widget>[
        Positioned(
            top: clkRadius / 2 - 15,
            left: clkRadius / 2 - 15,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
            )),
        //second indicator
        Consumer<ClockModel>(
          builder: (_, value, __) {
            value.update();
            return Transform.rotate(
              angle: pi / 2 + pi / 180 * value.second * 6,
              child: Center(
                child: Divider(
                  thickness: 1,
                  height: 50,
                  color: Colors.red,
                  endIndent: clkRadius / 2 - 30,
                  indent: 30,
                ),
              ),
            );
          },
        ),

        //minute indicator
        Consumer<ClockModel>(
          builder: (_, value, __) => Transform.rotate(
            angle: pi / 2 + (pi / 180 * value.minute * 6),
            child: Center(
              child: Divider(
                thickness: 2,
                height: 50,
                color: Colors.yellow,
                endIndent: clkRadius / 2 - 30,
                indent: 45,
              ),
            ),
          ),
        ),
//hour indicator
        Consumer<ClockModel>(
          builder: (_, value, __) => Transform.rotate(
            angle: pi / 2 + (pi / 180 * (value.hour + value.minute / 60) * 30),
            child: Center(
              child: Divider(
                thickness: 3,
                height: 50,
                color: Colors.green,
                endIndent: clkRadius / 2 - 30,
                indent: 60,
              ),
            ),
          ),
        ),
        for (double t = (clkRadius / 2) -
                    (clkRadius / 2 - 20) * cos(pi / 6 * i) -
                    10,
                l = (clkRadius / 2) +
                    (clkRadius / 2 - 20) * sin(pi / 6 * i) -
                    10;
            i <= 12;
            i++,
            t = (clkRadius / 2) - (clkRadius / 2 - 20) * cos(pi / 6 * i) - 10,
            l = (clkRadius / 2) + (clkRadius / 2 - 20) * sin(pi / 6 * i) - 10)
          Hour("$i", t, l)
      ]),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  final width;
  const DateTimeWidget(this.width);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width / 2,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [Time(), Date()],
      ),
    );
  }
}

class Time extends StatelessWidget {
  const Time();
  @override
  Widget build(BuildContext context) {
    return Consumer<ClockModel>(
      builder: (_, value, __) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${value.hour}",
              style: const TextStyle(fontSize: 40, color: Colors.green)),
          Text("${value.minute}",
              style: const TextStyle(fontSize: 40, color: Colors.yellow)),
          Text("${value.second}",
              style: const TextStyle(fontSize: 40, color: Colors.red))
        ],
      ),
    );
  }
}

class Date extends StatelessWidget {
  const Date();
  @override
  Widget build(BuildContext context) {
    final date = EtDatetime.now();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${date.monthGeez} ${date.day} ${date.year} ዓ.ም",
          style: const TextStyle(fontSize: 25, color: Colors.lightBlue),
        ),
        Text("${date.weekday}",
            style: TextStyle(fontSize: 25, color: Colors.lightBlue))
      ],
    );
  }
}

class Hour extends StatelessWidget {
  final text, top, left;

  const Hour(this.text, this.top, this.left);
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.lightBlue),
        ));
  }
}
