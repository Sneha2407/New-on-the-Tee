import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_on_the_tee/screens/login_page.dart';
import 'package:new_on_the_tee/screens/providers/storage_provider.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import 'intro_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  openLoginSection() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StorageProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          // height: double.infinity,
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
                        Padding(
                          // padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Form(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Text('Start Today’s Round',
                                        style: regularBrush())),
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
                                      borderSide: const BorderSide(
                                          color: Kcolors.grey300, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: Kcolors.grey400, width: 1),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value != null && value.length < 3) {
                                      return "Name must be of minumum 3 characters";
                                    } else {
                                      return null;
                                    }
                                  },
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
                                      borderSide: const BorderSide(
                                          color: Kcolors.grey300, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: Kcolors.grey400, width: 1),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value != null && value.length < 3) {
                                      return "Hometown must be of minumum 3 characters";
                                    } else {
                                      return null;
                                    }
                                  },
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
                                      borderSide: const BorderSide(
                                          color: Kcolors.grey300, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: Kcolors.grey400, width: 1),
                                    ),
                                  ),
                                  validator: (email) {
                                    if (email != null &&
                                        !EmailValidator.validate(email)) {
                                      return "Enter Valid Email";
                                    } else {
                                      return null;
                                    }
                                  },
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
                                        if (formKey.currentState!.validate()) {
                                          storeProvider
                                              .setName(_nameController.text);
                                          storeProvider
                                              .setEmail(_emailController.text);
                                          storeProvider
                                              .setCity(_cityController.text);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const IntroPage(),
                                            ),
                                          );
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Kcolors.brandGreen),
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
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
                                        openLoginSection();
                                        //add login route>>>>>>
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Log In",
                                        style: mcLaren(Kcolors.brandGreen, 12)
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )

                        // Visibility(visible: login, child: Login()),
                        // Visibility(visible: intro, child: Intro()),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
