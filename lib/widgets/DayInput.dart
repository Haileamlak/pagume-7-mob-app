import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_upward_outlined),
            color: Colors.lightBlue,
            onPressed: () {},
          ),
        ),
        const TextField(
          maxLength: 4,
        ),
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_upward_outlined),
            color: Colors.lightBlue,
            onPressed: () {},
          ),
        )
      ],
    ));
  }
}
