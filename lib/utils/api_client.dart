import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

final dio = Dio();
final dioClient = DioClient('https://ride.notionprojects.tech/api/customer/', dio);

class ApiConstant {
  static const String baseUrl = "https://stingray-app-bbhyv.ondigitalocean.app";
  static String sendWhatsappMessage = "$baseUrl/user/send-whatsapp-message";
}

class DioClient {
  final String baseUrl;

  Dio _dio = Dio();

  final List<Interceptor>? interceptors;

  DioClient(this.baseUrl, Dio dio, {this.interceptors}) {
    final talker = Talker();
    _dio = dio;
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(
        milliseconds: _defaultConnectTimeout,
      )
      ..options.receiveTimeout = const Duration(
        milliseconds: _defaultReceiveTimeout,
      )
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    //_dio.interceptors.add(AuthInterceptor());

    // if (interceptors?.isNotEmpty ?? false) {
    //   _dio.interceptors.addAll(interceptors!);
    // }
    if (kDebugMode) {
      _dio.interceptors.add(
        TalkerDioLogger(
          talker: talker,
          settings: TalkerDioLoggerSettings(
            requestPen: AnsiPen()..green(bold: true),
            // Green http responses logs in console
            responsePen: AnsiPen()..cyan(),
            // Error http logs in console
            errorPen: AnsiPen()..red(),
            printResponseData: true,
            // All http requests disabled for console logging
            printRequestData: true,
            // Reposnse logs including http - headers
            printResponseHeaders: false,
            // Request logs without http - headersa
            printRequestHeaders: true,
          ),
        ),
      );
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
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
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
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

    Future<dynamic> delete(
        String uri, {
          Map<String, dynamic>? queryParameters,
          Options? options,
          CancelToken? cancelToken,
        }) async {
      try {
        var response = await _dio.delete(
          uri,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
        return response.data;
      } on FormatException catch (_) {
        throw const FormatException("Unable to process the data");
      } catch (e) {
        rethrow;
      }
    }
}
