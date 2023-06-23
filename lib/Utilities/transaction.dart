import 'package:flutter/material.dart';

class Transaction {
  final String description;
  final String date;
  final double amount;
  final String senderName;
  final String receiverId;
  final String senderId;


  Transaction({required this.senderId,required this.receiverId,required this.senderName, this.description = 'Transfer', required this.date, required this.amount});
}
List<Transaction> transactions = [
  Transaction(senderId: '',receiverId: '',senderName:'Tosin',description: 'School Fees', date: '7 jun 2023', amount: 5000.00),
  Transaction(senderId: '',receiverId: '',senderName:'Olamide',description: 'Vehicle purchase', date: '6 july,2023', amount: 34500.00),
  Transaction(senderId: '',receiverId: '',senderName:'Isaac',description: 'Lesson', date: '7 jun,2023', amount: 1200.00),
  Transaction(senderId: '',receiverId: '',senderName:'Emmanuel',description: 'Vehicle purchase', date: '6 july,2023', amount: 34500.00),
  Transaction(senderId: '',receiverId: '',senderName:'Ezekiel',description: 'Vehicle purchase', date: '6 july,2023', amount: 34500.00),




];