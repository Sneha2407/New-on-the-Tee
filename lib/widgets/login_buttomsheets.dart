import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_on_the_tee/screens/intro_page.dart';
import 'package:new_on_the_tee/screens/login.dart';
import 'package:new_on_the_tee/screens/login_signup.dart';
import 'package:new_on_the_tee/screens/providers/auth_provider.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:new_on_the_tee/widgets/bottomsheets.dart';
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
                    builder: (context) => const LoginSignup(),
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

class SignUp extends StatefulWidget {
  final VoidCallback loginPressed;
  const SignUp({super.key, required this.loginPressed});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StorageProvider>(context, listen: false);
    return Padding(
      // padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
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
            "Enter Your Name",
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
            //change text color
            style: mcLaren(Kcolors.white, 14),
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "Name",
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
            height: 10.h,
          ),
          Text(
            "Enter Your Home Town",
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
            style: mcLaren(Kcolors.white, 14),
            controller: _cityController,
            decoration: InputDecoration(
              hintText: "Kolkata",
              hintStyle: mcLaren(Kcolors.grey400, 14),
              suffixIcon: IconButton(
                icon: Image.asset(
                  "assets/icons/location.png",
                  height: 25.h,
                  width: 25.w,
                ),
                onPressed: () {},
              ),
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
            height: 10.h,
          ),
          Text(
            "Enter Your Email",
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
            style: mcLaren(Kcolors.white, 14),
            controller: _emailController,
            decoration: InputDecoration(
              hintText: "example@gmail.com",
              hintStyle: mcLaren(Kcolors.grey400, 14),
              suffixIcon: IconButton(
                icon: Image.asset(
                  "assets/icons/email.png",
                  height: 25.h,
                  width: 25.w,
                ),
                onPressed: () {},
              ),
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
          //green button
          SizedBox(
            height: 40.h,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  //
                  print("Signup pressed");

                  storeProvider.setName(_nameController.text);
                  storeProvider.setEmail(_emailController.text);
                  storeProvider.setCity(_cityController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IntroPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Kcolors.brandGreen),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      // side:  BorderSide(color: Kcolors.grey300),
                    ),
                  ),
                ),
                child: Text(
                  "Sign Up",
                  style: mcLaren(Kcolors.white, 15),
                )),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: mcLaren(Kcolors.white, 12),
              ),
              TextButton(
                onPressed: () {
                  widget.loginPressed;
                  //add login route>>>>>>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Text(
                  "Log In",
                  style: mcLaren(Kcolors.brandGreen, 12)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscureText = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<RegisterProvider>(context);
    return Padding(
      // padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Align(
              alignment: Alignment.center,
              child: Text('Login', style: regularBrush())),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Enter your email and password",
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
            "Enter Your Email",
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
            style: mcLaren(Kcolors.white, 14),
            controller: _emailController,
            decoration: InputDecoration(
              hintText: "example@gmail.com",
              hintStyle: mcLaren(Kcolors.grey400, 14),
              suffixIcon: IconButton(
                icon: Image.asset(
                  "assets/icons/email.png",
                  height: 25.h,
                  width: 25.w,
                ),
                onPressed: () {},
              ),
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
            height: 10.h,
          ),
          Text(
            "Enter Password",
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
            style: mcLaren(Kcolors.white, 14),
            controller: _passwordController,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: "password",
              hintStyle: mcLaren(Kcolors.grey400, 14),
              suffixIcon: IconButton(
                icon: obscureText
                    ? Image.asset(
                        "assets/icons/eye_visible.png",
                        height: 25.h,
                        width: 25.w,
                      )
                    : Image.asset(
                        "assets/icons/eye_invisible.png",
                        height: 25.h,
                        width: 25.w,
                      ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
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
                onPressed: () {
                  print("login pressed");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const HomePage(),
                  //   ),
                  // );
                  print(_emailController.text);
                  print(_passwordController.text);
                  authProvider
                      .loginUser(_emailController.text,
                          _passwordController.text, context)
                      .onError((error, stackTrace) =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red.withOpacity(0.5),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(top: 70.h),
                              content: Text(
                                error.toString(),
                                style: mcLaren(Kcolors.white, 12),
                              ),
                            ),
                          ));
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Kcolors.brandGreen),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      // side:  BorderSide(color: Kcolors.grey300),
                    ),
                  ),
                ),
                child: Text(
                  "Log In",
                  style: mcLaren(Kcolors.white, 15),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: mcLaren(Kcolors.white, 12),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Sign Up",
                  style: mcLaren(Kcolors.brandGreen, 12)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )
        ],
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
              onPressed: () {
                //register api called
                print("Register api called");

                authProvider
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
              child: Text(
                "Hear Your Intro",
                style: mcLaren(Kcolors.white, 15),
              )),
        ),
      ],
    );
  }
}
