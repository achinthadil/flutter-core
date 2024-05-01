import 'package:dio/dio.dart' as dio_res;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../init_dependencies.dart';
import '../constants/core_constants.dart';
import 'retry_request.dart';

class AppDio {
  final sharedPreferences = serviceLocator<SharedPreferences>();
  final dio = Dio(
    BaseOptions(
      baseUrl: CoreConstants.baseUrl,
    ),
  );
  final logger = Logger();
  DioRequestRetrier? dioRequestRetrier;

  Dio getDio() {
    dio.options.headers['Accept'] = 'application/json';

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, requestInterceptorHandler) async {
          logger.d(options.data);
          logger.d('${options.uri}/${options.queryParameters}');

          //! read the key from get storage
          String? idToken = sharedPreferences.getString(
            CoreConstants.userToken,
          );

          debugPrint('😂TOKEN:: $idToken');

          if (idToken != "") {
            options.headers["Authorization"] = 'Bearer $idToken';
            logger.d(options.headers);
            if (kDebugMode) {
              print("idToken found in box");
              print("Bearer token added to authorization header");
            }
          }
          return requestInterceptorHandler.next(options);
        },
        onResponse: (response, responseInterceptorHandler) async {
          logger.d(response);
          return responseInterceptorHandler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {
            RequestOptions requestOptions = error.requestOptions;

            dioRequestRetrier ??= DioRequestRetrier(
              dio: dio,
            );

            bool isTokenRefreshed = true;

            // Only retry if the token is successfully refreshed
            if (isTokenRefreshed) {
              // The scheduleRequestRetry will automatically take care of the retry count
              try {
                await dioRequestRetrier?.scheduleRequestRetry(requestOptions);
              } catch (e) {
                return handler.next(error);
              }

              requestOptions.headers["Authorization"] =
                  // ignore: prefer_interpolation_to_compose_strings
                  'Bearer ' +
                      sharedPreferences.getString(
                        CoreConstants.userToken,
                      )!;

              try {
                dio_res.Response response = await dio.request(
                  requestOptions.path,
                  cancelToken: requestOptions.cancelToken,
                  data: requestOptions.data,
                  onReceiveProgress: requestOptions.onReceiveProgress,
                  onSendProgress: requestOptions.onSendProgress,
                  queryParameters: requestOptions.queryParameters,
                  options: Options(
                    method: requestOptions.method,
                    headers: requestOptions.headers,
                    contentType: requestOptions.contentType,
                  ),
                );
                return handler.resolve(response);
              } catch (e) {
                return handler.next(
                    DioException(requestOptions: requestOptions, error: e));
              }
            }
          } else {
            return handler.next(error);
          }
        },
      ),
    );

    return dio;
  }
}
