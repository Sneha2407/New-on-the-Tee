import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_on_the_tee/screens/menu_page.dart';
import 'package:new_on_the_tee/screens/providers/auth_provider.dart';
import 'package:new_on_the_tee/screens/providers/dashboard_provider.dart';
import 'package:new_on_the_tee/utils/colors.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:new_on_the_tee/widgets/audio_player.dart';
import 'package:new_on_the_tee/widgets/bottomsheets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = -1;
  List buttonTitles = ["Email", "Home Town", "Favorites"];
  List deleteItems = [];
  bool play = false;
  @override
  void initState() {
    final dashProvider = Provider.of<DashboardProvider>(context, listen: false);
    final authProvider = Provider.of<RegisterProvider>(context, listen: false);
    dashProvider.fetchData(authProvider.accessToken!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashboardProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomSheet: deleteItems.isNotEmpty
            ? Container(
                height: 80.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: DeleteAnnoucement(),
              )
            : null,
        body: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 200.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.r),
                                bottomRight: Radius.circular(20.r),
                              ),
                              image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/welcome.png"),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        left: 15.w,
                        right: 15.w,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Search Name......",
                            hintStyle: mcLaren(Kcolors.grey400, 12),
                            prefixIcon: IconButton(
                              icon: Image.asset(
                                "assets/icons/search.png",
                                height: 25,
                                width: 25,
                              ),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 30.h,
                        left: 15.w,
                        right: 15.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Welcome to \nNow on The Tee",
                              style: mcLaren(Kcolors.white, 24)
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Container(
                                height: 30.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: Kcolors.lightGreen.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            MenuPage(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(1.0, 0.0);
                                          const end = Offset.zero;
                                          final tween =
                                              Tween(begin: begin, end: end);
                                          final offsetAnimation =
                                              animation.drive(tween);

                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset("assets/icons/menu.png"),
                                  ),
                                ))
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),

                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return RoundedButton(
                          text: buttonTitles[index],
                          isSelected: index == selectedIndex,
                          onPressed: () {
                            setState(() {
                              selectedIndex = index;
                              //show respective bottomsheets
                              showBottom(context, index + 1);
                            });
                          },
                        );
                      }),
                ),

                // SizedBox(
                //   height: 20.h,
                // ),
                Flexible(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: dashProvider.dashboard!.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            // shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: dashProvider.dashboard!
                                .length, // Assuming you have only one item in the list
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onLongPress: () {
                                  setState(() {
                                    deleteItems
                                        .add(dashProvider.dashboard![index]);
                                  });
                                },
                                onTap: () {
                                  if (deleteItems.contains(
                                      dashProvider.dashboard![index])) {
                                    setState(() {
                                      deleteItems.remove(
                                          dashProvider.dashboard![index]);
                                      play = false;
                                    });
                                  } else if (deleteItems.isNotEmpty) {
                                    setState(() {
                                      deleteItems
                                          .add(dashProvider.dashboard![index]);
                                    });
                                  } else {
                                    setState(() {
                                      play = true;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 45.h,
                                              width: 45.w,
                                              padding: EdgeInsets.all(5.w),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                image: const DecorationImage(
                                                  image: NetworkImage(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsynwv-5qtogtOwJbIjaPFJUmHpzhxgqIAug&usqp=CAU",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (deleteItems.contains(
                                                dashProvider.dashboard![index]))
                                              Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: CircleAvatar(
                                                    radius: 8.r,
                                                    backgroundColor:
                                                        Kcolors.brandGreen,
                                                    child: Center(
                                                        child: Icon(
                                                            Icons.done_rounded,
                                                            size: 12.sp,
                                                            color: Kcolors
                                                                .white))),
                                              ),
                                          ],
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${dashProvider.dashboard![index].name}",
                                                style: montserrat(
                                                        Kcolors.black, 14)
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                "${dashProvider.dashboard![index].email} | ${dashProvider.dashboard![index].city}",
                                                style: montserrat(
                                                    Kcolors.grey400, 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            print(
                                                "favourite ${dashProvider.dashboard![index].favourite}");
                                            final authProvider =
                                                Provider.of<RegisterProvider>(
                                                    context,
                                                    listen: false);
                                            dashProvider
                                                .updateFavourite(
                                                    authProvider.accessToken!,
                                                    dashProvider
                                                        .dashboard![index].id)
                                                .then((value) {
                                              setState(() {
                                                dashProvider.dashboard![index]
                                                            .favourite ==
                                                        0
                                                    ? dashProvider
                                                        .dashboard![index]
                                                        .favourite = 1
                                                    : dashProvider
                                                        .dashboard![index]
                                                        .favourite = 0;
                                              });
                                            }).onError((error, stackTrace) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.red
                                                      .withOpacity(0.5),
                                                  content: Text(
                                                    'Error! Failed to update Favourite',
                                                    style: mcLaren(
                                                        Kcolors.white, 15),
                                                  ),
                                                ),
                                              );
                                            });
                                          },
                                          icon: dashProvider.dashboard![index]
                                                      .favourite ==
                                                  0
                                              ? Icon(
                                                  Icons.favorite_border,
                                                  color: Kcolors.grey400,
                                                  size: 20.sp,
                                                )
                                              : Icon(
                                                  Icons.favorite,
                                                  color: Kcolors.brandGreen,
                                                  size: 20.sp,
                                                ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
            Positioned(
                child: Visibility(visible: play, child: AudioPlayerWidget()),
                bottom: 0,
                left: 0,
                right: 0)
          ],
        ),
      ),
    );
  }
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isSelected ? Kcolors.brandGreen : Kcolors.grey300,
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        margin: EdgeInsets.all(5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: widget.isSelected ? Colors.white : Kcolors.grey500,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: widget.isSelected ? Colors.white : Kcolors.grey500,
            )
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final Function onPressed;

  RoundedButton(
      {required this.text, required this.isSelected, required this.onPressed});

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

Future openBottomSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
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
