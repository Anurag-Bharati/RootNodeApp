import 'package:flutter/material.dart';
import 'package:rootnode/widgets/rootnode_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailFieldController = TextEditingController();
  final _scrollController = ScrollController();
  final _passwordFieldController = TextEditingController();
  final _globalkey = GlobalKey<FormState>();

  _showSnackBar(String message, Color x, bool dismissable) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: x,
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
        action: dismissable
            ? SnackBarAction(
                label: "OK",
                onPressed: () {},
                textColor: Colors.white,
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: null,
            child: Form(
              key: _globalkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      height: 300,
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: double.infinity,
                        child: Image.asset(
                          "assets/images/nodebg.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      height: 300,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Color(0xFF111111)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 20,
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () => _backToLogin(context),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white70,
                          )),
                    ),
                  ]),
                  RootNodeTextField(
                    controller: _emailFieldController,
                    hintText: "Name",
                    type: TextFieldTypes.email,
                    onPressed: () {},
                  ),
                  RootNodeTextField(
                    controller: _emailFieldController,
                    hintText: "Email",
                    type: TextFieldTypes.email,
                    onPressed: () {},
                  ),
                  RootNodeTextField(
                    controller: _passwordFieldController,
                    hintText: "Password",
                    type: TextFieldTypes.password,
                    onPressed: () {},
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.cyan,
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: TextButton(
                      style: const ButtonStyle(alignment: Alignment.center),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_globalkey.currentState!.validate()) {
                          _showSnackBar(
                              "Signing Up..", Colors.green[400]!, false);
                          Future.delayed(const Duration(seconds: 2),
                              () => _backToLogin(context));
                        } else {
                          _showSnackBar(
                              "Invalid fields", Colors.red[400]!, true);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _backToLogin(BuildContext context) {
    Navigator.pop(context);
  }
}
