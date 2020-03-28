import 'package:flutter/material.dart';
import 'package:flutter_app/models/Statistic.dart';

class SummaryTable {
  Table _instance;

  final List<String> columns = [
    'Country',
//    'NewConfirmed',
    'Total Confirmed',
//    'NewDeaths',
    'Total Deaths',
//    'NewRecovered',
//    'TotalRecovered'
  ];

  SummaryTable(List<Statistic> data) {
    List<TableRow> rows = setupHeader() + data.map((Statistic element) {
      return initRow(element);
    }).toList();

    this._instance = Table(
      children: rows,
    );
  }

  List<TableRow> setupHeader() {
    List<Column> headerElements = this.columns.map((column) {
      return Column(
          children: <Widget>[
            Container(
              child: Text(column, textAlign: TextAlign.center,),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              color: Colors.indigo,
              alignment: Alignment.center,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
      );
    }).toList();
    return [
      TableRow(children: headerElements)
    ];
  }

  TableRow initRow(Statistic data) {
    return TableRow(
        children: [
          Column(
              children: <Widget>[
                Container(
                  child: Text(data.country, textAlign: TextAlign.center,),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch
          ),
//          Column(
//              children: <Widget>[
//                Container(
//                  child: Text(data.newConfirmed.toString()),
//                  padding: EdgeInsets.all(5),
//                ),
//              ],
//              crossAxisAlignment: CrossAxisAlignment.stretch
//          ),
          Column(
              children: <Widget>[
                Container(
                  child: Text(data.totalConfirmed.toString(), textAlign: TextAlign.center, ),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch
          ),
//          Column(
//              children: <Widget>[
//                Container(
//                  child: Text(data.newDeaths.toString()),
//                  padding: EdgeInsets.all(5),
//                ),
//              ],
//              crossAxisAlignment: CrossAxisAlignment.stretch
//          ),
          Column(
              children: <Widget>[
                Container(
                  child: Text(data.totalDeaths.toString(), textAlign: TextAlign.center,),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch
          ),
//          Column(
//              children: <Widget>[
//                Container(
//                  child: Text(data.newRecovered.toString()),
//                  padding: EdgeInsets.all(5),
//                ),
//              ],
//              crossAxisAlignment: CrossAxisAlignment.stretch
//          ),
//          Column(
//              children: <Widget>[
//                Container(
//                  child: Text(data.totalRecovered.toString()),
//                  padding: EdgeInsets.all(5),
//                ),
//              ],
//              crossAxisAlignment: CrossAxisAlignment.stretch
//          )
        ]
    );
  }

  Table getInstance() {
    return this._instance;
  }
}