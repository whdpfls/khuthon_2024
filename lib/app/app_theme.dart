import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  BuildContext context;

  AppTheme(this.context) {
    T = AppText(this);
    C = AppColor.basic(theme);
  }

  ThemeData get theme => ThemeData(
      primaryColor: const Color(0xffE5954B),
      primaryColorLight: const Color(0xffBFB2AA),
      primaryColorDark: const Color(0xff8D7566),
      brightness: Brightness.light,
      textTheme: textTheme,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color(0xffE5954B),
      ));

  TextStyle _defaultText({TextStyle? textStyle}) =>
      GoogleFonts.notoSans(textStyle: textStyle)
          .copyWith(fontFamily: 'NanumSquareRound');

  TextTheme get textTheme => TextTheme(
    // 57, regular
    displayLarge:
    _defaultText(textStyle: Theme.of(context).textTheme.displayLarge),
    // 45, regular
    displayMedium:
    _defaultText(textStyle: Theme.of(context).textTheme.displayMedium),
    // 36, regular
    displaySmall:
    _defaultText(textStyle: Theme.of(context).textTheme.displaySmall),
    // 32, regular
    headlineLarge:
    _defaultText(textStyle: Theme.of(context).textTheme.headlineLarge),
    // 28, regular
    headlineMedium:
    _defaultText(textStyle: Theme.of(context).textTheme.headlineMedium)
        .copyWith(
      fontSize: 30.sp,
      fontWeight: FontWeight.w400,
    ),
    // 24, regular
    headlineSmall:
    _defaultText(textStyle: Theme.of(context).textTheme.headlineSmall),
    // 22, medium
    titleLarge:
    _defaultText(textStyle: Theme.of(context).textTheme.titleLarge),
    // 16, medium
    titleMedium:
    _defaultText(textStyle: Theme.of(context).textTheme.titleMedium),
    // 14, medium
    titleSmall:
    _defaultText(textStyle: Theme.of(context).textTheme.titleSmall)
        .copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 14.sp,
    ),
    // 16, regular
    bodyLarge:
    _defaultText(textStyle: Theme.of(context).textTheme.bodyLarge),
    // 14, regular
    bodyMedium:
    _defaultText(textStyle: Theme.of(context).textTheme.bodyMedium)
        .copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp),
    // 12, regular
    bodySmall:
    _defaultText(textStyle: Theme.of(context).textTheme.bodySmall),
    // 14, medium
    labelLarge:
    _defaultText(textStyle: Theme.of(context).textTheme.labelLarge)
        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w700),
    // 12, medium
    labelMedium:
    _defaultText(textStyle: Theme.of(context).textTheme.labelMedium)
        .copyWith(
      fontSize: 12.sp,
    ),
    // 11, medium
    labelSmall:
    _defaultText(textStyle: Theme.of(context).textTheme.labelSmall)
        .copyWith(
      fontSize: 12.sp,
    ),
  );
}

late AppText T;

class AppText {
  final AppTheme _theme;

  AppText(this._theme);

  TextStyleSet get label => TextStyleSet(
    _theme.textTheme.labelSmall!,
    _theme.textTheme.labelMedium!,
    _theme.textTheme.labelLarge!,
  );

  TextStyleSet get body => TextStyleSet(
    _theme.textTheme.bodySmall!,
    _theme.textTheme.bodyMedium!,
    _theme.textTheme.bodyLarge!,
  );

  TextStyleSet get title => TextStyleSet(
    _theme.textTheme.titleSmall!,
    _theme.textTheme.titleMedium!,
    _theme.textTheme.titleLarge!,
  );

  TextStyleSet get headline => TextStyleSet(
    _theme.textTheme.headlineSmall!,
    _theme.textTheme.headlineMedium!,
    _theme.textTheme.headlineLarge!,
  );

  TextStyleSet get display => TextStyleSet(
    _theme.textTheme.displaySmall!,
    _theme.textTheme.displayMedium!,
    _theme.textTheme.displayLarge!,
  );
}

class TextStyleSet {
  final TextStyle s;
  final TextStyle m;
  final TextStyle l;

  TextStyleSet(this.s, this.m, this.l);
}

late AppColor C;

class AppColor {
  final Color background;
  final Color primary;
  final Color disabled;
  final Color error;
  final Color divider;
  final Color text;
  final Color textDark;
  final Color green;
  final Color bottomSheetText;
  final Color modalNoBtn;
  final Color titleTextColor;
  final Color explanationTextColor;
  final Color borderColor;
  final Color underlineColor;
  final Color backgroundColor;

  AppColor({
    required this.background,
    required this.primary,
    required this.disabled,
    required this.error,
    required this.divider,
    required this.text,
    required this.textDark,
    required this.green,
    required this.bottomSheetText,
    required this.modalNoBtn,
    required this.titleTextColor,
    required this.explanationTextColor,
    required this.borderColor,
    required this.underlineColor,
    required this.backgroundColor,
  });

  factory AppColor.basic(ThemeData? theme) {
    return AppColor(
        background: const Color(0xffebeedd),
        primary: const Color(0xff5c6e56),
        disabled: const Color(0xffEBDEC8),
        error: Colors.red,
        divider: const Color(0xffE1D9CC),
        text: const Color(0xff726654),
        textDark: const Color(0xff4e4f4b),
        green: const Color(0xFF9cb395),
        bottomSheetText: const Color(0xFFe5e9d0),
        modalNoBtn: const Color(0xFFb4a69f),
        titleTextColor: const Color(0xFF284738),
        explanationTextColor: const Color(0xFFBBA98B),
        borderColor: const Color(0xFFD8CBC0),
        backgroundColor: const Color(0xFFebefd6),
        underlineColor: const Color(0xFFc9d8b7),
    );
  }

  static const Color kakao = Color(0xffF2CD49);
  static const Color kakaoText = Color(0xff371D1E);
  static const Color naver = Color(0xff03C75A);
}
