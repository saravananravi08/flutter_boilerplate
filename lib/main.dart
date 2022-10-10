import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/initial_bindings.dart';
import 'package:flutter_boilerplate/utils/global_service.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:get/get.dart';
import 'utils/reusable_widgets.dart';

Future<void> main() async {
  Get.put(GlobalService(), permanent: true);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return annotedRegion(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppTheme.appName,
        theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch:
                MaterialColor(AppTheme.primaryColorCode, appPrimaryColor)),
        initialBinding: InitialBindings(),
        initialRoute: GlobalService.to.initialRoute(),
      ),
    );
  }
}
