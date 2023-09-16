import 'package:bank_app/Utilities/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:bank_app/Utilities/transaction.dart';

class Transactions extends StatelessWidget {
  final List<Transaction> transactions;

  const Transactions({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Transactions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: Dimensions.height10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            final isReceived = transaction.type == TransactionType.receive;
            final sign = isReceived ? '+' : '-';
            final color = isReceived ? Colors.green : Colors.red;

            return ListTile(
              leading: CircleAvatar(
                child: Text(transaction.senderName[0]),
              ),
              title: Text(transaction.senderName),
              subtitle: Text(transaction.description),
              trailing: Text(
                '$sign\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
