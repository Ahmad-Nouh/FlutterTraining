import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool isSearch = true;
  List<Statistic> countriesStatistics = [];
  StreamBuilder<http.Response> streamBuilder;


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
      if (row['Country'].toString().length > 0) {
        decodedData.add(new Statistic.fromJson(row));
      }
    });

    return decodedData;
  }
  @override
  void initState() {
    // init stream builder
    this.streamBuilder = StreamBuilder(
      stream: Stream.fromFuture(http.get('https://api.covid19api.com/summary')),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Dialog(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Container(
                        child: Text('Please Wait..'),
                        margin: EdgeInsets.only(left: 20),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(30.0),
                )
            );
          case ConnectionState.done:
          case ConnectionState.active:
            this.countriesStatistics = decodeData(json.decode(snapshot.data.body));
            return SingleChildScrollView(child: SummaryTable(data: this.countriesStatistics,));
          case ConnectionState.none:
            return Center(child: Text('Nothing to show'),);
          default:
            return Container();
        }
      },
    );

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: this.isSearch ?
              Text('Corona Statistics') :
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search By Country Name...'
                ),
                onChanged: (String text) {
                  var childKey = GlobalKey<SummaryTableState>();
                  SummaryTable(key: childKey,);
                  setState(() {
                    childKey.currentState.updateTableData(
                        this.countriesStatistics.where((Statistic item) => item.country.toLowerCase().startsWith(text)).toList()
                    );
                  });
                },
              ),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            this.isSearch ?
              IconButton(icon: Icon(Icons.search), onPressed: () => setState(() => this.isSearch = false)) :
              IconButton(icon: Icon(Icons.cancel), onPressed: () => setState(() => this.isSearch = true))

          ],
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: this.streamBuilder,
        ),
      ),
      theme: ThemeData.dark(),
    );
  }

}