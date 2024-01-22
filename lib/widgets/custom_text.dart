import 'package:flutter/material.dart';

class CustomText extends Text {

  CustomText(String data, {TextAlign? textAlign, Color? color,double? fontSize, FontStyle? fontStyle, TextOverflow? textOverflow }):
        super(
          data??"",
          textAlign: textAlign ?? TextAlign.center,
          overflow: textOverflow ?? TextOverflow.visible,
          style: TextStyle(
              color: color ?? Colors.indigo,
              fontSize: fontSize ?? 15.0,
              fontStyle: fontStyle ?? FontStyle.normal
          )
      );
}
