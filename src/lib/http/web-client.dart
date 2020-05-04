import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'logging-interceptor.dart';

final Client webClient = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 10),
);
