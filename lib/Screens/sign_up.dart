import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import '../Utilities/card.dart';
import '../Utilities/dimensions.dart';
import 'log_in_page.dart';
import 'package:intl/intl.dart'; // For date formatting



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
  final List<String> gender = ['Select','Male','Female'];
  String userGender = '';
  late double amount;
  String customerId = 'UNKNOWN';
  DateTime? selectedDate; // Holds the selected date

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the initial date
      firstDate: DateTime(1900), // Set the earliest selectable date
      lastDate: DateTime.now(), // Set the latest selectable date
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate!).toString();
        //dobController.text = selectedDate;
      });
    }
  }

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
        print(accountNumber);

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
          const SnackBar(content: Text('Signup successful! Please log in')),
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
    //Function to generate customer's ID
    String id;
    try {
      id = (await FlutterUdid.consistentUdid).toString();
    } catch (e) {
      print('Failed to generate customers ID: $e');
      rethrow;
    }
    customerId = id;
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
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                SizedBox(height: Dimensions.height20),
                Container(
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                    readOnly: true, // Prevent direct editing of the field
                    onTap: () {
                      _selectDate();
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Date of Birth',
                      hintText:  selectedDate != null? dobController.text
                          : 'Select Date',
                    ),
                  )

                ),
                SizedBox(height: Dimensions.height20),

                Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 30,right: 20,top: 20),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    boxShadow: [
                    BoxShadow(
                    spreadRadius: 7,
                    blurRadius: 10,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.2),
                  )]
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    validator: (val){
                      if(val=='Select'){
                        return 'Choose a gender';
                      }
                    },
                    value: userGender.isNotEmpty ? userGender : 'Select', // Use a unique value for initial selection
                    items: gender.map((String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        userGender = value!;
                      });
                    },
                  ),
                ),



                SizedBox(height: Dimensions.height20),

                Container(
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                SizedBox(height: Dimensions.height20,),
                Container(
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                SizedBox(height: Dimensions.height20,),
                Container(
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                SizedBox(height: Dimensions.height20),

                Container(
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                        prefixIcon: Icon(Icons.email_rounded),
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
                SizedBox(height: Dimensions.height20,),
                Container(
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                        prefixIcon: Icon(Icons.lock_clock_outlined),
                        labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }else if(value.length < 6){
                        return 'password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                Container(
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                        prefixIcon: Icon(Icons.lock)
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
                const SizedBox(height: 25.0),
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
