// import 'dart:convert';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_on_the_tee/screens/signup_page.dart';
import 'package:new_on_the_tee/screens/providers/auth_provider.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:provider/provider.dart';

import '../screens/providers/storage_provider.dart';
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: SizedBox(
          height: 40.h,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Kcolors.brandGreen),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    // side:  BorderSide(color: Kcolors.grey300),
                  ),
                ),
              ),
              child: Text(
                "Get Started",
                style: mcLaren(Kcolors.white, 15),
              )),
        ),
      ),
    );
  }
}

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final TextEditingController _introController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<RegisterProvider>(context, listen: false);
    final storageProvider =
        Provider.of<StorageProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 10.h,
        ),
        Align(
            alignment: Alignment.center,
            child: Text('Start Today’s Round', style: regularBrush())),
        Align(
          alignment: Alignment.center,
          child: Text(
            "You are up next are you ready....",
            style: GoogleFonts.mcLaren(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: Kcolors.white,
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "Accomplishments",
          style: GoogleFonts.mcLaren(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: Kcolors.grey300,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          maxLines: 7,
          style: mcLaren(Kcolors.white, 14),
          controller: _introController,
          decoration: InputDecoration(
            hintStyle: mcLaren(Kcolors.grey400, 14),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Kcolors.grey300, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Kcolors.grey400, width: 1),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: 40.h,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () async {
                //register api called
                print("Register api called");
                setState(() {
                  isLoading = true;
                });
                await authProvider
                    .postUser(storageProvider.name!, storageProvider.email!,
                        _introController.text, storageProvider.city!, context)
                    .onError((error, stackTrace) =>
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red.withOpacity(0.5),
                            content: Text(
                              error.toString(),
                              style: mcLaren(Kcolors.white, 12),
                            ),
                          ),
                        ));
                setState(() {
                  isLoading = false;
                });
                // showBottom(context, 4);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Kcolors.brandGreen),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    // side:  BorderSide(color: Kcolors.grey300),
                  ),
                ),
              ),
              child: isLoading
                  ? Padding(
                      padding: EdgeInsets.all(5.h),
                      child: const CircularProgressIndicator(
                        // Show loading indicator
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    )
                  : Text(
                      "Hear Your Intro",
                      style: mcLaren(Kcolors.white, 15),
                    )),
        ),
      ],
    );
  }
}
