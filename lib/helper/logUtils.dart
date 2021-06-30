import 'package:logger/logger.dart';

class LogUtils {
  static void v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    Logger().v(message, error, stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    Logger().e(message, error, stackTrace);
  }

  static void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    Logger().d(message, error, stackTrace);
  }

  static void w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    Logger().w(message, error, stackTrace);
  }

  static void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    Logger().i(message, error, stackTrace);
  }

  static void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    Logger().wtf(message, error, stackTrace);
  }
}
