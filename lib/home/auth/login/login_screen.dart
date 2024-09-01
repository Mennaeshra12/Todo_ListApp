import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/app_colors.dart';
import 'package:todo_test/dialog_utlis.dart';
import 'package:todo_test/firebase_utils.dart';
import 'package:todo_test/home/auth/customer_text_form_field.dart';
import 'package:todo_test/home/auth/register/register_screen.dart';
import 'package:todo_test/home/homescreen.dart';
import 'package:todo_test/providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(text: 'menna@route.com');
  TextEditingController passwordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Welcome Back!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomerTextFormField(
                    label: 'Email',
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter Email';
                      }
                      final bool emailValid = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(text);
                      if (!emailValid) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomerTextFormField(
                    label: 'Password',
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter Password';
                      }
                      if (text.length < 6) {
                        return 'Password must be at least 6 characters.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        login(context);
                      },
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RegisterScreen.routeName);
                      },
                      child: Text(
                        "Or Create Account",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      DialogUtlis.showLoading(context: context, loadingLabel: 'Waiting ...', barrierDismissible: false);
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = await FirebaseUtils.readUserFromFireStore(credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var userProvider = Provider.of<UserProvider>(context,listen:false );
        userProvider.updateUser(user);
        DialogUtlis.hideLoading(context);
        DialogUtlis.showMessage(
          context: context,
          message: 'Login Successfully',
          title: 'Success',
          posActionName: 'OK',
          posAction: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          },
        );
      } on FirebaseAuthException catch (e) {
        DialogUtlis.hideLoading(context);
        if (e.code == 'wrong-password' || e.code == 'user-not-found') {
          DialogUtlis.showMessage(
            context: context,
            message: 'Invalid email or password. Please try again.',
            title: 'Error',
            posActionName: 'OK',
          );
        } else {
          DialogUtlis.showMessage(
            context: context,
            message: e.message ?? 'An unknown error occurred.',
            title: 'Error',
            posActionName: 'OK',
          );
        }
      } catch (e) {
        DialogUtlis.hideLoading(context);
        DialogUtlis.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
          posActionName: 'OK',
        );
      }
    }
  }
}
