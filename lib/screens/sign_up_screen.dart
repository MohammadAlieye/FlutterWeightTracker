import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weight_app/navigation_handler/go.dart';
import 'package:flutter_weight_app/screens/sign_in_screen.dart';

import '../auth_controller/auth_controller.dart';
import '../utils/app_utils.dart';
import '../utils/constants.dart';
import '../widgets/loading_indecator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AppUtils utils = AppUtils();
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingIndicator(
        isLoading: _isLoading,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .16),
                  Text(
                    "Welcome!",
                    style: utils.largeBoldStyle(color: darkOrangeColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please enter your account here",
                    style: utils.mediumTitleStyle(color: orangeColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  utils.textField(
                    width: MediaQuery.of(context).size.width,
                    borderColor: darkOrangeColor,
                    hintText: "Email",
                    prefixIconColor: redColor,
                    prefixIconImage: Icons.email,
                    validator: kEmailValidator,
                    onChange: (value) => _email = value,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  utils.textField(
                      width: MediaQuery.of(context).size.width,
                      borderColor: darkOrangeColor,
                      hintText: "Password",
                      prefixIconColor: redColor,
                      onChange: (value) => _password = value,
                      prefixIconImage: Icons.password,
                      validator: (pas) {
                        if (pas!.isEmpty) {
                          return 'Please Enter Your Password !';
                        }
                        if (pas.length < 8) {
                          return 'Please enter more then 8 number';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
                  ),
                  utils.gradientButton(
                    onTap: () => onTapSingIn(),
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: "Sign up",
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Text(
                        "Already Have an account?",
                        style: utils.mediumTitleStyle(color: redColor),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      GestureDetector(
                        onTap: () {
                          Go.to(context, const SignInScreen());
                        },
                        child: Text(
                          "Sign in",
                          style: utils.mediumTitleStyle(color: orangeColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? kEmailValidator(String? emailValue) {
    if (emailValue!.isEmpty) {
      return 'Email is required !';
    }
    String p =
        "[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(emailValue)) {
      return null;
    } else {
      return 'Email Syntax is not Correct';
    }
  }

  void onTapSingIn() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    print(_email);

    setState(() => _isLoading = true);
    AuthenticationWithEmailAndPassword()
        .signUp(email: _email.toString(), password: _password.toString())
        .then((result) {
      if (result == null) {
        Go.to(context, const SignInScreen());
      }

      setState(() => _isLoading = false);
      // User? user = FirebaseAuth.instance.currentUser;
      // print(user!.uid);
    });
  }
}
