import 'package:flutter/material.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/repository/user_repo.dart';
import 'package:rootnode/screen/home_screen.dart';
import 'package:rootnode/screen/register_screen.dart';
import 'package:rootnode/widgets/rootnode_widget.dart';

class LoginScreen extends StatefulWidget {
  final String? email;
  const LoginScreen({super.key, this.email});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userRepo = UserRepoImpl();
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
        margin: const EdgeInsets.all(20),
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
  void initState() {
    if (widget.email != null) {
      _emailFieldController.text = widget.email!;
    }

    super.initState();
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
          width: double.infinity,
          child: CustomScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Form(
                    key: _globalkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: 300,
                        //   child: Opacity(
                        //       opacity: 0.1,
                        //       child: Image.asset("assets/images/rootnode_w.png")),
                        // ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 40),
                          child: const RootNodeTextLogo(),
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
                            style:
                                const ButtonStyle(alignment: Alignment.center),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (_globalkey.currentState!.validate()) {
                                _showSnackBar(
                                    "Logging in..", Colors.green[400]!, false);
                                User? res = await userRepo.loginUser(
                                  _emailFieldController.text,
                                  _passwordFieldController.text,
                                );
                                if (res == null) {
                                  _showSnackBar("Invalid email or password",
                                      Colors.red[400]!, true);
                                  return;
                                }
                                Future.delayed(
                                  const Duration(seconds: 2),
                                  () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomeScreen(user: res)),
                                  ),
                                );
                              } else {
                                _showSnackBar(
                                    "Invalid fields", Colors.red[400]!, true);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                "Don't have account?",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 16),
                              ),
                              TextButton(
                                  onPressed: (() {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const RegisterScreen()));
                                  }),
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.cyan, fontSize: 16),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

class RootNodeTextLogo extends StatelessWidget {
  const RootNodeTextLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: "ROOT",
          style: TextStyle(
              color: const Color(0xFF111111),
              fontSize: 40,
              fontWeight: FontWeight.w900,
              shadows: [
                Shadow(color: Colors.cyan[300]!, offset: const Offset(3, -3)),
                Shadow(color: Colors.cyan[400]!, offset: const Offset(-3, 3))
              ]),
        ),
        const TextSpan(
          text: "NODE",
          style: TextStyle(
              color: Color(0xFF111111),
              fontSize: 40,
              fontWeight: FontWeight.w900,
              shadows: [
                Shadow(color: Colors.white54, offset: Offset(3, -3)),
                Shadow(color: Colors.white70, offset: Offset(-3, 3))
              ]),
        ),
      ]),
    );
  }
}
