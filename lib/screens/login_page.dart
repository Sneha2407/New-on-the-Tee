import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_on_the_tee/screens/providers/auth_provider.dart';
import 'package:email_validator/email_validator.dart';

import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/textstyles.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<RegisterProvider>(context);

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Center(
                    child: Image.asset(
                      "assets/icons/applogo.png",
                      height: 100.h,
                      width: 100.w,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 30.h,
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    decoration: BoxDecoration(
                      // color: Colors.grey.withOpacity(0.5),
                      gradient: LinearGradient(
                          colors: [
                            Colors.grey.withOpacity(0.5),
                            Colors.black.withOpacity(0.5),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 15.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Form(
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
                                  child: Text('Login', style: regularBrush()),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Enter your email and password",
                                    style: GoogleFonts.mcLaren(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0,
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
                                    fontSize: 14.0,
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
                                        height: 25.0,
                                        width: 25.0,
                                      ),
                                      onPressed: () {},
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Kcolors.grey300, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
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
                                  height: 10.h,
                                ),
                                Text(
                                  "Enter Password",
                                  style: GoogleFonts.mcLaren(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
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
                                              height: 25.0,
                                              width: 25.0,
                                            )
                                          : Image.asset(
                                              "assets/icons/eye_invisible.png",
                                              height: 25.0,
                                              width: 25.0,
                                            ),
                                      onPressed: () {
                                        setState(() {
                                          obscureText = !obscureText;
                                        });
                                      },
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Kcolors.grey300, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Kcolors.grey400, width: 1),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value != null && value.length < 3) {
                                      return "Enter a Valid Password";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                SizedBox(
                                  height: 40.h,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // print("login pressed");
                                      // print(_emailController.text);
                                      // print(_passwordController.text);
                                      // if (formKey.currentState!.validate()) {
                                      //   authProvider
                                      //       .loginUser(
                                      //           _emailController.text,
                                      //           _passwordController.text,
                                      //           context)
                                      //       .onError((error, stackTrace) =>
                                      //           ScaffoldMessenger.of(context)
                                      //               .showSnackBar(
                                      //             SnackBar(
                                      //               backgroundColor: Colors
                                      //                   .red
                                      //                   .withOpacity(0.5),
                                      //               behavior: SnackBarBehavior
                                      //                   .floating,
                                      //               // margin: EdgeInsets.only(top: 70.0),
                                      //               content: Text(
                                      //                 error.toString(),
                                      //                 style: mcLaren(
                                      //                     Kcolors.white, 12),
                                      //               ),
                                      //             ),
                                      //           ));
                                      // }

                                      print("login pressed");
                                      print(_emailController.text);
                                      print(_passwordController.text);
                                      if (formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await authProvider
                                            .loginUser(
                                              _emailController.text,
                                              _passwordController.text,
                                              context,
                                            )
                                            .onError(
                                              (error, stackTrace) =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.red
                                                      .withOpacity(0.5),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                    error.toString(),
                                                    style: mcLaren(
                                                        Kcolors.white, 12),
                                                  ),
                                                ),
                                              ),
                                            );
                                        setState(() {
                                          isLoading = false;
                                        });
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
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    child: isLoading
                                        ? Padding(
                                            padding: EdgeInsets.all(5.h),
                                            child:
                                                const CircularProgressIndicator(
                                              // Show loading indicator
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            "Log In",
                                            style: mcLaren(Kcolors.white, 15),
                                          ),
                                  ),
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
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Sign Up",
                                        style: mcLaren(Kcolors.brandGreen, 12)
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )

                          // Visibility(visible: intro, child: Intro()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
