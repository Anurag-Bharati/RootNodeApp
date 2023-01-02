import 'package:flutter/material.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/repository/user_repo.dart';
import 'package:rootnode/screen/home_screen.dart';
import 'package:rootnode/widgets/rootnode_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final userRepo = UserRepoImpl();
  final _fnameFieldController = TextEditingController();
  final _lnameFieldController = TextEditingController();
  final _unameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _scrollController = ScrollController();
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

  _showRegSnackBar(int status) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: status > 0 ? Colors.green : Colors.red,
        content: status > 0
            ? const Text("Registered Successfully!")
            : const Text("Something went wrong!"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
          textColor: Colors.white,
        ),
      ),
    );
  }

  _registerUser() async {
    _showSnackBar("Signing Up..", Colors.green[400]!, false);

    User user = User(
      _fnameFieldController.text,
      _lnameFieldController.text,
      _unameFieldController.text,
      _emailFieldController.text,
      _passwordFieldController.text,
    );

    int status = await userRepo.registerUser(user);
    _showRegSnackBar(status);
    if (status > 0) {
      Future.delayed(const Duration(seconds: 2),
          () => _backToLogin(context, _emailFieldController.text));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _fnameFieldController.dispose();
    _lnameFieldController.dispose();
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
          child: Form(
            key: _globalkey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () => _backToLogin(context, null),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white70,
                          )),
                    ),
                    RootNodeTextField(
                      controller: _fnameFieldController,
                      hintText: "First name",
                      type: TextFieldTypes.email,
                      onPressed: () {},
                    ),
                    RootNodeTextField(
                      controller: _lnameFieldController,
                      hintText: "Last name",
                      type: TextFieldTypes.email,
                      onPressed: () {},
                    ),
                    RootNodeTextField(
                      controller: _unameFieldController,
                      hintText: "Username",
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
                            _registerUser();
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
      ),
    );
  }

  void _backToLogin(BuildContext context, String? email) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(email)));
  }
}
