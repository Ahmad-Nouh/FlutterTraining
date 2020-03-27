import 'package:flutter/material.dart';
import 'package:flutter_app/models/Statistic.dart';
import 'package:flutter_app/src/home/table.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }

}

class MyHomeState extends State<MyHome> {

  TableRow initRow() {
    return TableRow(
      children: [
        Column(
          children: <Widget>[
            Container(
              child: Text('Cell1'),
              padding: EdgeInsets.all(10),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('Cell2'),
              padding: EdgeInsets.all(10),
            ),
          ],
            crossAxisAlignment: CrossAxisAlignment.stretch
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('Cell3'),
              padding: EdgeInsets.all(10),
            ),
          ],
            crossAxisAlignment: CrossAxisAlignment.stretch
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('Cell4'),
              padding: EdgeInsets.all(10),
            ),
          ],
            crossAxisAlignment: CrossAxisAlignment.stretch
        )
      ]
    );
  }

  List<Statistic> decodeData(dynamic data) {
    List<Statistic> decodedData = [];
    List<dynamic> rows = data['Countries'];
    rows.forEach((row) {
      decodedData.add(new Statistic.fromJson(row));
    });

    return decodedData;
  }

  @override
  Widget build(BuildContext context) {
    StreamBuilder<http.Response> streamBuilder = new StreamBuilder(
      stream: Stream.fromFuture(http.get('https://api.covid19api.com/summary')),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          // ignore: missing_return
          case ConnectionState.waiting:
            print(snapshot.data);
            return Dialog(
            child: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                Text('Please Wait..')
              ],
            ),
          );
          case ConnectionState.done:
          case ConnectionState.active:
            List<Statistic> summaryData = decodeData(json.decode(snapshot.data.body));
            SummaryTable summaryTable = new SummaryTable(summaryData);
            return SingleChildScrollView(child: summaryTable.getInstance(),);
          case ConnectionState.none:
            return Center(child: Text('Nothing to show'),);
          default:
            return Container();
        }
      },
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('First App'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: streamBuilder,
        ),
      ),
      theme: ThemeData.dark(),
    );
  }

}