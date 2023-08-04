import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_on_the_tee/screens/home_page.dart';
import 'package:new_on_the_tee/screens/providers/auth_provider.dart';
import 'package:new_on_the_tee/screens/providers/dashboard_provider.dart';
import 'package:new_on_the_tee/widgets/login_buttomsheets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  getData() async {
    final dash = Provider.of<DashboardProvider>(context, listen: false);
    final auth = Provider.of<RegisterProvider>(context, listen: false);
    final SharedPreferences prefs = await _prefs;
    await dash
        .fetchData(prefs.getString('accessToken') ?? '', "")
        .then((value) => {
              Future.delayed(const Duration(seconds: 1), () {
                // dash.setNeedLogin(false);
                print(auth.accessToken!);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              })
            })
        .onError((error, stackTrace) => {
              Future.delayed(const Duration(seconds: 1), () {
                print(auth.accessToken!);
                // dash.setNeedLogin(true);
                displayBottomSheet(context, GetStarted());
              })
            });
    // Future.delayed(const Duration(seconds: 2), () {
    //   // context.goNamed(AppRoute.getStartedPage.name);
    //   openBottomSheet(context, GetStarted());
    // });
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
