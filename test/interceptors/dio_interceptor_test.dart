import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

void main() {
  late Dio dio;
  late DioInterceptor dioInterceptor1;
  late DioInterceptor dioInterceptor2;

  setUp(() {
    dio = Dio();
  });

  group('DioInterceptor -', () {
    test('if failOnMissingMock is false do not fail on missing mock', () async {
      dioInterceptor1 = DioInterceptor(dio: dio, failOnMissingMock: false);
      dioInterceptor2 = DioInterceptor(dio: dio, failOnMissingMock: false);

      dioInterceptor1.onGet(
        '/interceptor-1-route',
        (server) => server.reply(
          200,
          {'message': 'Success from interceptor 1'},
        ),
      );
      dioInterceptor2.onGet(
        '/interceptor-2-route',
        (server) => server.reply(
          200,
          {'message': 'Success from interceptor 2'},
        ),
      );

      final int1Response = await dio.get('/interceptor-1-route');
      expect(int1Response.data, {'message': 'Success from interceptor 1'});

      final int2Response = await dio.get('/interceptor-2-route');
      expect(int2Response.data, {'message': 'Success from interceptor 2'});

      final googleResponse = await dio.get('https://google.com');
      expect(googleResponse.statusCode, 200);
    });
    // Removed printLogs tests - no longer supported
  });
}
