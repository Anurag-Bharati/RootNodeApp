import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        // For OverScroll Glow Effect
        accentColor: const Color(0xFFF1F1F1),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFF111111),
    ),
    debugShowCheckedModeBanner: false,
    home: const HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  void _fetchMoreData() async {
    print("Test");
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetchMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // extendBody: true,
        // extendBodyBehindAppBar: true,
        bottomNavigationBar: const GNav(
          tabMargin: EdgeInsets.all(10),
          tabBorderRadius: 50,
          tabBackgroundColor: Colors.white12,
          curve: Curves.easeInQuad,
          duration: Duration(milliseconds: 300),
          color: Colors.white54,
          activeColor: Colors.cyan,
          iconSize: 20,
          backgroundColor: Color(0xFF111111),
          padding: EdgeInsets.all(10),
          gap: 10,
          tabs: [
            GButton(icon: Boxicons.bxs_home, text: 'Home' /***/),
            GButton(icon: Boxicons.bx_stats, text: 'Node' /***/),
            GButton(icon: Boxicons.bxs_message_square_dots, text: 'Chat'),
            GButton(icon: Boxicons.bxs_calendar_event, text: 'Event'),
          ],
        ),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          backgroundColor: const Color(0xFF111111),
          title: const RootNodeBar(),
          actions: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 10),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: Colors.white70, size: 24),
                ),
                IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: const Icon(Icons.notifications,
                      color: Colors.white70, size: 22),
                )
              ]),
            ),
          ],
        ),
        body: Container(
          color: const Color(0xFF111111),
          width: double.infinity,
          height: double.maxFinite,
          child:
              // POST
              const Text(""),
        ),
      ),
    );
  }
}

class RootNodeBar extends StatelessWidget {
  const RootNodeBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {},
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
              image:
                  "https://cdn.shopify.com/s/files/1/0344/6469/files/angry.jpg?v=1560891349",
              placeholder: 'assets/images/image_grey.png',
            ),
          ),
        ),
        const SizedBox(width: 10 - 3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Good Morning,",
                style: TextStyle(
                    overflow: TextOverflow.fade,
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              Text(
                "ANURAG",
                style: TextStyle(
                  overflow: TextOverflow.fade,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
