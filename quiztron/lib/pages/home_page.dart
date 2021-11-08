import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiztron/pages/profile_page.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  // @override
  // void initState() {
  //   super.initState();
  // }

  // var _quizes = [];
  // void fetchQuizes() async {
  //   try {
  //     final response = await http.get(Uri.parse("${Env.URL_PREFIX}"));
  //     final jsondata = await jsonDecode(response.body) as List;
  //     setState(() {
  //       _quizes = jsondata;
  //     });
  //   } catch (err) {
  //     throw err;
  //   }
  // }
  const List<String> names = ["Кубок All Stars", "Квиз, риск, логика!", "Угадай мелодию. 90е и 00е","№128.3", "Классика №286_3", "Ужасный FUN #126_3", "№129.2", "#396", "F.R.I.E.N.D.S","Интеллектуальная игра #141", ""];
  const List<String> time = ["09.11 в 19:00", "09.11 в 19:30", "09.11 в 20:00", "13.11 в 18:00", "13.11 в 18:00", "13.11 в 20:00", "19.11 в 20:00", "19.11 в 20:30", "21.11 в 18:00", "23.11 в 20:00"];
  
  
  // @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            }, icon: Icon(Icons.person))
          ],
          leading: IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              // d_picker = DatetimePick
            },
          ),
        ),
        body: Column(
          children: [
            ListTile(
                title: Text("Кубок All Stars"),
                subtitle: Text("09.11 в 20:00"),
                trailing: (IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_outlined))),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.people))),
            ListTile(
                title: Text("Квиз, риск, логика!"),
                subtitle: Text("09.11 в 19:30"),
                trailing: (IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_outlined))),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.people))),
            ListTile(
                title: Text("Угадай мелодию. 90е и 00е"),
                subtitle: Text("09.11 в 20:00"),
                trailing: (IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_outlined))),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.people))),
            ListTile(
                title: Text("№128.3"),
                subtitle: Text("13.11 в 18:00"),
                trailing: (IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_outlined))),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.people))),
            ListTile(
                title: Text("Классика №286_3"),
                subtitle: Text("13.11 в 18:00"),
                trailing: (IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_outlined))),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.people))),
            ListTile(
                title: Text("Ужасный FUN #126_3"),
                subtitle: Text("13.11 в 20:00"),
                trailing: (IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_outlined))),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.people))),
            ListTile(
                title: Text("№129.2"),
                subtitle: Text("19.11 в 20:00"),
                trailing: (IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_outlined))),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.people))),
            ListTile(
                title: Text("#396"),
                subtitle: Text("19.11 в 20:30"),
                trailing: (IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_outlined))),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.people))),
            ListTile(
                title: Text("F.R.I.E.N.D.S"),
                subtitle: Text("21.11 в 18:00"),
                trailing: (IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_outlined))),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.people))),
            ListTile(
                title: Text("Интеллектуальная игра #141"),
                subtitle: Text("23.11 в 20:00"),
                trailing: (IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_outlined))),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.people))),
          ],
        ));
  }
}

class QuizListItem extends StatelessWidget {
  const QuizListItem({Key? key, int? index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        // title: "",
        // subtitle: quizes['description'],
        );
  }
}

class Tile extends StatelessWidget {
    const Tile({ Key? key String name, String time}) : super(key: key);
  
  String name;
  String time;
    @override
    Widget build(BuildContext context) {
      return ListTile( title: Text("Кубок All Stars"),
                subtitle: Text("09.11 в 20:00"),
                trailing: (IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_outlined))),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.people)),);
    }
  }