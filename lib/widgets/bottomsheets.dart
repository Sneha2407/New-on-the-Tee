import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_on_the_tee/utils/colors.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:new_on_the_tee/widgets/input_field.dart';

import '../screens/home_page.dart';

Future showBottom(BuildContext context, int index) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Kcolors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      // <-- for border radius
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: getView(
            index), // <-------------------------- calling specific  Bottom sheet toggle
      );
    },
  );
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Widget getView(int index) {
  switch (index) {
    case 1:
      return const EmailSelection();
    case 2:
      return const HomeTown();
    case 3:
      return const Favorites();
    case 4:
      return const Message();
    case 5:
      return const ChangePassword();
    default:
      return const EmailSelection();
  }
}

class EmailSelection extends StatefulWidget {
  const EmailSelection({super.key});

  @override
  State<EmailSelection> createState() => _EmailSelectionState();
}

class _EmailSelectionState extends State<EmailSelection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Email",
            style: mcLaren(Kcolors.black, 14),
          ),
          SizedBox(
            height: 20.h,
          ),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Search Email",
              hintStyle: mcLaren(Kcolors.grey400, 12),
              prefixIcon: IconButton(
                icon: Image.asset(
                  "assets/icons/search.png",
                  height: 25,
                  width: 25,
                ),
                onPressed: () {},
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: const BorderSide(color: Kcolors.grey400, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: const BorderSide(color: Kcolors.grey300, width: 1),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SingleSelectActionChip(items: const [
            "felicia.r@example.com",
            "riya11.p@example.com",
            "curtis.weaver@example.com",
          ], onTap: (val) {}, selectedItem: ""),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 40.h,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // openBottomSheet(context, SignUp());
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => LoginSignup(),
                  //   ),
                  // );
                },
                child: Text(
                  "Show Results",
                  style: GoogleFonts.mcLaren(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Kcolors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class HomeTown extends StatefulWidget {
  const HomeTown({super.key});

  @override
  State<HomeTown> createState() => _HomeTownState();
}

class _HomeTownState extends State<HomeTown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Home Town",
              style: mcLaren(Kcolors.black, 14),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Search Home Town",
              hintStyle: mcLaren(Kcolors.grey400, 12),
              prefixIcon: IconButton(
                icon: Image.asset(
                  "assets/icons/search.png",
                  height: 25,
                  width: 25,
                ),
                onPressed: () {},
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: const BorderSide(color: Kcolors.grey400, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: const BorderSide(color: Kcolors.grey300, width: 1),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SingleSelectActionChip(items: const [
            "New York Office",
            "Los Angeles",
            "Paris",
            "Kolkata",
            "Sydney"
          ], onTap: (val) {}, selectedItem: "abc"),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 40.h,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Show Results",
                  style: GoogleFonts.mcLaren(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Kcolors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  bool selectedOption = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Favorites",
            style: mcLaren(Kcolors.black, 14),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: RadioListTile(
                  title: Text('Yes'),
                  value: true,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value as bool;
                    });
                  },
                  // controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text('No'),
                  value: false,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value as bool;
                    });
                  },
                  // controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 40.h,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Show Results",
                  style: GoogleFonts.mcLaren(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Kcolors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Message",
            style: mcLaren(Kcolors.black, 14),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Thank you, your account has been made. Check your email for the auto generated password and login to hear your intro at https://nowenthetee.com/login",
            style: mcLaren(Kcolors.black, 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 40.h,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: Text(
                  "Dashboard",
                  style: GoogleFonts.mcLaren(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Kcolors.white,
                  ),
                )),
          ),
        ],
      ),
    );
    ;
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool obscureText1 = false;
  bool obscureText2 = false;
  bool obscureText3 = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Change Password",
              style: mcLaren(Kcolors.black, 14),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Current Password",
            style: GoogleFonts.mcLaren(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: Kcolors.grey400,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          TextFormField(
            obscureText: obscureText1,
            decoration: InputDecoration(
              hintText: "password",
              hintStyle: mcLaren(Kcolors.grey300, 14),
              suffixIcon: IconButton(
                icon: obscureText1
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
                    obscureText1 = !obscureText1;
                  });
                },
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Kcolors.grey400, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Kcolors.grey300, width: 1),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "New Password",
            style: GoogleFonts.mcLaren(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: Kcolors.grey400,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          TextFormField(
            obscureText: obscureText2,
            decoration: InputDecoration(
              hintText: "password",
              hintStyle: mcLaren(Kcolors.grey300, 14),
              suffixIcon: IconButton(
                icon: obscureText2
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
                    obscureText2 = !obscureText2;
                  });
                },
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Kcolors.grey400, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Kcolors.grey300, width: 1),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Change Password",
            style: GoogleFonts.mcLaren(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: Kcolors.grey400,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          TextFormField(
            obscureText: obscureText3,
            decoration: InputDecoration(
              hintText: "password",
              hintStyle: mcLaren(Kcolors.grey300, 14),
              suffixIcon: IconButton(
                icon: obscureText3
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
                    obscureText3 = !obscureText3;
                  });
                },
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Kcolors.grey400, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Kcolors.grey300, width: 1),
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
                  Navigator.pop(context);
                },
                child: Text(
                  "Change Password",
                  style: GoogleFonts.mcLaren(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Kcolors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
