import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import '../Utilities/card.dart';
import 'log_in_page.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController bvnController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late double amount;
  String customerId = 'UNKNOWN';




  String generateAccountNumber() {
    Random random = Random();
    int accountNumber = random.nextInt(900000000) + 1000000000;
    return accountNumber.toString();
  }


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Validation


      // Retrieve user input
      String firstName = firstNameController.text;
      String lastName = lastNameController.text;
      String dob = dobController.text;
      String bvn = bvnController.text;

      String email = emailController.text;
      String password = passwordController.text;
      String phoneNumber = phoneNumberController.text;


      // Generate Customer ID using flutter_udid
      generateCustomerId().then((customerId) {
        String accountNumber = generateAccountNumber();

        // Resetting form fields
        firstNameController.clear();
        lastNameController.clear();
        dobController.clear();
        bvnController.clear();

        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        phoneNumberController.clear();


        // Creating a new Customer object with the user's information
        Details newCustomer = Details(
          id: customerId,
          name: firstName + lastName,
          bvn: bvn,
          phoneNumber: phoneNumber,
          balance: amount,
          email: email,
          accountNumber: accountNumber,
          password: password,
          transactions: [],
        );

        // Adding the new customer to the customers list
        customers.add(newCustomer);

        // Showing success message or navigate to the next screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful!')),
        );
        // Navigate to the login page with the user ID
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage(userId: customerId)),
          );});
      }).catchError((error) {
        print('Failed to generate customer ID: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to generate customer ID')),
        );
      });
    }
  }

  Future<String> generateCustomerId() async {
    String _udid;
    try {
      _udid = (await FlutterUdid.consistentUdid).toString();
    } catch (e) {
      print('Failed to generate customers ID: $e');
      rethrow;
    }
    customerId = _udid;
    return customerId.substring(0,8);
  }


  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    bvnController.dispose();

    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Account Signup'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
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
                    controller: firstNameController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                        labelText: 'First Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
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
                    controller: lastNameController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                        labelText: 'Last Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
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
                    controller: dobController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.calendar_view_day_rounded),
                        border: InputBorder.none,
                        labelText: 'Date of Birth'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
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
                    controller: bvnController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.ac_unit_rounded),
                        border: InputBorder.none,
                        labelText: 'BVN'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your BVN';
                      }
                      else if(value.length < 11 || value.length >11){
                        return 'Must be 11 digits';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
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
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        border: InputBorder.none,
                        labelText: 'Phone Number'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Phone Number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
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
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      border: InputBorder.none,
                      labelText: 'Amount to Deposit'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the amount to deposit';
                    }

                    try {
                      amount =double.parse(value);
                    } catch (e) {
                      return 'Invalid amount';
                    }
                    return null;
                  },
                ),
              ),
                const SizedBox(height: 20,),

                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
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
                    controller: emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password_sharp),
                        border: InputBorder.none,
                        labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
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
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.password_sharp),
                        labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
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
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.password_sharp)
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 26.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Create Account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
