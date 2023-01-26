import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/app/constant/layout.dart';
import 'package:rootnode/helper/switchRoute.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/screen/dashboard/event_screen.dart';
import 'package:rootnode/screen/dashboard/home_screen.dart';
import 'package:rootnode/screen/dashboard/messenger_screen.dart';
import 'package:rootnode/screen/dashboard/node_screen.dart';
import 'package:rootnode/screen/misc/create_post.dart';
import 'package:rootnode/screen/misc/setting.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.user});
  final User? user;

  static const String route = "dashboardScreen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool navVisible = true;
  @override
  void initState() {
    super.initState();
  }

  void showNavbar() => null;
  void hideNavbar() => null;

  // setState(() {navVisible = false;});

  Future<void> _navigateToCreatePost(BuildContext context, User user) async {
    Navigator.of(context, rootNavigator: true).pop('dialog');
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            CreatePostScreen(user: user, type: PostType.image),
      ),
    );
    if (!mounted) return;
    if (result == null) return;
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          '$result',
          style: RootNodeFontStyle.label.copyWith(color: Colors.cyan),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xFF111111),
      ));
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: mqSmallH(context) ? 80 : 60,
        backgroundColor: const Color(0xFF111111),
        title: RootNodeBar(user: widget.user!),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              _selectedIndex == 2
                  ? IconButton(
                      splashRadius: 20,
                      onPressed: () {},
                      icon: const Icon(Icons.visibility,
                          color: Colors.white70, size: 22),
                    )
                  : const SizedBox(),
              _selectedIndex == 0
                  ? IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        showDialog(
                          barrierColor: Colors.black87,
                          context: context,
                          builder: (dialogContex) => showPostOptions(context),
                        );
                      },
                      icon: const Icon(Icons.add,
                          color: Colors.white70, size: 24),
                    )
                  : const SizedBox(),
              mqSmallW(context)
                  ? IconButton(
                      splashRadius: 20,
                      onPressed: () {},
                      icon: const Icon(Icons.notifications,
                          color: Colors.white70, size: 22),
                    )
                  : const SizedBox()
            ]),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: [
        HomeScreen(
            user: widget.user!, showNavbar: showNavbar, hideNavbar: hideNavbar),
        const NodeScreen(),
        const MessengerScreen(),
        const EventScreen(),
      ]),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        // transform: Matrix4.translationValues(0, navVisible ? 0 : 100, 0),
        height: navVisible ? kBottomNavigationBarHeight + 8 : 0,
        child: GNav(
          tabMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tabBorderRadius: 50,
          tabBackgroundColor:
              mqSmallW(context) ? Colors.white12 : Colors.transparent,
          curve: Curves.easeInQuad,
          duration: const Duration(milliseconds: 300),
          color: Colors.white54,
          activeColor: Colors.cyan,
          iconSize: mqSmallW(context)
              ? LayoutConstants.postIconBig
              : LayoutConstants.postIcon,
          backgroundColor: const Color(0xFF111111),
          padding: mqSmallW(context)
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
              : const EdgeInsets.all(5),
          gap: mqSmallW(context) ? 10 : 0,
          tabs: [
            GButton(
                icon: Boxicons.bxs_home,
                text: mqSmallW(context) ? 'Home' : "" /***/),
            GButton(
                icon: Boxicons.bx_stats,
                text: mqSmallW(context) ? 'Node' : "" /***/),
            GButton(
                icon: Boxicons.bxs_message_square_dots,
                text: mqSmallW(context) ? 'Chat' : ""),
            GButton(
                icon: Boxicons.bxs_calendar_event,
                text: mqSmallW(context) ? 'Event' : ""),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (value) => setState(() {
            showNavbar();
            _selectedIndex = value;
          }),
        ),
      ),
    );
  }

  AlertDialog showPostOptions(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white70,
      title: Text('Choose a type',
          textAlign: TextAlign.center,
          style: RootNodeFontStyle.body.copyWith(color: Colors.black)),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.black12),
            minimumSize: MaterialStateProperty.resolveWith(
                (states) => const Size(double.infinity, 50)),
          ),
          onPressed: () => _navigateToCreatePost(context, widget.user!),
          child:
              const Text('Image Post', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.black12),
            minimumSize: MaterialStateProperty.resolveWith(
                (states) => const Size(double.infinity, 50)),
          ),
          onPressed: () => null,
          child:
              const Text('Video Post', style: TextStyle(color: Colors.black)),
        )
      ],
      icon: const Icon(Boxicons.bx_image_add, color: Colors.black),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      alignment: Alignment.center,
      actionsOverflowButtonSpacing: 10,
    );
  }

  bool mqSmallW(BuildContext context) =>
      MediaQuery.of(context).size.width > 320;
  bool mqSmallH(BuildContext context) =>
      MediaQuery.of(context).size.height > 320;
}

class RootNodeBar extends StatelessWidget {
  final User user;
  const RootNodeBar({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () => switchRouteByPush(context, SettingScreen(user: user)),
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.all(3),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white10,
              shape: BoxShape.circle,
            ),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              image: user.avatar != null
                  ? "${ApiConstants.baseUrl}\\${user.avatar}"
                  : "https://cdn.shopify.com/s/files/1/0344/6469/files/angry.jpg?v=1560891349",
              placeholder: 'assets/images/image_grey.png',
            ),
          ),
        ),
        const SizedBox(width: 10 - 3),
        Expanded(
          child: Wrap(
            direction: Axis.vertical,
            spacing: -5,
            children: [
              Text("Good Morning,", style: RootNodeFontStyle.label),
              Text(
                  user.fname != null
                      ? "${user.fname} ${user.lname!.substring(0, 1).toUpperCase()}."
                      : "ANURAG",
                  style: RootNodeFontStyle.title),
            ],
          ),
        ),
      ],
    );
  }
}
