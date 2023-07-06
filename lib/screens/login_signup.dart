import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_on_the_tee/widgets/login_buttomsheets.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  bool intro = false;
  bool signup = true;
  bool login = false;
  // bool intro = false;
  openLoginSection() {
    setState(() {
      signup = false;
      login = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              "assets/icons/applogo.png",
              height: 100.h,
              width: 100.w,
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
                decoration: BoxDecoration(
                  // color: Colors.grey.withOpacity(0.5),
                  gradient: LinearGradient(colors: [
                    Colors.grey.withOpacity(0.5),
                    Colors.black.withOpacity(0.5),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                  child: Column(
                    children: [
                      // ElevatedButton(
                      //     onPressed: openLoginSection,
                      //     child: Text("Open login")),
                      Visibility(
                          visible: signup,
                          child: SignUp(
                            loginPressed: openLoginSection,
                          )),
                      Visibility(visible: login, child: Login()),
                      Visibility(visible: intro, child: Intro()),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
