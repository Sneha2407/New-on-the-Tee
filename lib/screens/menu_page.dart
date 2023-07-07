import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_on_the_tee/screens/splash.dart';
import 'package:new_on_the_tee/utils/colors.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:new_on_the_tee/widgets/bottomsheets.dart';

import '../widgets/audio_player.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    "assets/icons/close_circle.png",
                    height: 22.h,
                    width: 22.w,
                  )),
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                print("tapped");
                showBottom(context, 5);
              },
              child: ListTile(
                leading: Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: const BoxDecoration(
                      color: Kcolors.brandGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/icons/change_pass.png"),
                    )),
                title: Text(
                  "Change Password",
                  style: mcLaren(Kcolors.black, 16),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Kcolors.grey400,
                  size: 20,
                ),
              ),
            ),
            ListTile(
              leading: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: const BoxDecoration(
                    color: Kcolors.brandGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/icons/annoucements.png"),
                  )),
              title: Text(
                "Annoucements",
                style: mcLaren(Kcolors.black, 16),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Kcolors.grey400,
                size: 20,
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Logout",
                        style: mcLaren(Kcolors.black, 16),
                      ),
                      content: Text(
                        "Are you sure you want to logout?",
                        style: mcLaren(Kcolors.black, 12),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform logout action
                            // Redirect to SplashPage
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SplashScreen()),
                                (route) => false);
                          },
                          child: Text(
                            "Yes",
                            style: mcLaren(Kcolors.black, 14),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "No",
                            style: mcLaren(Kcolors.black, 14),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: ListTile(
                leading: Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: const BoxDecoration(
                      color: Kcolors.redLogout,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/icons/logout.png"),
                    )),
                title: Text(
                  "Logout",
                  style: mcLaren(Kcolors.black, 16),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Kcolors.grey400,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
