import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_pro/util/dimensions.dart';
import 'package:task_pro/util/images.dart';
import 'package:task_pro/util/theme_colors.dart';
import 'package:task_pro/view/screens/all%20task/all_task_screen.dart';
import 'package:task_pro/view/screens/home/home_screen.dart';
import 'package:task_pro/view/screens/home/widget/todays_task_widget.dart';
import 'package:task_pro/view/screens/profile/profile_screen.dart';
import 'package:task_pro/view/screens/profile/user%20profile/user_profile_details.dart';
import 'package:task_pro/view/screens/rewards/rewards_screen.dart';
import 'package:task_pro/view/screens/task/task_detail_screen.dart';
import 'package:task_pro/view/screens/task/task_screen.dart';

class BottomNavigation extends StatefulWidget {
  int index;
  BottomNavigation({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  bool backIcon = false;

  int _selectedTab = 0;

  final List<Widget> _body = [
    const HomeScreen(),
    const AllTaskScreen(),
    const RewardsScreen(),
    const ProfileScreen(),
  ];

  final _tab1navigatorKey = GlobalKey<NavigatorState>();
  final _tab2navigatorKey = GlobalKey<NavigatorState>();
  final _tab3navigatorKey = GlobalKey<NavigatorState>();
  final _tab4navigatorKey = GlobalKey<NavigatorState>();

  List<PersistentTabItem>? items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.index != null) {
      setState(() {
        _selectedTab = widget.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    items = [
      PersistentTabItem(
        tab: _body[0],
        icon: const Icon(Icons.home_outlined),
        title: 'home'.tr,
        navigatorkey: _tab1navigatorKey,
      ),
      PersistentTabItem(
        tab: _body[1],
        icon: SvgPicture.asset(Images.task_list_icon,
          // Images.leaderboard_icon,
          // height: 24,
          color: _selectedTab == 1
              ? ThemeColors.primaryColor
              : ThemeColors.blackColor,
        ),
        title: 'all_task'.tr,
        navigatorkey: _tab2navigatorKey,
      ),
      PersistentTabItem(
        tab: _body[2],
        icon: SvgPicture.asset(
          Images.payout_icon,
      color: _selectedTab == 2
          ? ThemeColors.primaryColor
          : ThemeColors.blackColor,
          ),
        // Icon(Icons.ac_unit,
        //   color: _selectedTab == 2
        //       ? ThemeColors.primaryColor
        //       : ThemeColors.blackColor,
        // ),
        title: 'rewards'.tr,
        navigatorkey: _tab3navigatorKey,
      ),
      PersistentTabItem(
        tab: _body[3],
        icon: SvgPicture.asset(
          Images.profile_icon,
          color: _selectedTab == 3
              ? ThemeColors.primaryColor
              : ThemeColors.blackColor,
        ),
        title: 'profile'.tr,
        navigatorkey: _tab4navigatorKey,
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (items![_selectedTab].navigatorkey?.currentState?.canPop() ??
            false) {
          items![_selectedTab].navigatorkey?.currentState?.pop();
          // showExitPopup();
          return false;
        }
        // else {
        //   return true;
        // }
        else {
          if (_selectedTab != 0) {
            setState(() {
              _selectedTab = 0;
            });
            return false;
          } else {
            var value = await showExitPopup();
            return value;
          }
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _selectedTab,
          children: items!
              .map((page) => Navigator(
            key: page.navigatorkey,
            onGenerateInitialRoutes: (navigator, initialRoute) {
              return [
                MaterialPageRoute(builder: (context) => page.tab)
              ];
            },
          ))
              .toList(),
        ),

        /// Define the persistent bottom bar
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: ThemeColors.todaysTaskCardColor,
              borderRadius: BorderRadius.circular(
                  Dimensions.RADIUS_EXTRA_LARGE),
              boxShadow: const [
                BoxShadow(
                  color: ThemeColors.greyTextColor,
                  blurRadius: 2,
                  spreadRadius: 0.3,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: BottomNavigationBar(
                // backgroundColor: mainColor,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedTab,
                onTap: (index) {
                  /// Check if the tab that the user is pressing is currently selected
                  if (index == _selectedTab) {
                    /// if you want to pop the current tab to its root then use
                    items![index]
                        .navigatorkey
                        ?.currentState
                        ?.popUntil((route) => route.isFirst);

                    /// if you want to pop the current tab to its last page
                    /// then use
                    // widget.items[index].navigatorkey?.currentState?.pop();
                  } else {
                    setState(() {
                      _selectedTab = index;
                    });
                  }
                },
                selectedItemColor: ThemeColors.primaryColor,
                unselectedItemColor: ThemeColors.blackColor,
                selectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
                unselectedLabelStyle: GoogleFonts.poppins(fontSize: 10),
                items: items!
                    .map((item) =>
                    BottomNavigationBarItem(icon: item.icon, label: item.title))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('exit_app'.tr),
        content: Text('do_you_want_to_exit'.tr),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ElevatedButton.styleFrom(
              side: const BorderSide(
                  color: ThemeColors.primaryColor, width: 1),
              backgroundColor: ThemeColors.primaryColor,
              // color:Colors.red,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            //return false when click on "NO"
            child: Text('no'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(
                  color: ThemeColors.primaryColor, width: 1),
              backgroundColor: ThemeColors.primaryColor,
              // color:Colors.red,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            //return true when click on "Yes"
            child: Text('yes'.tr),
          ),
        ],
      ),
    ) ??
        false; //if showDialouge had returned null, then return false
  }
}

class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final Widget icon;

  PersistentTabItem(
      {required this.tab,
        this.navigatorkey,
        required this.title,
        required this.icon});
}