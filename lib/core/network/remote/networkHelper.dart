import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'end_points.dart';

class NetworkingHelper {
  final String endPoint;
  late Dio _dio;
  late CookieJar _cookieJar;
  Map<String, dynamic> _headers = {};
  late Options _options;

  NetworkingHelper({required this.endPoint}) {
    _cookieJar = CookieJar();
    _dio = Dio();
    _dio.interceptors.add(CookieManager(_cookieJar));
    _cookieJar.loadForRequest(Uri.parse(baseUrl));
    _headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    _options = Options(
        followRedirects: false,
        headers: _headers,
        validateStatus: (status) {
          return status! <= 500;
        });
  }

  Future<Response> get(
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameter}) async {
    try {
      Response response = await _dio.get(endPoint,
          options: _options.copyWith(
              contentType: "application/json", headers: headers),
          queryParameters: queryParameter ?? {});
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> post(
      {Map<String, dynamic>? postRequest,
      Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.post(endPoint,
          data: postRequest, options: _options.copyWith(headers: headers));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> patch(
      {Map<String, dynamic>? postRequest,
      Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.patch(endPoint,
          data: postRequest, options: _options.copyWith(headers: headers));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> put(
      {Map<String, dynamic>? postRequest,
      Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.put(endPoint,
          data: postRequest, options: _options.copyWith(headers: headers));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> deleteData(
      {Map<String, dynamic>? postRequest,
      Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.delete(endPoint,
          data: postRequest, options: _options.copyWith(headers: headers));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> refreshToken(
      {Map<String, dynamic>? postRequest,
      Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.post(endPoint,
          data: postRequest, options: _options.copyWith(headers: headers));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
