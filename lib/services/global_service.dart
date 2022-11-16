import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/services/localstorage.dart';
import 'package:get/get.dart';
import 'package:nhost_sdk/nhost_sdk.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/constants.dart';
import 'notification_service.dart';

class GlobalService extends GetxService {
  LocalStorage localStorage = LocalStorage();
  static GlobalService get to => Get.find<GlobalService>();
  late NhostClient client;
  late StorageClient storageClient;
  String? userId;
  String? userAccessToken;
  String? userRefreshToken;
  late StreamSubscription connectivity;
  late Rx<ConnectivityResult> connectivityResult;
  RxBool isUserHaveAccount = false.obs;
  RxBool isUserOnboarded = false.obs;
  RxBool getStarted = false.obs;

  saveUserData(giveUserId, giveAccessToken, giveRefreshToken) async {
    userId = giveUserId;
    userAccessToken = giveAccessToken;
    userRefreshToken = giveRefreshToken;
    await localStorage.setString('userId', giveUserId);
    await localStorage.setString('accessToken', giveAccessToken);
    await localStorage.setString('refreshToken', giveRefreshToken);
  }

  isUserHaveAccountBoolean() async {
    await localStorage.getString('isUserHaveAccount').then((value) {
      if (value != null && value == 'true') {
        isUserHaveAccount(true);
        debugPrint('user have account');
      }
    });
    return isUserHaveAccount.value;
  }

  userCreatedAccount() async {
    await localStorage.setString('isUserHaveAccount', 'true');
    isUserHaveAccount(true);
    debugPrint('user created account');
    Get.toNamed('language');
  }

  userOnboarded() async {
    await localStorage.setString('userOnboarded', 'true');
    isUserOnboarded(true);
    debugPrint('user onboarded');
  }

  isUserOnboardedBoolean() async {
    await localStorage.getString('userOnboarded').then((value) {
      if (value != null && value == 'true') {
        isUserOnboarded(true);
        debugPrint('user onboarded');
      }
    });
    return isUserOnboarded.value;
  }

  getStartedBoolean() async {
    await localStorage.getString('getStarted').then((value) {
      if (value != null && value == 'true') {
        getStarted(true);
      }
    });
  }

  userStarted() async {
    await localStorage.setString('getStarted', 'true');
    getStarted(true);
    Get.offNamed('home');
  }

  String getUserId() => userId!;
  String getAccessToken() => userAccessToken!;
  String getRefreshToken() => userRefreshToken!;

  getUserDataOnInit() async {
    getStartedBoolean();
    isUserHaveAccountBoolean();
    isUserOnboardedBoolean();
    await localStorage.getString('userId').then((value) {
      userId = value;
    });
    await localStorage.getString('accessToken').then((value) {
      userAccessToken = value;
    });
    await localStorage.getString('refreshToken').then((value) {
      userRefreshToken = value;
    });
  }

  RxString notificationTitle = 'No Title'.obs;
  RxString notificationBody = 'No Body'.obs;
  RxString notificationData = 'No Data'.obs;

  _changeData(String msg) {
    debugPrint(msg);
    return notificationData(msg);
  }

  _changeBody(String msg) {
    debugPrint(msg);
    return notificationBody(msg);
  }

  _changeTitle(String msg) => notificationTitle(msg);
  firebaseInit() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
  }

  @override
  void onInit() async {
    getUserDataOnInit();
    // firebaseInit();
    //nhostClientInit();
    // connectionStream();

    super.onInit();
  }

  nhostClientInit() {
    client = NhostClient(
      backendUrl: AppConstants.apiEndpoint,
      authStore:
          LocalStorage(), /* tokenRefreshInterval: const Duration(minutes: 14) */
    );
  }

  String initialRoute() {
    /* if (getStarted.value == true) {
      if (isUserHaveAccount.value == true && isUserOnboarded.value == true) {
        return 'home';
      } else if (isUserHaveAccount.value == false &&
          isUserOnboarded.value == true) {
        return 'signup';
      } else if (isUserHaveAccount.value == false &&
          isUserOnboarded.value == false) {
        debugPrint('create account first');
        return 'home';
      } else {
        return 'profile';
      }
    } else {
      return 'getstarted';
    } */
    return 'home';
  }

//nhost token refresh fun
  refetchToken() async {
    final refershToken = await LocalStorage().getString('nhostRefreshToken');
    await GlobalService.to.client.auth.signInWithRefreshToken(refershToken!);
  }

  Future<bool> permissionHandler() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      // Permission.videos,
      Permission.microphone,
      Permission.location,
      Permission.storage
    ].request();
    if (statuses[Permission.camera] == PermissionStatus.permanentlyDenied &&
        statuses[Permission.microphone] == PermissionStatus.permanentlyDenied &&
        statuses[Permission.location] == PermissionStatus.permanentlyDenied &&
        statuses[Permission.storage] == PermissionStatus.permanentlyDenied) {
      print('permission permanent denied $statuses');
      return false;
    } else if (statuses[Permission.camera] == PermissionStatus.granted &&
        statuses[Permission.microphone] == PermissionStatus.granted &&
        statuses[Permission.location] == PermissionStatus.granted &&
        statuses[Permission.storage] == PermissionStatus.granted) {
      print('permission granted $statuses');
      return true;
    } else {
      print('permission denied');
      return false;
    }
  }

  /* connectionStream() {
    connectivity = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        connectivityAlert();
      } else {
        if (Get.isRegistered<HomeScreenController>() == true) {
          HomeScreenController.to.playOnConnection();
        }
      }
    });
  } */

  /*  Future connectionHandler() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      connectivityAlert();
    }
  } */
}
