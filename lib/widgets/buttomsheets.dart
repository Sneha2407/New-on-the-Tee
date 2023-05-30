import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_on_the_tee/screens/login_signup.dart';

import '../utils/colors.dart';

Future openBottomSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.grey.withOpacity(0.3),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r))),
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: child,
        );
      });
    },
  );
}

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: SizedBox(
        height: 50.h,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // openBottomSheet(context, SignUp());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginSignup(),
                ),
              );
            },
            child: Text(
              "Get Started",
              style: GoogleFonts.mcLaren(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
                color: Kcolors.white,
              ),
            )),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Start Today’s Round',
            style: TextStyle(
                fontFamily: 'Regular Brush',
                fontSize: 25.sp,
                color: Kcolors.white,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "You are up next are you ready....",
            style: GoogleFonts.mcLaren(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: Kcolors.white,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Enter Your Name",
            style: GoogleFonts.mcLaren(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: Kcolors.grey300,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Name",
              // hintStyle: montShade3(14),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kcolors.grey500, width: 1),
              ),
              focusColor: Kcolors.grey300,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kcolors.redLogout, width: 1),
              ),
            ),
          ),
          Text(
            "Enter Your Name",
            style: GoogleFonts.mcLaren(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: Kcolors.grey300,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Name",
              // hintStyle: montShade3(14),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kcolors.grey500, width: 1),
              ),
              focusColor: Kcolors.grey300,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kcolors.redLogout, width: 1),
              ),
            ),
          ),
          Text(
            "Enter Your Name",
            style: GoogleFonts.mcLaren(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: Kcolors.grey300,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Name",
              // hintStyle: montShade3(14),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kcolors.grey500, width: 1),
              ),
              focusColor: Kcolors.grey300,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kcolors.redLogout, width: 1),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          ElevatedButton(onPressed: () {}, child: Text("Sign Up"))
        ],
      ),
    );
  }
}
