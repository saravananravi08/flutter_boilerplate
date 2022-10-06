import 'package:flutter_boilerplate/services/localstorage.dart';
import 'package:get/get.dart';

class GlobalService extends GetxService {
  LocalStorage localStorage = LocalStorage();
  static GlobalService get to => Get.find<GlobalService>();
  String? userId;
  String? userAccessToken;
  String? userRefreshToken;

  saveUserData(giveUserId, giveAccessToken, giveRefreshToken) {
    userId = giveUserId;
    userAccessToken = giveAccessToken;
    userRefreshToken = giveRefreshToken;
  }

  String getUserId() => userId!;
  String getAccessToken() => userAccessToken!;
  String getRefreshToken() => userRefreshToken!;

  getUserDataOnInit() async {
    userId = await localStorage.readSecureData('userId');
    userAccessToken = await localStorage.readSecureData('accessToken');
    userRefreshToken = await localStorage.readSecureData('refreshToken');
  }

  @override
  void onInit() {
    getUserDataOnInit();
    super.onInit();
  }

  String initialRoute() {
    if (userAccessToken != null) {
      return 'home';
    } else {
      return 'home';
    }
  }
}
