import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_on_the_tee/utils/colors.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';

Widget buttonGreenLarge(String text, VoidCallback onPressed) {
  return SizedBox(
    height: 50.h,
    width: double.infinity,
    child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Kcolors.brandGreen),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              vertical: 15.h,
              // horizontal: 20.w,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
              // side:  BorderSide(color: Kcolors.grey300),
            ),
          ),
        ),
        child: Text(
          text,
          style: mcLaren(Kcolors.white, 15),
        )),
  );
}
