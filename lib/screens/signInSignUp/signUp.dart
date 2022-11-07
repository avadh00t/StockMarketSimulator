import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_simulator/screens/signInSignUp/signIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  final passWordControllerChecker = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded)),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 30,
              top: 80,
            ),
            child: Text(
              'Sign Up!\nCreate your Account',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 300,
                right: 30,
                left: 30,
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
                  TextField(
                    controller: passWordControllerChecker,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffff9d0828),
                      hintText: 'ReEnter Password',
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
                        if(emailController.text.isEmpty || passWordController.text.isEmpty || passWordControllerChecker.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter all Fields')));
                          setState(() {
                            isLoading = false;
                          });
                        }
                        if(passWordController.text != passWordControllerChecker.text) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password\'s do not match')));
                          setState(() {
                            isLoading = false;
                          });
                        }
                       try {
                         await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passWordController.text.trim()).then((value) {
                           FirebaseFirestore.instance.collection(value.user!.email.toString()).doc('Funds').set({"Initial funds" : 500000});
                         });
                         setState(() {
                           isLoading = false;
                         });
                         Navigator.of(context).pop(MaterialPageRoute(builder: (context) => SignIn()));
                       }
                        catch(e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                        finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Have An Account? '),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pop(MaterialPageRoute(builder: (context) => SignIn()));
                          },
                          child: Text('SignIn')
                      ),
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
