import 'package:bank_app/Screens/log_in_page.dart';
import 'package:bank_app/Screens/sign_up.dart';
import 'package:bank_app/Screens/view_more.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utilities/dimensions.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedCountry = 'Nigeria';
  final List<String> countries = [
    'Benin', 'Burkina Faso', 'Cameroon', 'Chad', 'Congo Brazzaville',
    'Congo DRC', 'Cote d\'lvoire', 'Gabon', 'Ghana', 'Guinea', 'Kenya',
    'Liberia', 'Mali', 'Mozambique', 'Nigeria', 'Senegal', 'Sierra Leone',
    'Tanzania', 'Uganda', 'Zambia'
  ];

  @override
  Widget build(BuildContext context) {
    double h= MediaQuery.of(context).size.height;
    double w= MediaQuery.of(context).size.width;

    void showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: const LoginPage(),
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Container(
          margin: const EdgeInsets.only(top: 15,left: 2),
          height: h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
                fit: BoxFit.contain,
                image: AssetImage("assets/sign_in.png")),
            color: Colors.grey,
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 250,left: 25,top: 2),
                    child: DropdownButton(
                      value: selectedCountry,
                      items: countries.map((country) {
                        return DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCountry = value as String;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => const ViewMore()),
                      );
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              Positioned(
                bottom: 270,
                left: 80,
                child: Container(
                  width: 350, // Add width constraint
                  child: ElevatedButton(
                    onPressed: () {
                      return showSettingsPanel();
                    },
                    child: const Text('Sign in'),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                //right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(left: 5,top: 3),
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(Dimensions.radius30)
                        ),
                        margin: const EdgeInsets.only(top: 70,left: 10),
                        child: const Text('Open an Account',
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.white
                          ),),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => const SignUp()),
                      child: Container(
                        padding: const EdgeInsets.only(left: 5,top: 3),
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(Dimensions.radius30)
                        ),
                        margin: const EdgeInsets.only(top: 70,left: 200),
                        child: const Text('Sign up',
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.white
                          ),),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
