import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

part 'network_response.dart';

class NetworkClient {
  NetworkClient._internal() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Optional: add interceptor for extra debugging (you already have logger)
    // _dio.interceptors.add(LogInterceptor(
    //   request: true,
    //   requestHeader: true,
    //   requestBody: true,
    //   responseHeader: false,
    //   responseBody: true,
    //   error: true,
    // ));
  }

  static final NetworkClient instance = NetworkClient._internal();

  late final Dio _dio;
  final Logger _logger = Logger();
  final String _defaultErrorMsg = 'Something went wrong';

  // ---------------- GET ----------------
  Future<NetworkResponse> getRequest({
    required String url,
    required String token,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      _logRequest(url: url, headers: headers);

      final response = await _dio.get(url, options: Options(headers: headers));

      _logResponse(response: response);

      return _successResponse(response);
    } on DioException catch (e) {
      return _dioErrorResponse(e);
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  // ---------------- POST ----------------
  Future<NetworkResponse> postRequest({
    required String url,
    required Map<String, dynamic>? body,
    String? token,
  }) async {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    if (token != null) headers['Authorization'] = 'Bearer $token';

    try {
      _logRequest(url: url, headers: headers, body: body);

      final response = await _dio.post(
        url,
        data: body, // Dio will JSON encode because Content-Type is json
        options: Options(headers: headers),
      );

      debugPrint('Response Data: ${response.data}');

      _logResponse(response: response);

      return _successResponse(response);
    } on DioException catch (e) {
      return _dioErrorResponse(e);
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  // ---------------- PUT ----------------
  Future<NetworkResponse> putRequest({
    required String url,
    required Map<String, dynamic>? body,
    String? token,
  }) async {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    if (token != null) headers['Authorization'] = 'Bearer $token';

    try {
      _logRequest(url: url, headers: headers, body: body);

      final response = await _dio.put(
        url,
        data: body, // Dio will JSON encode because Content-Type is json
        options: Options(headers: headers),
      );

      _logResponse(response: response);

      return _successResponse(response);
    } on DioException catch (e) {
      return _dioErrorResponse(e);
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  // ---------------- DELETE ----------------
  Future<NetworkResponse> deleteRequest({
    required String url,
    required String token,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      _logRequest(url: url, headers: headers);

      final response = await _dio.delete(
        url,
        options: Options(headers: headers),
      );

      _logResponse(response: response);

      return _successResponse(response);
    } on DioException catch (e) {
      return _dioErrorResponse(e);
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  // ---------------- Helpers ----------------

  NetworkResponse _successResponse(Response response) {
    final status = response.statusCode ?? -1;

    
    if (status == 200 || status == 201) {
      final data = _asMap(response.data);
      return NetworkResponse(
        statusCode: status,
        isSuccess: true,
        responseData: data,
      );
    }

    if (status == 401) {
      return NetworkResponse(
        statusCode: status,
        isSuccess: false,
        errorMessage: 'User not found or unauthorized',
      );
    }

    final data = _asMap(response.data);
    return NetworkResponse(
      statusCode: status,
      isSuccess: false,
      errorMessage: data?['message']?.toString() ?? _defaultErrorMsg,
    );
  }

  NetworkResponse _dioErrorResponse(DioException e) {
    final res = e.response;
    final status = res?.statusCode ?? -1;

    // try to read API error message
    final data = _asMap(res?.data);
    final serverMsg = data?['message']?.toString();

    debugPrint('Dio Error: $serverMsg, Status Code: $status, DioException Type: ${e.type}');

    // common cases
    if (status == 401) {
      return NetworkResponse(
        statusCode: status,
        isSuccess: false,
        errorMessage: 'Un Authorize',
      );
    }

    // network / timeout / no internet
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return NetworkResponse(
        statusCode: status,
        isSuccess: false,
        errorMessage: 'Request timeout. Please try again.',
      );
    }

    if (e.type == DioExceptionType.connectionError) {
      return NetworkResponse(
        statusCode: status,
        isSuccess: false,
        errorMessage: 'No internet / connection error.',
      );
    }

    return NetworkResponse(
      statusCode: status,
      isSuccess: false,
      errorMessage: serverMsg ?? e.message ?? _defaultErrorMsg,
    );
  }

  Map<String, dynamic>? _asMap(dynamic data) {
    if (data == null) return null;

    if(data is List){
      return {'items': data};
    }

    if (data is Map<String, dynamic>) return data;

    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map<String, dynamic>) return decoded;
      } catch (_) {}
    }
    if (data is Map) {
      return data.map((k, v) => MapEntry(k.toString(), v));
    }

    return null;
  }

  void _logRequest({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    final message =
        '''
      URL -> $url
      HEADERS -> $headers
      BODY -> $body
      ''';
    _logger.i(message);
  }

  void _logResponse({required Response response}) {
    final message =
        '''
      Status Code -> ${response.statusCode}
      URL -> ${response.requestOptions.uri}
      HEADERS -> ${response.requestOptions.headers}
      BODY -> ${response.data}
      ''';
    _logger.i(message);
  }
}
