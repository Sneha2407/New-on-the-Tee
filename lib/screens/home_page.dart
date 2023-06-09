import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_on_the_tee/screens/menu_page.dart';
import 'package:new_on_the_tee/utils/colors.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:new_on_the_tee/widgets/bottomsheets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = -1;
  List buttonTitles = ["Email", "Home Town", "Favorites"];

  // @override
  // void initState() {
  //   showBottom(context, 4);
  //   super.initState();
  // }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    Future.delayed(const Duration(seconds: 1), () {
      // context.goNamed(AppRoute.getStartedPage.name);
      // openBottomSheet(context, Message());
      showBottom(context, 4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                            image: AssetImage("assets/images/welcome.png"),
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
                                MaterialPageRoute(
                                  builder: (context) => MenuPage(),
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
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: ListView.builder(
                // shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: 10, // Assuming you have only one item in the list
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 45.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsynwv-5qtogtOwJbIjaPFJUmHpzhxgqIAug&usqp=CAU",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Guy Hawkins",
                                  style: montserrat(Kcolors.black, 14)
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "kenzi.lawson@example.com | pembroke pines",
                                  style: montserrat(Kcolors.grey400, 10),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              "assets/icons/heart.png",
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
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
