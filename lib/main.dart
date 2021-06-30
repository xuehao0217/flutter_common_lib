import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_common_lib/entity/banner_entity_entity.dart';
import 'package:flutter_common_lib/helper/logUtils.dart';
import 'package:logger/logger.dart';

import 'net/httpRequest.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key) {
    HttpRequest.getInstance().putHeadr("name", "xuehao");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _banner = List<BannerEntityData>();

  @override
  void initState() {
    super.initState();
    HttpRequest.getInstance().get("banner/json", null, (data) {
      setState(() {
        _banner = BannerEntity().fromJson(data).data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: _banner.length,
          itemBuilder: (context, index) => buildItem(_banner[index])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildItem(BannerEntityData data) => Container(
        color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                data.imagePath,
                // width: 200,
                // height: 100,
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text(data.desc), SizedBox(height: 20)],
                )),
          ],
        ),
      );
}
