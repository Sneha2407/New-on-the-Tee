import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_on_the_tee/screens/login_page.dart';
import 'package:new_on_the_tee/screens/providers/auth_provider.dart';
import 'package:new_on_the_tee/screens/providers/dashboard_provider.dart';
import 'package:new_on_the_tee/utils/colors.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:new_on_the_tee/widgets/input_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    case 6:
      return const DeleteAnnoucement();
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
  final TextEditingController _emailController = TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashboardProvider>(context);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Email",
            style: mcLaren(Kcolors.black, 14),
          ),
          SizedBox(
            height: 20.h,
          ),
          TextFormField(
            controller: _emailController,
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
          SingleSelectActionChip(
              items: [
                dashProvider.dashboard!.data.first.email!,
              ],
              onTap: (val) {
                _emailController.text = val!;
                setState(() {});
              },
              selectedItem: ""),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 40.h,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  final SharedPreferences prefs = await _prefs;
                  Navigator.pop(context);
                  dashProvider.fetchFilterData(
                      prefs.getString('accessToken') ?? '',
                      _emailController.text,
                      "",
                      "");
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
          SizedBox(
            height: 20.h,
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
  final TextEditingController _homeTownController = TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashboardProvider>(context);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
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
            controller: _homeTownController,
            // onChanged: (value) {
            //   dashProvider.fetchData(authProvider.accessToken!, "true");
            // },
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
          SingleSelectActionChip(
              items: [
                ...List.generate(
                  dashProvider.dashboard!.data.length,
                  (index) => dashProvider.dashboard!.data[index].city!,
                ),
              ],
              onTap: (val) {
                _homeTownController.text = val!;
                setState(() {});
              },
              selectedItem: "abc"),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 40.h,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  final SharedPreferences prefs = await _prefs;
                  Navigator.pop(context);
                  dashProvider.fetchFilterData(
                      prefs.getString('accessToken') ?? '',
                      "",
                      "",
                      _homeTownController.text);
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
          SizedBox(
            height: 20.h,
          )
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
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int selectedOption = -1;
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
                  activeColor: Kcolors.brandGreen,
                  title: Text(
                    'Yes',
                    style: mcLaren(Kcolors.black, 14),
                  ),
                  value: 0,
                  groupValue: selectedOption,
                  onChanged: (value) async {
                    setState(() {
                      selectedOption = value!;
                    });
                    final SharedPreferences prefs = await _prefs;
                    final dashProvider =
                        Provider.of<DashboardProvider>(context, listen: false);

                    await dashProvider.fetchData(
                        prefs.getString('accessToken') ?? '', "true");
                  },
                  // controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
              Expanded(
                child: RadioListTile(
                  activeColor: Kcolors.brandGreen,
                  title: Text(
                    'No',
                    style: mcLaren(Kcolors.black, 14),
                  ),
                  value: 1,
                  groupValue: selectedOption,
                  onChanged: (value) async {
                    setState(() {
                      selectedOption = value!;
                    });
                    final SharedPreferences prefs = await _prefs;
                    final dashProvider =
                        Provider.of<DashboardProvider>(context, listen: false);

                    await dashProvider.fetchData(
                        prefs.getString('accessToken') ?? '', "false");
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
                      builder: (context) => const LoginPage(),
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
  final formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<RegisterProvider>(context);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
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
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _oldPasswordController,
                  validator: (value) {
                    if (value != null && value.length < 6) {
                      return "Password must be at least 6 characters long";
                    } else {
                      return null;
                    }
                  },
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
                      borderSide:
                          const BorderSide(color: Kcolors.grey400, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: Kcolors.grey300, width: 1),
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
                  controller: _passwordController,
                  validator: (value) {
                    if (value != null && value.length < 6) {
                      return "Password must be at least 6 characters long";
                    } else {
                      return null;
                    }
                  },
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
                      borderSide:
                          const BorderSide(color: Kcolors.grey400, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: Kcolors.grey300, width: 1),
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
                  validator: (value) {
                    if (value != null && value.length < 6) {
                      return "Password must be at least 6 characters long";
                    } else {
                      return null;
                    }
                  },
                  controller: _confirmPasswordController,
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
                      borderSide:
                          const BorderSide(color: Kcolors.grey400, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: Kcolors.grey300, width: 1),
                    ),
                  ),
                ),
              ],
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
                  final SharedPreferences prefs = await _prefs;
                  if (formKey.currentState!.validate()) {
                    authProvider
                        .changePassword(
                            prefs.getString('accessToken') ?? '',
                            _oldPasswordController.text,
                            _passwordController.text,
                            _confirmPasswordController.text)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          content: Text(
                            "Password updated successfully!",
                            style: mcLaren(Kcolors.white, 15),
                          ),
                        ),
                      );
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red.withOpacity(0.5),
                          content: Text(
                            error.toString(),
                            style: mcLaren(Kcolors.white, 15),
                          ),
                        ),
                      );
                    });
                    Navigator.pop(context);
                  }
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
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}

class DeleteAnnoucement extends StatelessWidget {
  const DeleteAnnoucement({super.key});

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
                // Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Kcolors.redLogout),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    // side:  BorderSide(color: Kcolors.grey300),
                  ),
                ),
              ),
              child: Text(
                "Delete Selected One",
                style: mcLaren(Kcolors.white, 15),
              )),
        ),
      ),
    );
  }
}
