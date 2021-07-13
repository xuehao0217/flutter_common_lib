import 'package:flutter/material.dart';
import 'package:flutter_common_lib/entity/home_entity.dart';
import 'package:flutter_common_lib/helper/logUtils.dart';
import 'package:flutter_common_lib/net/baseResult.dart';
import 'package:flutter_common_lib/net/httpRequest.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 创 建 人: xueh
/// 创建日期: 2021/7/8 11:24
/// 备注：
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomeDatas> homeItems = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    _getData(isRefresh: true);
  }

  var index = 0;

  void _getData({bool isRefresh = false}) {
    HttpRequest.getInstance()
        .get<HomeEntity>("article/list/${index}/json", null, (data) {
      setState(() {
        if (isRefresh) {
          homeItems.clear();
          homeItems.addAll(data.datas);
        } else {
          homeItems.addAll(data.datas);
        }
        _refreshController.refreshCompleted();
      });
    });
  }

  void _onLoading() async {
    index += 1;
    _getData();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: ClassicHeader(),
        footer: ClassicFooter(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) =>
              Card(child: Center(child: Text(homeItems[i].title))),
          itemExtent: 100.0,
          itemCount: homeItems.length,
        ),
      ),
    );
  }
}
