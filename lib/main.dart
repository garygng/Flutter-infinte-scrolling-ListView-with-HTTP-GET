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
  ScrollController _scrollcontroller = new ScrollController();

  @override
  void initState() {
    // implement initState
    super.initState();
    fetchFive();

    _scrollcontroller.addListener(() {
      print(_scrollcontroller.position.pixels);
      if (_scrollcontroller.position.pixels ==
          _scrollcontroller.position.maxScrollExtent) {
        // If we are at the bottom of the page
        fetchFive();
      }
    });
  }

  @override
  void dispose() {
    // implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("ListView"),
        ),
        body: ListView.builder(
          controller: _scrollcontroller,
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
