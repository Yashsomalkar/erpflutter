import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print("HTTP Request:");
    print("URL: ${data.url}");
    print("Method: ${data.method}");
    print("Headers: ${data.headers}");
    print("Body: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("HTTP Response:");
    print("Status Code: ${data.statusCode}");
    print("Headers: ${data.headers}");
    print("Body: ${data.body}");
    return data;
  }
}
