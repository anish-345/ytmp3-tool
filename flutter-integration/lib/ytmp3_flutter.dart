import 'package:ytmp3_flutter/ytmp3_method_channel.dart';
import 'package:flutter/services.dart';

class Ytmp3Flutter {
  Ytmp3Flutter._();
  
  static final Ytmp3Flutter instance = Ytmp3Flutter._();
  
  final MethodChannel _methodChannel = const MethodChannel('ytmp3_flutter');
  
  Future<String> convertToMp3(String url) async {
    try {
      final String result = await _methodChannel.invokeMethod(
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
      final List<dynamic> result = await _methodChannel.invokeMethod(
        'getRecentFiles',
      );
      return result.cast<String>().toList();
    } on PlatformException catch (e) {
      return ["Error: ${e.message}"];
    }
  }
}