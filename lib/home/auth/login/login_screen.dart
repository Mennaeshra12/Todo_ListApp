import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_test/app_colors.dart';
import 'package:todo_test/home/auth/customer_text_form_field.dart';
import 'package:todo_test/home/auth/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
 static const String routeName = 'login_screen';
 TextEditingController emailController =  TextEditingController(text: 'menna@route.com');
 TextEditingController passwordController =  TextEditingController(text: '123456');
 var formKey = GlobalKey<FormState>() ;
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
                child:Column(
                  crossAxisAlignment:  CrossAxisAlignment.stretch,
              children: [
               const Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Welcome Back!' ,
                  textAlign: TextAlign.center ,
                  ),
                ) ,

                CustomerTextFormField(label: 'Email',
                controller: emailController,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter Email' ;
                    }
                    final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-za-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
                    if(!emailValid){
                      return 'Please enter Valid Email' ;
                    }
                     return null ;
                  },
                  keyboardType:  TextInputType.emailAddress,
                ),
                CustomerTextFormField(label: 'Password',
                controller: passwordController,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter Password' ;
                    }
                    if(text.length < 6){
                      return 'Password must be at least 6  chars. ' ;

                    }
                    return null ;
                  },
                  keyboardType: TextInputType.number,
                  obscureText: true,
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                      onPressed : (){
                       login();
                  },
                      child: Text("Login",
                      style: Theme.of(context).textTheme.bodyLarge,
                  )),

                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                      onPressed : (){
                        Navigator.of(context).pushNamed(RegisterScreen.routeName) ;

                      },
                      child: Text("Or Create Account ",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color:  AppColors.primaryColor ,
                          fontSize:  20
                        ),
                      )),

                ),

              ],
            ) )
          ],
        ),
      ),
    );
  }

  void login() async {
    if(formKey.currentState?.validate() == true){
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        print(credential.user?.uid??"") ;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          print('The supplied auth credential is incorrect , malformed or has expired');
        }
      }
      catch(e){
        print(e.toString());
      }
    }
  }
}
