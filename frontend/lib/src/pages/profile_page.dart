import 'package:flutter/material.dart';

import '../widgets/sum_points.dart';
import '../widgets/point_last_week.dart';

import '../models/user.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage(this.user, {Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(user);
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState(this.user);
  User user;
  late ScrollController _controller;
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener); //the listener for up and down.
    super.initState();
  }

  List<double> getDoubles(list) {
    List<double> ans = [];
    list.cast<List<Map<String, double>>>();
    for (var item in list) {
      ans.add(double.parse(item['value'].toString()));
    }
    return ans;
  }

  Widget _userStats() {
    return ListView(
      controller: _controller,
      shrinkWrap: true,
      children: [
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: [
            //TODO: implement user.current_points here
            AllPoints(user.currentPoints),
            Container(
              child: Text("data"),
              color: Colors.amber,
            ),
            Container(
              child: Text("data"),
              color: Colors.amber,
            ),
            Container(child: Text("data"), color: Colors.amber),
          ],
        ),
        //TODO: implement user.points into this chart
        PointWeek(getDoubles(user.points)),
        // Flexible(child: child)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
              alignment: Alignment.centerRight,
              child: Ink(
                  decoration: const ShapeDecoration(
                      shape: CircleBorder(), color: Colors.cyan),
                  child: IconButton(
                      onPressed: _editData(),
                      icon: const Icon(Icons.edit),
                      color: Colors.white))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
            child: Container(
              width: double.infinity,
              child: Text(user.name),
              color: Colors.amber,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Container(width: double.infinity, child: Text(user.email)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Container(width: double.infinity, child: Text(user.contact)),
          ),
          Divider(),
          _userStats()
        ],
      ),
    );
  }

//todo: add edit function to user model
  _editData() {}
}
