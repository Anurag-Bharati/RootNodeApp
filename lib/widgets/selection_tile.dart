import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/font.dart';

class SelectionTile extends StatelessWidget {
  const SelectionTile({
    super.key,
    required this.title,
    required this.tileButton,
    this.widthFraction = 0.8,
    this.heightFraction = 0.8,
    this.column = 2,
    this.hideTitle = false,
  })  : assert(widthFraction <= 1 && widthFraction >= 0),
        assert(heightFraction <= 1 && heightFraction >= 0);
  final String title;
  final List<TileButton> tileButton;
  final double widthFraction;
  final double heightFraction;
  final int column;
  final bool hideTitle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      runSpacing: -1,
      spacing: -1,
      children: [
        hideTitle
            ? const SizedBox.shrink()
            : Container(
                padding: const EdgeInsets.only(
                    top: 5, left: 15, right: 15, bottom: 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Color(0xFFEEEEEE),
                ),
                child: Text(
                  title,
                  style: RootNodeFontStyle.caption
                      .copyWith(color: const Color(0xFF111111), fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
        Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * heightFraction),
            width: MediaQuery.of(context).size.width * widthFraction,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFEEEEEE),
            ),
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: column,
              shrinkWrap: true,
              children: tileButton,
            )),
      ],
    );
  }
}

enum TileType { image, video, text, markdown }

class TileButton extends StatelessWidget {
  const TileButton({
    super.key,
    required this.type,
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  final TileType type;
  final IconData icon;
  final String label;
  final Function(TileType type) onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(type),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black12),
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF111111), size: 26, weight: 0.5),
            Text(
              label,
              style: RootNodeFontStyle.body.copyWith(
                color: const Color(0xFF111111),
              ),
            )
          ],
        ),
      ),
    );
  }
}
