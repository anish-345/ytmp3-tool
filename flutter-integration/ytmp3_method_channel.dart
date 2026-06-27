import 'package:flutter/services.dart';

class Ytmp3MethodChannel {
  static const MethodChannel _channel = MethodChannel('ytmp3');

  Future<String> convertYoutubeToMp3(String url) async {
    final String result = await _channel.invokeMethod('convertToMp3', {'url': url});
    return result;
  }

  Future<List<String>> getRecentMp3Files() async {
    final List<dynamic> result = await _channel.invokeMethod('getRecentFiles');
    return result.cast<String>().toList();
  }
}
