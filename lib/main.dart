import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_common_lib/helper/logUtils.dart';
import 'package:flutter_common_lib/ui/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    return OKToast(
        child: RefreshConfiguration(
        hideFooterWhenNotFull: true,
        child: MaterialApp(
          localizationsDelegates: [
            // 这行是关键
            RefreshLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale('zh'),
          ],
          localeResolutionCallback:
              (Locale locale, Iterable<Locale> supportedLocales) {
            //print("change language");
            return locale;
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
      ),
    ));
  }
}
