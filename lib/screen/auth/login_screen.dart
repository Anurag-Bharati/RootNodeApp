import 'package:flutter/material.dart';
import 'package:rootnode/helper/switch_route.dart';
import 'package:rootnode/model/user/user.dart';
import 'package:rootnode/repository/user_repo.dart';
import 'package:rootnode/screen/auth/register_screen.dart';
import 'package:rootnode/screen/dashboard/dashboard.dart';
import 'package:rootnode/widgets/text_field.dart';
import 'package:rootnode/app/utils/snackbar.dart';

class LoginScreen extends StatefulWidget {
  static const route = "login";
  final String? email;
  const LoginScreen({super.key, this.email});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userRepo = UserRepoImpl();
  final _emailFieldController = TextEditingController(text: "anuragbharati");
  final _scrollController = ScrollController();
  final _passwordFieldController = TextEditingController(text: "anurag");
  final _globalkey = GlobalKey<FormState>();

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

  Future<User?> _loginUser() async {
    FocusScope.of(context).unfocus();
    bool res = await userRepo.loginUser(
      identifier: _emailFieldController.text,
      password: _passwordFieldController.text,
      isEmail: false,
    );
    if (!res) {
      // ignore: use_build_context_synchronously
      showSnackbar(context, "Invalid email or password", Colors.red[400]!);
      return null;
    }
    User? user = await userRepo.getUserFromToken();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
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
                          Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 40),
                            child: const RootNodeTextLogo(),
                          ),
                          RootNodeTextField(
                            controller: _emailFieldController,
                            hintText: "Email",
                            type: TextFieldTypes.email,
                          ),
                          RootNodeTextField(
                            controller: _passwordFieldController,
                            hintText: "Password",
                            type: TextFieldTypes.password,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.cyan,
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: TextButton(
                              style: const ButtonStyle(
                                  alignment: Alignment.center),
                              onPressed: () async {
                                if (!_globalkey.currentState!.validate()) {
                                  showSnackbar(context, "Invalid fields",
                                      Colors.red[400]!);
                                  return;
                                }
                                showSnackbar(
                                    context, "Logging in..", Colors.green[400]!,
                                    dismissable: false);
                                User? user = await _loginUser();
                                if (user != null) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();

                                  // ignore: use_build_context_synchronously
                                  return switchRouteByPushReplace(
                                      context, DashboardScreen(user: user));
                                }
                                // ignore: use_build_context_synchronously
                                showSnackbar(
                                  context,
                                  "Sorry! Something went wrong",
                                  Colors.red[400]!,
                                );
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
