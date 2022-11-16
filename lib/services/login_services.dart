import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:flutter_boilerplate/services/global_service.dart';
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


//login with phonenumber and otp nhost sdk

/* class LoginController extends GetxController {
  final mobileNumber = TextEditingController();
  final otp = TextEditingController();
  LocalStorage localStorage = LocalStorage();
  RxBool isLogginStarted = false.obs;
  RxBool isOtpVerificationStarted = false.obs;

  late Timer timer;
  RxInt start = 30.obs;
  @override
  void onInit() {
    //GlobalService.to.connectionHandler();
    super.onInit();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      // print('object1');
      if (start.value > 0) {
        print('object');
        start(start.value - 1);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> signIn() async {
    isLogginStarted(true);
    String mobile = '+91${mobileNumber.text}';
    try {
      await GlobalService.to.client.auth.signInWithSmsPasswordless(mobile);
      isLogginStarted(false);
      Get.toNamed('verifyotp', arguments: {'route': 'home'});
      startTimer();
    } catch (e) {
      debugPrint(e.toString());
      isLogginStarted(false);
      Get.snackbar('', 'Check the mobile number or please try again later',
          colorText: Colors.black, backgroundColor: Colors.white);
    }
    //client.close();
  }

  Future<void> verifyOtp() async {
    isOtpVerificationStarted(true);
    String mobile = '+91${mobileNumber.text}';
    try {
      await GlobalService.to.client.auth
          .completeSmsPasswordlessSignIn(mobile, otp.text);
      if (GlobalService.to.client.auth.accessToken != null) {

        debugPrint(GlobalService.to.client.auth.currentUser!.toString());
        debugPrint(GlobalService.to.client.auth.currentUser!.id.toString());
        debugPrint(GlobalService.to.client.auth.accessToken);

        GlobalService.to.saveUserData(
          GlobalService.to.client.auth.currentUser!.id.toString(),
          GlobalService.to.client.auth.accessToken,
          '',
        );

        findUser(GlobalService.to.client.auth.currentUser!.id.toString());
        printInfo(info: 'accesstoken ${GlobalService.to.getAccessToken()}');
      }
    } catch (e) {
      isOtpVerificationStarted(false);
      debugPrint(e.toString());
      Get.snackbar('', 'Check the otp or please try again later',
          colorText: Colors.black,
          backgroundColor: Colors.white);
    }
  }

  findUser(userid) async {
    dynamic data;
    await EndpointService.to.graphqlService(Queries.findUserData,
        {'user_id': userid}).then((value) => {data = value.data});
    debugPrint('findUserData${data.toString()}');
    print(GlobalService.to.getAccessToken());
    print(GlobalService.to.getUserId());
    if (data != null) {
      List userid = data['customers'];
      if (userid.isNotEmpty) {
        if (userid[0]['user_id'] == GlobalService.to.getUserId()) {
          await GlobalService.to.userCreatedAccount();
          await GlobalService.to.userOnboarded();
          Get.offAllNamed('language');
          isOtpVerificationStarted(false);
        }
      } else {
        await GlobalService.to.userOnboarded();
        Get.offAllNamed('signup');
        isOtpVerificationStarted(false);
      }
      debugPrint(userid.toString());
    }
  }
} */
