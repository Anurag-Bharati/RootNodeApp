import 'package:boxicons/boxicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/widgets/placeholder.dart';

class NodeScreen extends StatefulWidget {
  const NodeScreen({super.key, required this.user});
  final User user;
  @override
  State<NodeScreen> createState() => _NodeScreenState();
}

class _NodeScreenState extends State<NodeScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        const SliverToBoxAdapter(child: DummySearchField()),
        SliverToBoxAdapter(
            child: AnimatedContainer(
          width: double.infinity,
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 280),
            color: Colors.white10,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: CustomPaint(
                    isComplex: true,
                    foregroundPainter: PolyLinePainter(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            children: [
                              _getAvatar(widget.user.avatar, "this"),
                              _getAvatar(null, "test"),
                              _getAvatar(null, "test"),
                              _getAvatar(null, "test"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFFCCCCCC),
                            radius: 28,
                            child: Text("+250",
                                style: RootNodeFontStyle.caption
                                    .copyWith(color: const Color(0xFF111111))),
                          ),
                        ],
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
                            children: [
                              _getAvatar(null, "test", invert: true),
                              _getAvatar(null, "test", invert: true),
                              _getAvatar(null, "test", invert: true),
                              _getAvatar(null, "this.add", invert: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }

  _getAvatar(String? uri, String date, {bool invert = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            padding:
                EdgeInsets.only(bottom: !invert ? 20 : 0, top: invert ? 20 : 0),
            child: CircleAvatar(
              maxRadius: 28,
              foregroundImage: uri != null
                  ? CachedNetworkImageProvider(
                      "${ApiConstants.baseUrl}/$uri",
                      maxHeight: 256,
                      maxWidth: 256,
                    )
                  : null,
              backgroundColor:
                  date == 'this.add' ? Colors.cyan : const Color(0xFFCCCCCC),
              child: date == "this.add"
                  ? const Icon(
                      Boxicons.bx_plus,
                      size: 30,
                      color: Color(0xFF111111),
                    )
                  : null,
            ),
          ),
          Positioned(
            top: invert ? 0 : null,
            bottom: !invert ? 0 : null,
            left: 0,
            right: 0,
            child: Text(
              date,
              textAlign: TextAlign.center,
              style: RootNodeFontStyle.labelSmall.copyWith(
                color: date.contains('this') ? Colors.orange : Colors.white54,
              ),
            ),
          )
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
      Offset(size.width * 1 / 6, size.height * 0.5),
      Offset(size.width * 5 / 6, size.height * 0.5),
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

    path.moveTo(size.width * 1 / 11, size.height / 1.35);
    path.lineTo(size.width * 1 / 11, size.height * 0.5);
    path.lineTo(size.width / 1.1, size.height * 0.5);
    path.lineTo(size.width / 1.1, size.height * 1 / 11);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
