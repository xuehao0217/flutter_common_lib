import 'package:flutter/material.dart';
import 'package:flutter_common_lib/entity/home_entity.dart';
import 'package:flutter_common_lib/helper/logUtils.dart';
import 'package:flutter_common_lib/net/httpRequest.dart';
import 'package:flutter_common_lib/wiget/common_list_view.dart';
import 'package:oktoast/oktoast.dart';
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
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  void _onRefresh() {
    _getData(isRefresh: true);
  }

  var index = 0;

  void _getData({bool isRefresh = false}) {
    HttpRequest.getInstance().get<HomeEntity>("article/list/${index}/json", null, (data) {
      setState(() {
        if (isRefresh) {
          homeItems.clear();
          homeItems.addAll(data.datas);
          _refreshController.refreshCompleted();
        } else {
          homeItems.addAll(data.datas);
          _refreshController.loadComplete();
        }
      });
    });
  }

  void _onLoading() {
    index += 1;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonListView(
        header: [
          Container(
            color: Colors.red,
            height: 300,
          )
        ],
        itemCount: homeItems.length,
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        itemBuilder: (c, i) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            elevation: 0,
            child: Container(
              child: Center(child: Text(homeItems[i].title)),
              height: 100,
            )),
      ),
    );
  }
}
