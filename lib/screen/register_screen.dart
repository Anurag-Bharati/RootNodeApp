import 'package:flutter/material.dart';
import 'package:rootnode/app/utils/snackbar.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/repository/user_repo.dart';
import 'package:rootnode/screen/login_screen.dart';
import 'package:rootnode/widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  static const route = "/register";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final userRepo = UserRepoImpl();
  final _fnameFieldController = TextEditingController();
  final _lnameFieldController = TextEditingController();
  final _confirmFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _scrollController = ScrollController();
  final _globalkey = GlobalKey<FormState>();

  _showRegSnackBar(int status) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: status > 0 ? Colors.green : Colors.red,
        margin: const EdgeInsets.all(20),
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
    showSnackbar(context, "Signing Up..", Colors.green[400]!,
        dismissable: false);

    User user = User(
      _fnameFieldController.text,
      _lnameFieldController.text,
      _emailFieldController.text,
      _passwordFieldController.text,
    );

    int status = await userRepo.saveUser(user);
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
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: _globalkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => _backToLogin(context, null),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                "Back",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      RootNodeTextField(
                        controller: _fnameFieldController,
                        hintText: "First name",
                        type: TextFieldTypes.email,
                      ),
                      RootNodeTextField(
                        controller: _lnameFieldController,
                        hintText: "Last name",
                        type: TextFieldTypes.email,
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
                      RootNodeTextField(
                        controller: _confirmFieldController,
                        hintText: "Confirm password",
                        type: TextFieldTypes.password,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.cyan,
                        ),
                        margin: const EdgeInsets.only(
                            left: 40, right: 40, top: 10, bottom: 40),
                        child: TextButton(
                          style: const ButtonStyle(alignment: Alignment.center),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_globalkey.currentState!.validate()) {
                              _registerUser();
                            } else {
                              showSnackbar(
                                  context, "Invalid fields", Colors.red[400]!);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Register',
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void _backToLogin(BuildContext context, String? email) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen(email: email)));
  }
}
