import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_test/home/auth/customer_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
 static const String routeName = 'register_screen';
 TextEditingController nameController =  TextEditingController(text: 'menna');
 TextEditingController emailController =  TextEditingController(text: 'menna@route.com');
 TextEditingController passwordController =  TextEditingController(text: '123456');
 TextEditingController confirmPasswordController =  TextEditingController(text: '123456');
 var formKey = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
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
                CustomerTextFormField(label: 'User Name' ,
                controller: nameController,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter user name' ;
                    }
                    return null ;
                  },
                ),
                CustomerTextFormField(label: 'Email',
                controller: emailController,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter Email' ;
                    }
                    final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+").hasMatch(text) ;
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
                CustomerTextFormField(label: 'Confirm Password',
                controller: confirmPasswordController,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter Confirm Password' ;
                    }
                    if(text.length < 6){
                      return 'Password must be at least 6  chars. ' ;

                    }
                    if(passwordController.text !=  confirmPasswordController.text){
                      return "Confirm Password doesn't match Password " ;

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
                       register();
                  },
                      child: Text("Creat Account",
                      style: Theme.of(context).textTheme.bodyLarge,
                  )),
                )

              ],
            ) )
          ],
        ),
      ),
    );
  }

  void register() async {
    if(formKey.currentState?.validate() == true){
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print(credential.user?.uid??"");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
