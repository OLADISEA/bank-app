import 'package:bank_app/Utilities/dimensions.dart';
import 'package:flutter/material.dart';

import '../Utilities/card.dart';

class AccountUpdatePage extends StatefulWidget {
  final String userId;
  final Function(Details) onUpdateSuccess;

  AccountUpdatePage({super.key, required this.onUpdateSuccess, required this.userId});

  @override
  _AccountUpdatePageState createState() => _AccountUpdatePageState();
}

class _AccountUpdatePageState extends State<AccountUpdatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _password;
  double? balance;
  String? id;
  String? bvn;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    // Fetch the customer details using the userId and populate the form fields
    fetchCustomerDetails(widget.userId).then((customer) {
      setState(() {
        _name = customer.name;
        _email = customer.email;
        _password = customer.password;
        balance = customer.balance;
        phoneNumber = customer.phoneNumber;
        bvn = customer.bvn;
      });
    }).catchError((error) {
      print('Failed to fetch customer details: $error');
      // Handle the error condition if required
    });
  }

  void _updateAccount() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Assign the initial values if the respective text fields are empty
      if (_name!.isEmpty) {
        _name = customers.firstWhere((customer) => customer.id == widget.userId).name;
      }
      if (_email!.isEmpty) {
        _email = customers.firstWhere((customer) => customer.id == widget.userId).email;
      }
      if (_password!.isEmpty) {
        _password = customers.firstWhere((customer) => customer.id == widget.userId).password;
      }
      if (phoneNumber!.isEmpty) {
        phoneNumber = customers.firstWhere((customer) => customer.id == widget.userId).phoneNumber;
      }

      // Use the widget.userId to identify the customer
      Details updatedCustomer = Details(
        id: widget.userId,
        balance: balance!,
        phoneNumber: phoneNumber!,
        bvn: bvn!,
        name: _name!,
        email: _email!,
        password: _password!,
        transactions: [],
      );

      // Call the onUpdateSuccess callback with the updated customer details
      widget.onUpdateSuccess(updatedCustomer);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account updated successfully!')),
      );
      // Navigate to the home page after updating the account
      Navigator.of(context).pop();
    }
  }

  Future<Details> fetchCustomerDetails(String userId) {
    // Simulating the fetch operation using a delayed future
    return Future.delayed(const Duration(seconds: 2), () {
      // Replace this with your logic to retrieve customer details based on the userId
      // Return the customer object or throw an error if not found
      Details customer = customers.firstWhere((customer) => customer.id == userId,
          orElse: () => throw Exception('Customer not found'));
      return customer;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Create text editing controllers and initialize their values
    TextEditingController nameController = TextEditingController(text: _name);
    TextEditingController emailController = TextEditingController(text: _email);
    TextEditingController passwordController = TextEditingController(text: _password);
    TextEditingController phoneNumberController = TextEditingController(text: phoneNumber);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Update'),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.height16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 25),
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
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none, // Remove underline
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              Container(
                padding: const EdgeInsets.only(left: 25),
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
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: InputBorder.none, // Remove underline
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }

                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              Container(
                padding: const EdgeInsets.only(left: 25),
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
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.password_sharp),
                    border: InputBorder.none, // Remove underline
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              Container(
                padding: const EdgeInsets.only(left: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 7,
                      blurRadius: Dimensions.height10,
                      offset: const Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_android),
                    border: InputBorder.none, // Remove underline
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone Number';
                    }
                    return null;
                  },
                  onSaved: (value) => phoneNumber = value!,
                ),
              ),
              SizedBox(height: Dimensions.height16),
              ElevatedButton(
                onPressed: _updateAccount,
                child: const Text('Update Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
