import 'package:flutter/material.dart';

enum TextFieldTypes<TextInputType> { email, password }

class RootNodeTextField extends StatefulWidget {
  const RootNodeTextField({
    Key? key,
    required this.controller,
    required this.type,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final TextFieldTypes type;
  final String hintText;

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
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20 * 8),
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
              filled: true,
              fillColor: Colors.white10,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(
                  top: 16, bottom: 16, left: 20, right: 0),
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
                        _passVisible ? Icons.visibility : Icons.visibility_off,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _passVisible = !_passVisible;
                        });
                      },
                    )
                  : null),
        ));
  }
}
