import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> dogImages = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFive();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("ListView"),
        ),
        body: ListView.builder(
          itemCount: dogImages.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              constraints: BoxConstraints.tightFor(height: 150.0),
              child: Image.network(
                dogImages[index],
                fit: BoxFit.fitWidth,
              ),
            );
          }, // itemBuilder
        ),
      ),
    );
  }

  fetch() async {
    var url = 'https://dog.ceo/api/breeds/image/random';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        dogImages.add(json.decode(response.body)['message']);
      });
    } else {
      throw Exception('Falied to load image and connecting to the server');
    }
  }

  fetchFive() {
    for (int i = 0; i < 5; i++) {
      fetch();
    }
  }
}
