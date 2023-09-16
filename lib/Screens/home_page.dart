import 'package:bank_app/Screens/home_view.dart';
import 'package:bank_app/Screens/send_money.dart';
import 'package:bank_app/Screens/update_account.dart';
import 'package:bank_app/Screens/view_transactions.dart';
import 'package:bank_app/Utilities/card.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/services.dart';
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
  String? userCardNum;
  String? userAccountNum;
  String? userPicture;
  String? userIds;
  Details? user;
  List manyAccounts = [];
  String? userBVN;
  int count = 0;



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

  void _copyAccountNumber() {
    Clipboard.setData(ClipboardData(text: userAccountNum));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account number copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }








  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed from the login page
    final args = ModalRoute.of(context)?.settings.arguments as String?;

    // Extract the username from the arguments
    var userId = args ?? "Guest"; // Set a default value if arguments are null;
    // Find the customer in the list based on the username
    Details? user;
    for (var customer in customers) {
      if (customer.id == userId) {
        userIds = userId;
        userName = customer.name;
        user = customer;


      }

    }

    // Check if the user exists
    if (user != null) {
      // Access the user balance
      userBalance = user.balance;
      userName = user.name;
      userCardNum = user.cardNumber;
      userAccountNum = user.accountNumber;
      userBVN = user.bvn;
      userPicture = user.picture;


    } else {
      // Handle the case when the user is not found
      print('User not found');
    }

    // Add the current user as the first customer in the list
    manyAccounts.insert(0, user?.cardNumber);

// Add other customers with the same BVN to the list
    for (var customer in customers) {
      if (customer.bvn == userBVN && customer.id != userIds) {
        manyAccounts.add(customer.cardNumber);
      }
    }








    count = customers.where((customer) => customer.bvn == userBVN).length;

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
          title: const Text('UI Banking App',style:
            TextStyle(
              color: Colors.black
            ),),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => const HomeView()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.content_copy),
              onPressed: _copyAccountNumber,
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: Dimensions.height16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.height16,top: Dimensions.height30,bottom: Dimensions.height16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: userName!,
                          size: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        BigText(
                          text: 'Account Balance: \$$userBalance',
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                      userPicture!,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.pageViewHome,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return bankCard(index,index);
                  }),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DotsIndicator(
                dotsCount: count,
                position: currentValue.floor(),
                decorator: DotsDecorator(
                  activeColor: AppColors.iconColor2,
                  size:  Size.square(Dimensions.height10),
                  activeSize: Size(Dimensions.height20, Dimensions.height10),
                  activeShape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height30,
            ),

            // Others

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _navigateToSendMoney,
                  child: Container(
                    width: Dimensions.elevated120,
                    height: Dimensions.height80,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(Dimensions.height10),
                    ),
                    child: Center(
                      child: Text(
                        'Send Money',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.height16,
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
                    width: Dimensions.elevated120,
                    height: Dimensions.height80,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(Dimensions.height10),
                    ),
                    child: Center(
                      child: Text(
                        'Update Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.height16,
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
                    _confirmDeleteAccount(context);
                  },
                  child: Container(
                    width: Dimensions.elevated120,
                    height: Dimensions.height80,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(Dimensions.height10),
                      boxShadow: [
                      BoxShadow(
                      spreadRadius: 7,
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                      color: Colors.redAccent.withOpacity(0.2),
                    )],
                    ),
                    child: Center(
                      child: Text(
                        'Delete Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.height16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.height45,
            ),
            //TRANSACTIONS

            Transactions(transactions: transactions),
          ],
        ),
      ),
    );
  }



Widget bankCard(int position, int accountIndex) {
  String? cardNum = manyAccounts[accountIndex];
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
            height: Dimensions.elevated250,
            margin: EdgeInsets.only(left: Dimensions.small, right: Dimensions.small),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/card.png'),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(Dimensions.sized),
              //color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.height10, top: Dimensions.height10, right: Dimensions.height10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const BigText(text: 'UI Bank',fontWeight: FontWeight.bold,color: Colors.white,),
                          SizedBox(width: Dimensions.elevated180,),
                          //const SizedBox(width: 8),  // Add a SizedBox for spacing
                          Container(
                            padding: EdgeInsets.only(right: Dimensions.height10),
                            height: Dimensions.height45,
                            width: Dimensions.elevated120,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit.cover,

                                  image: AssetImage('assets/matercard.jpg')
                                )
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height60,),
                  BigText(text: '••••     ••••     ••••    ${cardNum?.substring(cardNum.length-4)}',
                    size: Dimensions.height45,),
                  SizedBox(height: Dimensions.height30,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.height16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        SizedBox(
                            width: Dimensions.pageView140,
                            child: BigText(text: userName!,size: Dimensions.height20,)),

                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.height20),
                          child: const BigText(text: '02/23'),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.height16,right: Dimensions.height16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        SmallText(text: 'Card Holder Name',size: Dimensions.height16,),
                        const SmallText(text: 'Expiry Date'),

                      ],
                    ),
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
