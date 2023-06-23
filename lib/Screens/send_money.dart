import 'package:flutter/material.dart';

import '../Utilities/card.dart';
import '../Utilities/transaction.dart';

class SendMoney extends StatefulWidget {
  final String userId;
  final Function(Transaction) onTransferSuccess;

  const SendMoney({required this.userId, required this.onTransferSuccess, Key? key}) : super(key: key);

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  String? userIds;
  TextEditingController recipientController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void _sendMoney() {
    String recipient = recipientController.text;
    String amount = amountController.text;

    // Check if the recipient exists in the customers list
    bool recipientExists = false;
    Details? receiver;
    Details? sender;
    double balance = 0;

    for (Details customer in customers) {
      if (customer.accountNumber == recipient) {
        recipientExists = true;
        receiver = customer;
        break;
      }
    }

    for (Details customer in customers) {
      if (customer.id == userIds) {
        sender = customer;
        balance = sender.balance;
        break;
      }
    }

    if (recipientExists && receiver != null) {
      // Check if the sender has sufficient balance
      if (balance >= double.parse(amount)) {
        // Create a new transaction
        Transaction transaction = Transaction(
          date: DateTime.now().toString(),
          senderId: sender!.id,
          senderName: receiver.name,
          receiverId: receiver.id,
          amount: double.parse(amount),
        );

        // Save the transaction for sender and receiver
        sender.transactions.add(transaction);
        receiver.transactions.add(transaction);

        // Update sender's balance
        sender.balance -= double.parse(amount);

        // Update receiver's balance
        receiver.balance += double.parse(amount);

        // Clear the form fields
        recipientController.clear();
        amountController.clear();

        // Show a success message or perform any desired actions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Money sent to $recipient!')),
        );

        // Invoke the onTransferSuccess callback
        widget.onTransferSuccess(transaction);

        // Navigate back to the previous screen
        Navigator.of(context).pop();
      } else {
        // Handle the case when the sender has insufficient balance
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insufficient balance!')),
        );
      }
    } else {
      // Show an error message if the recipient is not found
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipient not found!')),
      );
    }
  }

  @override
  void dispose() {
    recipientController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Details? user;
    String userId = widget.userId;
    userIds = userId;

    // Find the customer in the list based on the userId
    for (Details customer in customers) {
      if (customer.id == userIds) {
        user = customer;
        break;
      }
    }

    // Check if the user exists
    double? userBalance;
    if (user != null) {
      // Access the user balance
      userBalance = user.balance;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Send Money',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: recipientController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            TextFormField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _sendMoney,
              child: const Text('Send'),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
