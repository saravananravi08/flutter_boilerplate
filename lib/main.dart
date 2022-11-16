import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/initial_bindings.dart';
import 'package:flutter_boilerplate/routes.dart';
import 'package:flutter_boilerplate/services/global_service.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:get/get.dart';
import 'utils/reusable_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(GlobalService(), permanent: true);
  await GlobalService.to.getUserDataOnInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (_, child) {
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
            getPages: AppPages.pages,
          ),
        );
      },
    );
  }
}
