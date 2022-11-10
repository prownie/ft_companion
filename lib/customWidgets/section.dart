import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class section extends StatelessWidget {
  section(this.coaData, this.name, {super.key});

  dynamic coaData;
  dynamic name;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              // color: coaData != null ? Color(coaData['color']) : Colors.white,
              border: Border.all(
                  width: 3,
                  color:
                      coaData != null ? Color(coaData['color']) : Colors.white),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  // style: TextStyle(fontSize: 35),
                  style: TextStyle(fontSize: 35, color: Colors.white),
                )
              ]),
        ));
  }
}
