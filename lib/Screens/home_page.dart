import 'package:bank_app/Screens/send_money.dart';
import 'package:bank_app/Screens/update_account.dart';
import 'package:bank_app/Screens/view_transactions.dart';
import 'package:bank_app/Utilities/card.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../Utilities/colors.dart';
import '../Utilities/dimensions.dart';
import '../Utilities/transaction.dart';
import '../Widgets/big_text.dart';
import '../Widgets/small_text.dart';
import 'log_in_page.dart';

class HomePage extends StatefulWidget {
  final String userId;
  const HomePage({this.userId = '', Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currentValue = 0.0;
  double scaleFactor = 0.8;
  double height = Dimensions.firstContainer;
  List images = [];
  double? userBalance;
  String? userName;
  String? userIds;
  Details? user;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentValue = pageController.page!;
      });
    });
    for (var customer in customers) {
      if (customer.id == widget.userId) {
        setState(() {
          user = customer;
        });
        break;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void handleUpdateSuccess(Details updatedCustomer) {
    setState(() {
      // Find the customer in the customers list using the userId
      int index =
      customers.indexWhere((customer) => customer.id == updatedCustomer.id);
      if (index != -1) {
        // Updating the customer details with the updatedCustomer
        customers[index] = updatedCustomer;
      }
    });
  }

  void _updateUserBalance(Transaction transaction) {
    setState(() {
      // Finding the sender and receiver in the customers list
      Details? sender;
      Details? receiver;

      for (Details customer in customers) {
        if (customer.id == transaction.senderId) {
          sender = customer;
        }
        if (customer.id == transaction.receiverId) {
          receiver = customer;
        }
      }

      // Update the sender's balance
      if (sender != null) {
        sender.balance -= transaction.amount;
      }

      // Update the receiver's balance
      if (receiver != null) {
        receiver.balance += transaction.amount;
      }
    });
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Account Deletion'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteAccount(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount(BuildContext context) {
    try {
      // Locate the customer using the userId and remove the customer information
      Details? customer;
      customers.firstWhere((customer) => customer.id == userIds);
      customers.remove(customer);
      //print(userIds);

      // Navigate back to the login page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      //print(userIds);

      print('Failed to delete account: $e');
      // Handle the error condition if required
    }
  }
  void onTransferSuccess(Transaction transaction) {
    setState(() {
      _updateUserBalance;
      transactions.add(transaction);
    });
  }

  void _navigateToSendMoney() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SendMoney(
          userId: userIds!,
          onTransferSuccess: onTransferSuccess,
        ),
      ),
    );
  }








  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed from the login page
    final args = ModalRoute.of(context)?.settings.arguments as String?;

    // Extract the username from the arguments
    var userId = args ?? "Guest"; // Set a default value if arguments are null
    print(userId);
    // Find the customer in the list based on the username
    Details? user;
    for (var customer in customers) {
      if (customer.id == userId) {
        userIds = userId;
        userName = customer.name;
        print('this $userIds');
        user = customer;
        break;
      }
    }

    // Check if the user exists
    if (user != null) {
      // Access the user balance
      userBalance = user.balance;
      userName = user.name;


    } else {
      // Handle the case when the user is not found
      print('User not found');
    }

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      //backgroundColor: Colors.white,
      appBar: AppBar(
          actions: [
            PopupMenuButton(itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log Out'),
                  onTap: () {
                    // Navigate to the shopping screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                ),
              )
            ],
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: userName!,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BigText(
                      text: 'Account Balance: $userBalance',
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    'assets/cr7.jpg',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return _buildPageItem(index);
                  }),
            ),
            DotsIndicator(
              dotsCount: 2,
              position: currentValue.floor(),
              decorator: DotsDecorator(
                activeColor: AppColors.iconColor2,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            // Others

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _navigateToSendMoney,
                  child: Container(
                    width: 120,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Send Money',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountUpdatePage(
                            userId: userId,
                            onUpdateSuccess: handleUpdateSuccess,
                          ),
                        ));
                  },
                  child: Container(
                    width: 120,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Update Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                  ),
                  onPressed: () {
                    print(userIds);
                    _confirmDeleteAccount(context);
                  },
                  child: Container(
                    width: 120,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Delete Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            //TRANSACTIONS

            Transactions(transactions: transactions),
          ],
        ),
      ),
    );
  }



Widget _buildPageItem(int position) {
    Matrix4 matrix4 = Matrix4.identity();
    if (position == currentValue.floor()) {
      var currScale = 1 - (currentValue - position) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (position == currentValue.floor() + 1) {
      var currScale = scaleFactor + (currentValue - position + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (position == currentValue.floor() - 1) {
      var currScale = 1 - (currentValue - position) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          Container(
            height: 250,
            margin: EdgeInsets.only(left: Dimensions.small, right: Dimensions.small),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.sized),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          BigText(text: 'UI Bank'),
                          SizedBox(width: 280,),
                          SizedBox(width: 8),  // Add a SizedBox for spacing
                          Icon(Icons.toggle_off_outlined),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  const BigText(text: '**** **** **** 3987'),
                  const SizedBox(height: 50,),
                  Row(
                    children: const [
                      SmallText(text: 'card holder name'),
                      SizedBox(width: 70,),
                      SmallText(text: 'Expiry Date'),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children:  [
                      BigText(text: userName!),
                      const SizedBox(width: 33,),
                      const BigText(text: '02/23'),
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
