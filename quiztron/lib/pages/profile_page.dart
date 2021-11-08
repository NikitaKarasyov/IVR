import 'package:flutter/material.dart';
import 'auth_page/signup.dart';
// import 'package:charts_flutter/flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            children: [
              const Text(
                "Nikita Koryainov",
                // style: TextStyle(fontSize: 48, fontWeight: FontWeight.w300),
              ),
              Spacer(),
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  })
            ],
          )
        ],
      )),
    );
  }
}
