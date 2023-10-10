// import 'package:appcepos_vp/utils/api_exception.dart';
// import 'package:appcepos_vp/utils/network_exceptions.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

part of 'utils.dart';

const _defaultConnectTimeout = 20000; // Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = 20000; // Duration.millisecondsPerMinute;

class DioClient {
  final String baseUrl;

  Dio? _dio;

  final List<Interceptor>? interceptors;

  DioClient(
    this.baseUrl,
    Dio? dio, {
    this.interceptors,
  }) {
    _dio = dio ?? Dio();
    _dio!
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    if (interceptors?.isNotEmpty ?? false) {
      _dio!.interceptors.addAll(interceptors!);
    }

    if (kDebugMode) {
      /* _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: false)); */
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      String errorMessage = '';
      DioError? dioError;
      if (e is DioError) {
        dioError = e;
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data['message'] != null) {
          errorMessage = e.response!.data['message'];
        } else {
          final networkError = NetworkExceptions.getDioException(e);
          errorMessage = NetworkExceptions.getErrorMessage(networkError);
        }
      } else {
        final networkError = NetworkExceptions.getDioException(e);
        errorMessage = NetworkExceptions.getErrorMessage(networkError);
      }
      throw ApiException(errorMessage, dioError: dioError);
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      String errorMessage = '';
      DioError? dioError;
      if (e is DioError) {
        dioError = e;
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data['message'] != null) {
          errorMessage = e.response!.data['message'];
        } else {
          final networkError = NetworkExceptions.getDioException(e);
          errorMessage = NetworkExceptions.getErrorMessage(networkError);
        }
      } else {
        final networkError = NetworkExceptions.getDioException(e);
        errorMessage = NetworkExceptions.getErrorMessage(networkError);
      }
      throw ApiException(errorMessage, dioError: dioError);
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      String errorMessage = '';
      DioError? dioError;
      if (e is DioError) {
        dioError = e;
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data['message'] != null) {
          errorMessage = e.response!.data['message'];
        } else {
          final networkError = NetworkExceptions.getDioException(e);
          errorMessage = NetworkExceptions.getErrorMessage(networkError);
        }
      } else {
        final networkError = NetworkExceptions.getDioException(e);
        errorMessage = NetworkExceptions.getErrorMessage(networkError);
      }
      throw ApiException(errorMessage, dioError: dioError);
    }
  }
}
