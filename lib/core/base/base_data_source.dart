import 'dart:io';
import 'package:fit_tracker/lib.dart';

abstract class BaseDataSource {
  Future<T> catchOrThrow<T>(
    Future<T> Function() body,
  ) async {
    try {
      return await body();
    } on SocketException {
      throw const BaseException(
        MessageConstant.error,
      
      );
    }
  }
}
