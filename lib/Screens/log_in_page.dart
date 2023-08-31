import 'package:bank_app/Screens/sign_up.dart';
import 'package:bank_app/Utilities/colors.dart';
import 'package:bank_app/Utilities/dimensions.dart';
import 'package:email_validator/email_validator.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utilities/card.dart';

class LoginPage extends StatefulWidget {
  final String userId;
  const LoginPage({this.userId='3905060205',Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool hidePassword = true;




  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  String? authenticateUser(String email, String password) {
    String? userId; // Declare userName outside the loop

    // Check if the user exists in the list of customers
    for (Details customer in customers) {
      if (customer.email == email && customer.password == password) {
        userId = customer.id;
        // User found, perform authentication
        break;
      }
    }

    return userId; // Return userName (or null)
  }

  void login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      String? userId = authenticateUser(email, password);

      if (userId != null) {
        // Successful sign-in
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
              (Route<dynamic> route) => false,
          arguments: userId,
        );

      } else {
        // Invalid credentials
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sign in",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white
                  ),),
                  Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Icon(Icons.arrow_downward))
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 1,right: 1,top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.circular(0),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 7,
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ],
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return "Email cannot be empty";
                    } else if (!EmailValidator.validate(value!)) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.deepOrangeAccent,
                    ),
                    enabledBorder: OutlineInputBorder(
                      //borderRadius: BorderRadius.circular(Dimensions.radius30),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder( // Add a white glow when focused
                      //borderRadius: BorderRadius.circular(Dimensions.radius30),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                     // borderRadius: BorderRadius.circular(Dimensions.radius30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height20),
              Container(
                margin: const EdgeInsets.only(left: 1,right: 1,top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                 // borderRadius: BorderRadius.circular(Dimensions.radius30),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 7,
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return "Password cannot be empty";
                    } else if (value!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  obscureText: hidePassword,
                  controller: _passwordController,
                  style: const TextStyle(
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        }, icon: Icon(hidePassword?Icons.visibility_off:Icons.visibility)),
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock_clock_rounded,
                      color: Colors.deepOrangeAccent,
                    ),
                    enabledBorder: OutlineInputBorder(
                      //borderRadius: BorderRadius.circular(Dimensions.radius30),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder( // Add a white glow when focused
                      //borderRadius: BorderRadius.circular(Dimensions.radius30),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      //borderRadius: BorderRadius.circular(Dimensions.radius30),
                    ),
                  ),
                ),
              ),
        const SizedBox(height: 3,),
        Padding(
          padding: const EdgeInsets.only(left: 250),
          child: TextButton(
              onPressed: (){},
              child: Text("Forgot password?",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ),)
          ),
        ),
        GestureDetector(
          onTap:  () {
            if (_formKey.currentState!.validate()) {
              login();
            }
          },

          child: Container(
            margin: EdgeInsets.only(left: 20,top: Dimensions.height10,right: 20),

            padding: EdgeInsets.only(left: 120,top: Dimensions.height10),
            width: w * 0.8,
            height: h * 0.05,
            //color: Colors.red[600],
            decoration: BoxDecoration(
                 color: Colors.red[600],
                 borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Text(
              "Sign in",
              style: TextStyle(
                fontSize: Dimensions.height30,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          )),
      ],
    ),
    );
  }
}
