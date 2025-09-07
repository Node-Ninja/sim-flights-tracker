import 'package:dio/dio.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

class AppCheckInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.headers.containsKey('Authorization')) {
      try {
        var token = await FirebaseAppCheck.instance.getToken();

        if (token != null) {
          options.headers.addAll({
            'Authorization': 'Bearer $token'
          });
        }
      } catch (e) {
        // NOTE: Ignore this and fail silently;
      }
    }

    return super.onRequest(options, handler);
  }
}