import 'package:flutter/material.dart';
import 'package:frontend/src/constants/api.dart';
import 'package:frontend/src/models/QuizOfUser.dart';

import '../widgets/theme_chip.dart';
import '../utils/to_normal_date.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../utils/fetch.dart';

class QuizCard extends StatefulWidget {
  final int id;
  final String name;
  final String description;
  final DateTime date;
  final List<dynamic> theme;
  final String url;
  final User currentUser;

  QuizCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.description,
      required this.date,
      required this.theme,
      required this.currentUser,
      required this.url})
      : super(key: key);

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  @override
  // void initState() {
  //   QuizOfUserFetch instance = QuizOfUserFetch();
  //   if (instance.qof
  //           .firstWhere((element) => element.id == widget.currentUser.id)
  //           .quiz_id ==
  //       widget.id) _participating = true;
  //   super.initState();
  // }

  // void liked(int quiz_id, User currentUser) async {
  List<Widget> generateThemeWrap() {
    List<Widget> chips = [];
    widget.theme.forEach((element) {
      print(element.toString());
      chips.add(ThemeChip(name: element['name']));
    });
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<QuizOfUser>> _qof =
        Future<List<QuizOfUser>>.sync(() => QuizOfUserFetch().getallAsync());
    bool _participating = false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                )),
            Text(toNormal(widget.date).toLocal().toString().substring(5, 16)),
            Text(
              widget.description,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: generateThemeWrap(),
              crossAxisAlignment: WrapCrossAlignment.end,
            ),
            Divider(
              color: Colors.white,
            ),
            Row(
              children: [
                Container(
                  child: FutureBuilder<List<QuizOfUser>>(
                      future: _qof,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        print("snapshot data: ${snapshot.data}");
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          int? _findingId = 0;
                          for (QuizOfUser item in snapshot.data!) {
                            print("--------------");
                            print('item.quiz_id ${item.quiz_id}');
                            print('widget.id ${widget.id}');
                            print('----    -----    -----  ---');
                            print('item.user_id ${item.user_id}');
                            print(
                                'widget.currentUser.id ${widget.currentUser.id}');
                            if (item.quiz_id == widget.id &&
                                item.user_id == widget.currentUser.id) {
                              _findingId = item.id;
                              break;
                            }
                          }
                          if (_findingId != 0) _participating = true;
                          return TextButton.icon(
                              style: ButtonStyle(),
                              onPressed: () async {
                                if (!_participating) {
                                  print('adding');
                                  QuizOfUserFetch instance = QuizOfUserFetch();
                                  List<QuizOfUser> _allConnections =
                                      await instance.getallAsync();
                                  QuizOfUser connection = QuizOfUser(
                                      id: _allConnections.length + 1,
                                      quiz_id: widget.id,
                                      user_id: widget.currentUser.id);
                                  instance.postQOF(connection);
                                  setState(() {
                                    _participating = !_participating;
                                  });
                                } else {
                                  print('deleting $_findingId');
                                  QuizOfUserFetch instance = QuizOfUserFetch();
                                  List<QuizOfUser> _allconnections =
                                      await instance.getallAsync();
                                  QuizOfUser? objToDelete;
                                  for (var item in _allconnections) {
                                    if (_findingId == item.id) {
                                      objToDelete = item;
                                      break;
                                    }
                                  }
                                  instance.deleteQOF(objToDelete!);
                                  setState(() {
                                    _participating = !_participating;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                              ),
                              label: Text(
                                _participating ? "Participating" : "Join",
                                style: const TextStyle(color: Colors.white),
                              ));
                        } else if (snapshot.hasError &&
                            snapshot.connectionState == ConnectionState.done)
                          return Text('smth went wrong');
                        else
                          return Center(
                              child: SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(),
                          ));
                      }),
                ),
                Container(
                  child: TextButton.icon(
                    label: Text(
                      'find a team',
                      style: const TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.group,
                      color: Colors.white,
                    ),
                    onPressed: null,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _participate(bool p) async {
    print('adding');
    QuizOfUserFetch instance = QuizOfUserFetch();
    List<QuizOfUser> _allConnections = await instance.getallAsync();
    QuizOfUser connection = QuizOfUser(
        id: _allConnections.length + 1,
        quiz_id: widget.id,
        user_id: widget.currentUser.id);
    instance.postQOF(connection);
    setState(() {
      p = !p;
    });
  }

  _unparticipate(bool p, int id) async {
    print('deleting $id');
    QuizOfUserFetch instance = QuizOfUserFetch();
    List<QuizOfUser> _allconnections = await instance.getallAsync();
    instance.deleteQOF(_allconnections[id]);
    setState(() {
      p = !p;
    });
  }
}
