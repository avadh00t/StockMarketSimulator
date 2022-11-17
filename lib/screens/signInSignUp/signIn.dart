import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_simulator/screens/mainPage/mainPageBackground/main_page_background.dart';
import 'package:stock_market_simulator/screens/signInSignUp/signUp.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 30,
              top: 200,
            ),
            child: Text(
              'Sign In!\nWelcome User.',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.5,
                left: 30,
                right: 30
              ),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffff9d0828),
                      hintText: 'Enter Email',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextField(
                    controller: passWordController,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffff9d0828),
                      hintText: 'Enter Password',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  isLoading? CircularProgressIndicator() : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if(emailController.text.isEmpty || passWordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter all fields')));
                          setState(() {
                            isLoading = false;
                          });
                        }
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passWordController.text.trim());
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPageBackground()));
                        } catch(e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont Have Account? '),
                      TextButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
                      }, child: Text('SignUp'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
