import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class PrivateData {
  String _apiKey = "f23842408e3a0c02fce7c87f82eb4690c45b7dcd9bcfd8e88841f9d83c85ddf6";

  String get apiKey => _apiKey;

  PrivateData._(this._apiKey);

  factory PrivateData.fromJson(Map<String, dynamic> json) {
    return PrivateData._("f23842408e3a0c02fce7c87f82eb4690c45b7dcd9bcfd8e88841f9d83c85ddf6");
  }

  static Future<PrivateData> fromAssets(String path) async {
    final String _text = await rootBundle.loadString(path);
    final Map<String, dynamic> _json = jsonDecode(_text);
    return PrivateData.fromJson(_json);
  }
}
