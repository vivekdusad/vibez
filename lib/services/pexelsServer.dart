// @dart=2.12
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wallpaper_app/constants/constants.dart';
import 'package:wallpaper_app/constants/custom_exceptions.dart';
import 'package:wallpaper_app/models/imagesmodel.dart';

abstract class PexelsServer {
  Future<Images> getBestWallpapers();
}

class PexelsServerBase {
  Future<Response> _getData({required String url}) async {
    // print(url);
    var response = await http.get(Uri.parse(url), headers: {
      "Authorization": api_key,
    });
    return response;
  }

  Images parseImages(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Images>((json) => Images.fromJson(json));
  }

  Future<Images> getBestWallpapers(String url) async {
    Response _response = await _getData(url: url);
    try {
      if (_response.statusCode == 500) {
        throw SocketException("internet");
      }
    } on SocketException {
      throw CustomException(message: "Internet error"); //"Internet error"
    } on FormatException {
      throw CustomException(message: 'Try Again Later'); //"Try Again Later"
    } on HttpException {
      throw CustomException(message: 'Server Error'); //"Server Error"
    }
    final _results = jsonDecode(_response.body);
    // print(_results);

    Map<String, dynamic> map = _results as Map<String, dynamic>;
    Images image = Images.fromMap(map);
    // print(image.photos.first.src.portrait);
    return image;
  }

  Future<Images> getByCategories(String categories, int page) async {
    Response _response = await _getData(
        url:
            "https://api.pexels.com/v1/search/?page=$page&per_page=40&query=$categories");
    try {
      if (_response.statusCode == 500) {
        throw SocketException("internet");
      }
    } on SocketException {
      throw CustomException(message: "Internet error"); //"Internet error"
    } on FormatException {
      throw CustomException(message: 'Try Again Later'); //"Try Again Later"
    } on HttpException {
      throw CustomException(message: 'Server Error'); //"Server Error"
    }
    final _results = jsonDecode(_response.body);
    // print(_results);

    Map<String, dynamic> map = _results as Map<String, dynamic>;
    Images image = Images.fromMap(map);
    // print(image.photos.first.src.portrait);
    return image;
  }
}
