import 'package:flutter/material.dart';

import 'constants.dart';

class AppUtils {
  extraLargeHeadingStyle({color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w800,
      fontSize: 36,
    );
  }

  mediumTitleStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 16,
    );
  }

  mediumBoldStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  largeBoldStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  smallTitleStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 13,
    );
  }

  extraSmallTitleStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 11,
    );
  }

  extraSmallUnderlineTitleStyle({color}) {
    return TextStyle(
      color: color,
      fontSize: 11,
      decoration: TextDecoration.underline,
    );
  }

  gradientButton(
      {width,
      height,
      onTap,
      borderRadius,
      text,
      textColor,
      fontSize,
      fontWeight}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              darkOrangeColor,
              orangeColor,
            ],
          ),
        ),
        child: Center(
          child: Text(
            text.toString(),
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: fontSize == null ? 16.0 : fontSize.toDouble(),
              fontWeight: fontWeight ?? FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  textField(
      {borderColor,
      width,
      height,
      prefixIconImage,
      hintText,
      suffixIconImage,
      suffixImageScale,
      suffixImageColor,
      controller,
        validator,
        onChange,
      prefixIconColor}) {
    return Container(
      width: width,
      padding: const EdgeInsets.fromLTRB(24, 0, 20, 0),
      height: height ?? 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          prefixIconImage != null
              ? SizedBox(
                  width: 21,
                  height: 17,
                  child: Icon(
                    prefixIconImage,
                    color: prefixIconColor,
                  ),
                )
              : Container(
                  width: 20,
                ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: TextFormField(
              onChanged: onChange,
              validator: validator,
              style: const TextStyle(color: darkOrangeColor),
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: mediumTitleStyle(color: darkOrangeColor),
              ),
            ),
          ),
          suffixIconImage != null
              ? SizedBox(
                  width: 21,
                  height: 17,
                  child: Image.asset(
                    prefixIconImage,
                    scale: suffixImageScale,
                    color: suffixImageColor,
                  ),
                )
              : Container(
                  width: 20,
                ),
        ],
      ),
    );
  }
}
