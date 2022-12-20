import 'package:flutter/material.dart';

enum TextFieldTypes<TextInputType> { email, password }

class RootNodeTextField extends StatefulWidget {
  const RootNodeTextField({
    Key? key,
    required this.controller,
    required this.type,
    required this.hintText,
    required this.onPressed,
  }) : super(key: key);

  final TextEditingController controller;
  final TextFieldTypes type;
  final String hintText;
  final Null Function() onPressed;

  @override
  State<RootNodeTextField> createState() => _RootNodeTextFieldState();
}

class _RootNodeTextFieldState extends State<RootNodeTextField> {
  bool _passVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
          child: TextFormField(
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20 * 8),
            onTap: widget.onPressed(),
            controller: widget.controller,
            style: const TextStyle(
              color: Colors.white70,
            ),
            keyboardType: widget.type == TextFieldTypes.email
                ? TextInputType.emailAddress
                : TextInputType.visiblePassword,
            obscureText:
                widget.type != TextFieldTypes.email ? !_passVisible : false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            textInputAction: widget.type == TextFieldTypes.email
                ? TextInputAction.next
                : TextInputAction.done,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: Colors.white54,
                ),
                labelStyle: const TextStyle(
                  color: Colors.white54,
                ),
                errorStyle: TextStyle(color: Colors.red[400]!),
                suffixIcon: widget.type == TextFieldTypes.password
                    ? IconButton(
                        color: Colors.white70,
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                        iconSize: 20,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          _passVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _passVisible = !_passVisible;
                          });
                        },
                      )
                    : null),
          ),
        ));
  }
}
