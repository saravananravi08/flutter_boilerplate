import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

// widgets to change statusbarcolor
Widget annotedRegion(Widget givechild) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: givechild,
    );

Widget annotedRegionLightIcon(Widget givechild) =>
    AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      child: givechild,
    );

Widget verticalSpacing(double giveHeigh) => SizedBox(
      height: giveHeigh,
    );

Widget horizontalSpacing(double giveWidth) => SizedBox(
      height: giveWidth,
    );

Widget iconWidget(giveIcon, Color? giveColor, double? giveSize) => Icon(
      giveIcon,
      color: giveColor,
      size: giveSize,
    );

Widget backArrow() => IconButton(
      onPressed: (() => Get.back()),
      icon: iconWidget(Icons.arrow_back, null, 25),
    );

// text widget using google fonts
Widget text({
  required String giveText,
  double fontsize = 15,
  FontWeight fontweight = FontWeight.normal,
  Color textColor = Colors.black,
  double? textHeight,
  String fontfamily = 'arial',
}) =>
    Text(
      giveText,
      style: GoogleFonts.getFont(
        fontfamily,
        textStyle: TextStyle(
          fontSize: fontsize,
          fontWeight: fontweight,
          height: textHeight,
        ),
      ),
    );

// Alignment widgets
Widget centerAlign(giveChild) => Align(
      alignment: Alignment.center,
      child: giveChild,
    );

Widget alignRight(giveChild) => Align(
      alignment: Alignment.centerRight,
      child: giveChild,
    );

Widget alignleft(giveChild) => Align(
      alignment: Alignment.centerRight,
      child: giveChild,
    );

// formfield widgets
Widget textField({
  required TextEditingController fieldController,
  required String giveHint,
  required void Function(String)? onFieldEntry,
  Color labelColor = Colors.white,
  Color borderColor = Colors.white,
  double? giveHeight,
  double? giveWidth,
}) =>
    SizedBox(
      height: 51,
      width: giveWidth,
      child: TextFormField(
        onChanged: onFieldEntry,
        controller: fieldController,
        decoration: InputDecoration(
          labelText: giveHint,
          labelStyle: TextStyle(
              color: labelColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontFamily: null),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
        style: TextStyle(
          color: labelColor,
        ),
      ),
    );

//button widgets
Widget button(
        {required Color buttonColor,
        required onPress,
        required String buttonText,
        double? buttonWidth,
        double? buttonHeight,
        double borderWidth = 0,
        Color borderColor = Colors.white,
        Color buttonTextColor = Colors.white,
        double textSize = 17,
        FontWeight textWieght = FontWeight.w600}) =>
    SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: onPress,
        child: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontFamily: null,
            fontWeight: textWieght,
            fontSize: textSize,
          ),
        ),
      ),
    );

Widget outlineButton({
  required Widget giveChild,
  required void Function()? buttonOnPress,
  double giveHeight = 35,
  double giveWidth = 200,
  double cornerCurve = 7,
  Color backgroundColor = Colors.transparent,
  Color borderColor = Colors.white,
  double borderRadius = 1,
}) =>
    SizedBox(
      height: giveHeight,
      width: giveWidth,
      child: OutlinedButton(
        onPressed: buttonOnPress,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(width: borderRadius, color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerCurve),
          ),
        ),
        child: giveChild,
      ),
    );

//divider widgets
Widget verticalDividerWidget(giveColor) => SizedBox(
      height: 20,
      child: VerticalDivider(
        thickness: 2,
        color: giveColor,
      ),
    );

Widget horizontalDividerWidget(Color giveColor) => SizedBox(
      width: Get.width,
      child: Divider(
        thickness: 4,
        color: giveColor,
      ),
    );

//rounded edged container widgets
/// function which returns desired radius to the containers borderadius
/// when the provided [side] is true
/// else will return '0' as a double value
double cornerRadius(bool side, double radius) {
  if (side == true) {
    return radius;
  } else {
    return 0;
  }
}

/// widget method of a rounded edged container
/// this method can be used to created rounded edged container on all the sides
/// or any one of the side
/// it can be done by changind [top] and [bottom] as true/false
/// the default boolean value is true for both the sides
/// and the default border color is transparent and it can be changed by providing
/// desired value to [giveBorderColor]
Widget customContainer(
    {Color giveColor = Colors.transparent,
    Color giveBorderColor = Colors.transparent,
    double giveBorderWidth = 0,
    required double? giveHeight,
    required double? giveWidth,
    double topLeft = 12,
    double topRight = 12,
    double bottomRight = 12,
    double bottomLeft = 12,
    bool top = true,
    bool bottom = true,
    required Widget containerChild}) {
  return Container(
    height: giveHeight,
    width: giveWidth,
    decoration: BoxDecoration(
        color: giveColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              cornerRadius(top, topLeft),
            ),
            topRight: Radius.circular(
              cornerRadius(top, topRight),
            ),
            bottomLeft: Radius.circular(
              cornerRadius(bottom, bottomLeft),
            ),
            bottomRight: Radius.circular(
              cornerRadius(bottom, bottomRight),
            )),
        border: Border.all(width: giveBorderWidth, color: giveBorderColor)),
    child: containerChild,
  );
}

/// Image.network child as a widget [giveUrl] as a String
Widget networkImage(String giveUrl) {
  return Image.network(
    giveUrl,
    fit: BoxFit.cover,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return const Center(child: CircularProgressIndicator.adaptive());
      // You can use LinearProgressIndicator or CircularProgressIndicator instead
    },
    errorBuilder: (context, error, stackTrace) => const Text('no image'),
  );
}
