import 'package:flutter/material.dart';
import 'package:bank_app/Utilities/transaction.dart';


class Transactions extends StatelessWidget {
  final List<Transaction> transactions;

  const Transactions({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Transactions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(transaction.senderName[0]),
              ),
              title: Text(transaction.senderName),
              subtitle: Text(transaction.description),
              trailing: Text('\$${transaction.amount.toStringAsFixed(2)}'),
            );
          },
        ),
      ],
    );
  }
}
