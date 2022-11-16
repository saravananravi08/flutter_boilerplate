import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      value: SystemUiOverlayStyle(
        statusBarColor: AppTheme.primaryColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      child: givechild,
    );

Widget verticalSpacing(double giveHeigh) => SizedBox(
      height: giveHeigh.sp,
    );

Widget horizontalSpacing(double giveWidth) => SizedBox(
      width: giveWidth.sp,
    );

Widget iconWidget(IconData giveIcon, Color? giveColor, double? giveSize) =>
    Icon(
      giveIcon,
      color: giveColor,
      size: giveSize,
    );

Widget backArrow(
        {double giveIconSize = 25, Color giveIconColor = Colors.black}) =>
    IconButton(
      onPressed: (() => Get.back()),
      icon: iconWidget(Icons.arrow_back_ios, giveIconColor, giveIconSize.sp),
    );

// text widget using google fonts
Widget text({
  required String giveText,
  double fontsize = 15,
  FontWeight fontweight = FontWeight.normal,
  Color textColor = Colors.black,
  double? textHeight,
  String fontfamily = 'Baloo 2',
}) =>
    Text(giveText,
        textAlign: TextAlign.start,
        style: textStyle(
            fontfamily: fontfamily,
            fontsize: fontsize,
            fontweight: fontweight,
            textColor: textColor,
            textHeight: textHeight));

TextStyle textStyle({
  FontWeight? fontweight,
  Color? textColor,
  double? textHeight,
  String fontfamily = 'Baloo 2',
  double? fontsize,
}) {
  return GoogleFonts.getFont(fontfamily,
      textStyle: TextStyle(
        color: textColor,
        fontSize: fontsize!.sp,
        fontWeight: fontweight,
        height: textHeight,
      ));
}

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
      alignment: Alignment.centerLeft,
      child: giveChild,
    );

// formfield widgets
Widget textField(
        {required TextEditingController fieldController,
        required String giveHint,
        required void Function(String)? onFieldEntry,
        bool autofocus = false,
        double lableTextSize = 15,
        Color labelColor = Colors.transparent,
        Color borderColor = Colors.transparent,
        double? giveHeight = 60,
        double? giveWidth,
        bool alignLabelasHint = false,
        Widget? suffixWidget,
        Widget? prefixWidget,
        FocusNode? fieldFocusNode,
        void Function()? onFieldTap,
        int? fieldMaxLines = 1,
        bool isFieldReadOnly = false,
        Color backgroundColor = Colors.white}) =>
    Container(
      height: giveHeight,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(12)),
      width: giveWidth,
      child: TextFormField(
        readOnly: isFieldReadOnly,
        textInputAction: TextInputAction.newline,
        maxLines: fieldMaxLines,
        onTap: onFieldTap,
        focusNode: fieldFocusNode,
        autofocus: false,
        onChanged: onFieldEntry,
        controller: fieldController,
        decoration: InputDecoration(
          prefixIcon: prefixWidget,
          suffixIcon: suffixWidget,
          floatingLabelBehavior: alignLabelasHint
              ? FloatingLabelBehavior.never
              : FloatingLabelBehavior.auto,
          alignLabelWithHint: alignLabelasHint,
          hintStyle:
              textStyle(textColor: labelColor, fontsize: lableTextSize.sp),
          hintText: giveHint,
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
        double buttonHeight = 30,
        double borderWidth = 0,
        double borderRadius = 4,
        Color borderColor = Colors.white,
        Color buttonTextColor = Colors.white,
        double textSize = 17,
        FontWeight textWieght = FontWeight.normal}) =>
    SizedBox(
      height: buttonHeight.sp,
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPress,
        child: text(
            giveText: buttonText,
            fontsize: textSize,
            fontweight: textWieght,
            textColor: buttonTextColor),
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
Widget verticalDividerWidget(giveColor, double giveThickness,
        {double giveHeight = 30}) =>
    SizedBox(
      height: giveHeight,
      child: VerticalDivider(
        thickness: giveThickness,
        color: giveColor,
      ),
    );

Widget horizontalDividerWidget(Color giveColor, double giveThickness) =>
    SizedBox(
      width: Get.width,
      child: Divider(
        thickness: giveThickness,
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
    bool shadow = false,
    bool top = true,
    bool bottom = true,
    required Widget? containerChild}) {
  return Container(
    height: giveHeight,
    width: giveWidth,
    decoration: BoxDecoration(
        color: giveColor,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 3),
              color: shadow
                  ? AppTheme.commonTextColor.withOpacity(0.1)
                  : Colors.transparent,
              spreadRadius: 2,
              blurRadius: 3)
        ],
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
