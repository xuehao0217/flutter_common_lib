import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 创 建 人: xueh
 * 创建日期: 2021/7/15 11:16
 * 备注：
 */
class CommonListView extends StatelessWidget {
  var currentPageIndex = 0;
  final RefreshController refreshController;
  final bool enablePullDown;
  final bool enablePullUp;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final bool initialRefresh;
  final List<Widget> header;
  final List<Widget> footer;
  final int itemCount;
  final ScrollController scrollController;
  final IndexedWidgetBuilder itemBuilder;

  CommonListView(
      {this.refreshController,
      this.enablePullDown: true,
      this.enablePullUp: true,
      this.onLoading,
      this.onRefresh,
      this.itemBuilder,
      this.header,
      this.footer,
      this.itemCount: 0,
      this.scrollController,
      this.initialRefresh: false});

  @override
  Widget build(BuildContext context) {
    return enablePullUp || enablePullDown
        ? SmartRefresher(
            enablePullUp: enablePullUp,
            enablePullDown: enablePullDown,
            controller: refreshController ??
                RefreshController(initialRefresh: initialRefresh),
            onRefresh: onRefresh,
            onLoading: onLoading,
            child: getListView(),
          )
        : getListView();
  }

  int getHeaderCount() {
    return header == null ? 0 : header.length;
  }

  int getFooterCount() {
    return footer == null ? 0 : footer.length;
  }

  Widget getListView() => ListView.builder(
      itemCount: getHeaderCount() + getItemCount() + getFooterCount(),
      padding: EdgeInsets.all(0),
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < getHeaderCount()) {
          return header[index];
        } else if (index > getHeaderCount() + getItemCount() - 1) {
          return footer[index - getHeaderCount() - getItemCount()];
        } else {
          return itemBuilder(context, index - getHeaderCount());
        }
      });

  getItemCount() => itemCount;
}
