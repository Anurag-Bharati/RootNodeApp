import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/font.dart';

class RootNodeRadioButton extends StatefulWidget {
  const RootNodeRadioButton({
    super.key,
    required this.options,
    required this.name,
    required this.onChanged,
    required this.selected,
  });
  final int selected;
  final List<String> options;
  final String name;
  final ValueChanged<String> onChanged;

  @override
  State<RootNodeRadioButton> createState() => _RootNodeRadioButtonState();
}

class _RootNodeRadioButtonState extends State<RootNodeRadioButton> {
  late int selected;
  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        runAlignment: WrapAlignment.spaceBetween,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(widget.name, style: RootNodeFontStyle.body),
          Wrap(
            spacing: 10,
            children: _generateRadioCluster(),
          ),
        ],
      ),
    );
  }

  void _setChange() => widget.onChanged(widget.options[selected].toLowerCase());

  List<Widget> _generateRadioCluster() {
    final List<Widget> generated = [];
    final List<String> options = widget.options;
    for (int i = 0; i < options.length; i++) {
      Widget widget = OutlinedButton(
        onPressed: () => setState(() {
          selected = i;
          _setChange();
        }),
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) =>
              selected == i
                  ? const Color.fromRGBO(2, 116, 132, 1)
                  : Colors.white10),
          side: MaterialStateBorderSide.resolveWith((states) =>
              BorderSide(color: selected == i ? Colors.cyan : Colors.white10)),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Text(
          options[i],
          style: RootNodeFontStyle.caption,
        ),
      );
      generated.add(widget);
    }
    return generated;
  }
}
