import 'package:avatar_glow/avatar_glow.dart';
import 'package:boxicons/boxicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_conn.dart';
import 'package:rootnode/helper/responsive_helper.dart';
import 'package:rootnode/helper/utils.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/repository/conn_repo.dart';
import 'package:rootnode/widgets/placeholder.dart';

class NodeScreen extends StatefulWidget {
  const NodeScreen({super.key, required this.user});
  final User user;
  @override
  State<NodeScreen> createState() => _NodeScreenState();
}

class _NodeScreenState extends State<NodeScreen> {
  final _connRepo = ConnRepoImpl();
  final _scrollController = ScrollController();
  late ConnOverviewResponse? overview;
  List<Node> recent = [];
  List<Node> old = [];
  int count = 0;

  _getOverview() async {
    overview = await _connRepo.getOldRecentConns();
    recent.clear();
    old.clear();
    int index = overview!.data!.recent!.length > 2 ? 0 : -1;
    recent.addAll(overview!.data!.recent!.map((e) {
      index++;
      return Node(
        index: index,
        date: Utils.getTimeAgo(e.date!),
        invert: true,
        uri: e.user!.avatar ??
            "https://icon-library.com/images/anonymous-user-icon/anonymous-user-icon-2.jpg",
      );
    }).toList());
    recent.add(const Node(date: 'this.add', invert: true, index: 3));
    index = 1;
    old.add(
      Node(
        uri: widget.user.avatar,
        date: 'this',
        index: 0,
      ),
    );
    old.addAll(overview!.data!.old!.map((e) {
      index++;
      return Node(
        index: index,
        date: Utils.getTimeAgo(e.date!),
        uri: e.user!.avatar ??
            "https://icon-library.com/images/anonymous-user-icon/anonymous-user-icon-2.jpg",
      );
    }).toList());

    count = overview!.data!.count ?? 0;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getOverview();
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        const SliverToBoxAdapter(
            child: ConstrainedSliverWidth(
                maxWidth: 720, child: DummySearchField())),
        SliverToBoxAdapter(
            child: ConstrainedSliverWidth(
          maxWidth: 720,
          child: AnimatedContainer(
            width: double.infinity,
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 500),
              height: MediaQuery.of(context).size.width <= 480
                  ? 300
                  : MediaQuery.of(context).size.width * 0.5,
              // color: Colors.white10,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: CustomPaint(
                        isComplex: true,
                        foregroundPainter: PolyLinePainter(),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 28),
                              child: SizedBox.expand(
                                child: CustomPaint(
                                  foregroundPainter: LinePainter(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: old.isEmpty
                                  ? [
                                      const Node(
                                          uri: null, date: 'N/A', index: 1),
                                      const Node(
                                          uri: null, date: 'N/A', index: 2),
                                      const Node(
                                          uri: null, date: 'N/A', index: 3),
                                    ]
                                  : old,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {});
                            debugPrint("Mynodes");
                          },
                          child: AvatarGlow(
                            endRadius: 35,
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFFCCCCCC),
                              maxRadius: 25,
                              child: Text("+$count",
                                  style: RootNodeFontStyle.caption.copyWith(
                                    color: const Color(0xFF111111),
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: SizedBox.expand(
                                child: CustomPaint(
                                  foregroundPainter: LinePainter(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: recent.isEmpty
                                  ? const [
                                      Node(
                                          date: 'test', invert: true, index: 0),
                                      Node(
                                          date: 'test', invert: true, index: 1),
                                      Node(
                                          date: 'test', invert: true, index: 2),
                                    ]
                                  : recent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      ],
    );
  }
}

class Node extends StatelessWidget {
  const Node({
    super.key,
    this.uri,
    required this.date,
    this.invert = false,
    required this.index,
  });
  final int index;
  final String? uri;
  final String date;
  final bool invert;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Container(
            padding:
                EdgeInsets.only(bottom: !invert ? 20 : 0, top: invert ? 20 : 0),
            child: GestureDetector(
              onTap: () => debugPrint(index.toString()),
              child: Container(
                padding: const EdgeInsets.all(3),
                height: 56,
                width: 56,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: date == 'this.add' || !invert && index == 0
                      ? Colors.orange
                      : const Color(0xFFCCCCCC),
                ),
                child: CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: const Color(0xFFCCCCCC),
                  foregroundImage: uri != null
                      ? CachedNetworkImageProvider(
                          "${ApiConstants.baseUrl}/$uri",
                          maxHeight: 256,
                          maxWidth: 256,
                          cacheKey: uri,
                        )
                      : null,
                  child: date == "this.add"
                      ? const Icon(
                          Boxicons.bx_plus,
                          size: 30,
                          color: Color(0xFF111111),
                        )
                      : uri == null
                          ? const Icon(Boxicons.bx_question_mark,
                              size: 30, color: Color(0x22111111))
                          : null,
                ),
              ),
            ),
          ),
          (index != 0 && invert) || (index != 3 && !invert)
              ? Positioned(
                  top: invert ? 0 : null,
                  bottom: !invert ? 0 : null,
                  left: 0,
                  right: 0,
                  child: Text(
                    date,
                    textAlign: TextAlign.center,
                    style: RootNodeFontStyle.labelSmall.copyWith(
                      color: date.contains('this')
                          ? Colors.orange
                          : Colors.white54,
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCCCCCC)
      ..strokeWidth = 3;
    canvas.drawLine(
      Offset(0, size.height * 0.5),
      Offset(size.width, size.height * 0.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PolyLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCCCCCC)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeMiterLimit = 1;
    final path = Path();

    path.moveTo(0, size.height - 80);
    path.lineTo(0, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width, 71);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
