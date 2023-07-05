import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_on_the_tee/widgets/login_buttomsheets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    Future.delayed(const Duration(seconds: 2), () {
      // context.goNamed(AppRoute.getStartedPage.name);
      openBottomSheet(context, GetStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
          ),
          child: Center(
              child: Image.asset(
            "assets/icons/applogo.png",
            height: 150.h,
            width: 150.w,
          )),
        ),
      ),
    );
  }
}
