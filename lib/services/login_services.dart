import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:flutter_boilerplate/utils/global_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late dio.Dio serviceClient;
  final globalService = Get.find<GlobalService>();
  @override
  void onInit() {
    serviceClient = dio.Dio(dio.BaseOptions(
        baseUrl: AppConstants.apiEndpoint,
        contentType: 'application/json',
        responseType: dio.ResponseType.json,
        headers: {},
        sendTimeout: 10000));

    super.onInit();
  }

  Future<void> rejectBooking(String argument1, String argument2) async {
    dio.Response r = await serviceClient
        .post('/api',
            data: {"example1": argument1, "example2": argument2},
            options: dio.Options(
              headers: {
                'Content-Type': "application/json",
                'Authorization': "Bearer ${globalService.getAccessToken()}"
              },
            ))
        .catchError((err) {
      debugPrint(err);
    });
    debugPrint(r.data);
    debugPrint(r.statusCode.toString());
    if (r.statusCode == 200) {
      debugPrint('success');
    } else {
      debugPrint(r.statusMessage);
    }
  }
}
