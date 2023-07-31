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
  List<String> deleteItems = [];
  bool play = false;
  // int playIndex = 0;
  bool isLoading = false;
  String accessToken = "";
  final TextEditingController _searchController = TextEditingController();
  void getData() async {
    final dashProvider = Provider.of<DashboardProvider>(context, listen: false);
    final authProvider = Provider.of<RegisterProvider>(context, listen: false);
    isLoading = true;
    await dashProvider.fetchData(authProvider.accessToken!, "");
    accessToken = authProvider.accessToken!;
    setState(() {});
    isLoading = false;
  }

  @override
  void initState() {
    getData();
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
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                child: SizedBox(
                  height: 40.h,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        print(accessToken);

                        dashProvider.deleteAnnoucement(
                            deleteItems, accessToken);
                        deleteItems.clear();

                        setState(() {});
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Kcolors.redLogout),
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
                          controller: _searchController,
                          onChanged: (value) async {
                            await dashProvider.fetchFilterData(
                                accessToken, "", _searchController.text, "");
                          },
                          onTap: () async {
                            setState(() {
                              selectedIndex = -1;
                            });
                            await dashProvider.fetchData(accessToken, "");
                          },
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
                          onPressed: () async {
                            if (selectedIndex == index) {
                              selectedIndex = -1;
                              setState(() {});

                              await dashProvider.fetchData(accessToken, "");
                              return;
                              //pass empty string to api
                            } else if (selectedIndex != index &&
                                selectedIndex != -1) {
                              setState(() {});
                              await dashProvider.fetchData(accessToken, "");
                              selectedIndex = index;
                              showBottom(context, index + 1);
                              return;
                            }
                            selectedIndex = index;
                            //show respective bottomsheets
                            showBottom(context, index + 1);
                          },
                        );
                      }),
                ),

                // SizedBox(
                //   height: 20.h,
                // ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child:
                              // dashProvider.dashboard == null &&
                              //         dashProvider.dashboard!.data.isEmpty
                              //     ? const Center(child: CircularProgressIndicator())
                              //     :
                              ListView.builder(
                            // shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 50.h),
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: dashProvider.dashboard!.data
                                .length, // Assuming you have only one item in the list
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onLongPress: () {
                                  if (!dashProvider.isPlaying) {
                                    setState(() {
                                      deleteItems.add(dashProvider
                                              .dashboard?.data[index].id
                                              .toString() ??
                                          "");
                                    });
                                    // dashProvider.addDeleteID(
                                    //     dashProvider.dashboard![index].id);
                                  }
                                },
                                onTap: () async {
                                  if (deleteItems.contains(dashProvider
                                      .dashboard!.data[index].id
                                      .toString())) {
                                    setState(() {
                                      deleteItems.remove(dashProvider
                                          .dashboard!.data[index].id
                                          .toString());
                                      play = false;
                                    });
                                    deleteItems.removeWhere(
                                      (element) =>
                                          element ==
                                          dashProvider.dashboard!.data[index].id
                                              .toString(),
                                    );
                                  } else if (deleteItems.isNotEmpty) {
                                    setState(() {
                                      deleteItems.add(dashProvider
                                          .dashboard!.data[index].id
                                          .toString());
                                    });
                                    deleteItems.add(dashProvider
                                        .dashboard!.data[index].id
                                        .toString());
                                  } else {
                                    if (dashProvider.isPlaying &&
                                        dashProvider.playIndex != index) {
                                      dashProvider.setPlay(false);

                                      setState(() {
                                        dashProvider.setPlayIndex(index);
                                      });
                                      await Future.delayed(
                                          const Duration(milliseconds: 100));
                                      dashProvider.setPlay(true);
                                      // dashProvider.setPlay(true);
                                    } else {
                                      dashProvider.setPlayIndex(index);
                                      dashProvider.setPlay(true);
                                    }
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
                                                dashProvider
                                                    .dashboard!.data[index].id
                                                    .toString()))
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
                                                dashProvider.dashboard!
                                                    .data[index].name,
                                                style: montserrat(
                                                        Kcolors.black, 14)
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                "${dashProvider.dashboard!.data[index].email} | ${dashProvider.dashboard!.data[index].city}",
                                                style: montserrat(
                                                    Kcolors.grey400, 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            print(
                                                "favourite ${dashProvider.dashboard!.data[index].favourite}");
                                            final authProvider =
                                                Provider.of<RegisterProvider>(
                                                    context,
                                                    listen: false);
                                            dashProvider
                                                .updateFavourite(
                                                    authProvider.accessToken!,
                                                    dashProvider.dashboard!
                                                        .data[index].id)
                                                .then((value) {
                                              setState(() {
                                                dashProvider
                                                            .dashboard!
                                                            .data[index]
                                                            .favourite ==
                                                        0
                                                    ? dashProvider
                                                        .dashboard!
                                                        .data[index]
                                                        .favourite = 1
                                                    : dashProvider
                                                        .dashboard!
                                                        .data[index]
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
                                          icon: dashProvider.dashboard!
                                                      .data[index].favourite ==
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
            if (dashProvider.dashboard?.data != null && dashProvider.isPlaying)
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Visibility(
                      visible: dashProvider.isPlaying,
                      child: AudioPlayerWidget(
                          index: dashProvider.playIndex,
                          url: dashProvider.dashboard
                                  ?.data![dashProvider.playIndex].url ??
                              "")))
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
