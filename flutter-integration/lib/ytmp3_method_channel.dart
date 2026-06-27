import 'package:flutter/services.dart';

class Ytmp3MethodChannel {
  static const MethodChannel _channel = MethodChannel('ytmp3_flutter');

  Future<String> convertToMp3(String url) async {
    try {
      final String result = await _channel.invokeMethod(
        'convertToMp3',
        {'url': url},
      );
      return result;
    } on PlatformException catch (e) {
      return "Error: ${e.message}";
    }
  }

  Future<List<String>> getRecentFiles() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod(
        'getRecentFiles',
      );
      return result.cast<String>().toList();
    } on PlatformException catch (e) {
      return ["Error: ${e.message}"];
    }
  }
}