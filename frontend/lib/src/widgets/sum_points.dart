import 'package:flutter/material.dart';

class AllPoints extends StatelessWidget {
  final int allpoints;
  const AllPoints(this.allpoints, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(""),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            allpoints.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 64),
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: Text("points in total"),
        )
      ]),
    );
  }
}
