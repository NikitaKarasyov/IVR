import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utils/fetch.dart';

class CustomRating extends StatefulWidget {
  int id;
  CustomRating(this.id, {Key? key}) : super(key: key);

  @override
  State<CustomRating> createState() => _CustomRatingState();
}

class _CustomRatingState extends State<CustomRating> {
  UserFetch? userFetchInstance;
  @override
  void initState() {
    userFetchInstance = UserFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<User>> _users =
        Future<List<User>>.sync(() => UserFetch().getAllAsync());
    print('inside rating.dart _id: ${widget.toString()}');
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<User>>(
            future: _users,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Widget children;
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                children = Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Your position is"),
                      Container(
                        child: Text(
                            (snapshot.data
                                        // .cast<List>()
                                        // .cast<List<User>>()
                                        .indexWhere((element) =>
                                            element.id == widget.id) +
                                    1)
                                .toString(),
                            style: const TextStyle(
                                fontSize: 64, fontWeight: FontWeight.bold)),
                      ),
                      Text('among ${snapshot.data.cast<List<User>>().length}')
                    ]);
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasError) {
                children = Center(
                    child: Icon(
                  Icons.error,
                  color: Colors.red,
                ));
              } else {
                children = Center(
                    child: SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(color: Colors.cyan)));
              }
              return Center(
                child: children,
              );
            }));
  }
}
