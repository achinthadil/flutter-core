import 'package:dio/dio.dart';

class DioRequestRetrier {
  final Dio dio;

  int retryCount = 0;
  final int maxRetries = 3;

  DioRequestRetrier({
    required this.dio,
  });

  Future<void> scheduleRequestRetry(RequestOptions requestOptions) async {
    if (retryCount >= maxRetries) {
      throw DioException(requestOptions: requestOptions);
    }
    retryCount++;
    final response = await dio.request(
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

    if (response.statusCode != 200) {
      // In case you want to retry only on specific status codes.
      throw DioException(requestOptions: requestOptions);
    }
  }
}
