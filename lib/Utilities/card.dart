import 'package:bank_app/Utilities/transaction.dart';
import 'package:flutter/material.dart';

class Details {
  final String logo;
  final String cardNumber;
  final String title;
  final String plan;
  final String name;
  final String email;
  final String password;
  double balance;
  final String id;
  final String bvn;
  final String accountNumber;
  final String phoneNumber;
  final String picture;
  List<Transaction> transactions;

  Details({
    this.picture = 'assets/Ronaldinho.jpg',
    required this.phoneNumber,
    this.accountNumber = '378974639',
    required this.bvn,
    required this.id,
    required this.balance,
    required this.name,
    required this.email,
    required this.password,
    this.logo = 'assets/mastercard.jpg',
    this.cardNumber = ' ••••     ••••     ••••     4536',
    this.title = 'MASTERCARD',
    this.plan = 'PREMIUM',
    required this.transactions,
  });
}

List<Details> customers = [
  Details(
    name: 'Oladokun Tosin',
    id: '1937279',
    accountNumber: '3719630251',
    bvn: '87109626179',
    phoneNumber: '0808858464',
    email: 'ladisea55@gmail.com',
    password: 'Oladisea1234',
    balance: 5000.45,
    logo: "assets/visa.jpg",
    cardNumber: " ••••     ••••     ••••     8287",
    title: "VISA",
    plan: "PLATINUM",
    picture: "assets/cr7.jpg",
    transactions: [], // Add empty transactions list or provide actual transactions
  ),
  Details(
    name: 'Adeife Tobi',
    id: '1773928',
    bvn: '72391873465',
    accountNumber: '3719763827',
    phoneNumber: '07064885761',
    email: 'Tobi54@gmail.com',
    password: 'Adetob1234',
    balance: 340000.56,
    logo: "assets/mastercard.jpg",
    cardNumber: " ••••     ••••     ••••     2304",
    title: "MASTERCARD",
    plan: "PREMIUM",
    picture: "assets/messi.jpg",
    transactions: [], // Add empty transactions list or provide actual transactions
  ),
  Details(
    name: 'Oladokun Tosin',
    id: '12819464',
    accountNumber: '3719238198',
    bvn: '87109626179',
    phoneNumber: '0808858464',
    email: 'ladisea55@gmail.com',
    password: 'Oladisea1',
    balance: 8000.00,
    logo: "assets/visa.jpg",
    cardNumber: " ••••     ••••     ••••     1236",
    title: "VISA",
    plan: "PLATINUM",
    picture: "assets/Mbappe.jpg",
    transactions: [], // Add empty transactions list or provide actual transactions
  ),Details(
    name: 'Oladokun Tosin',
    id: '18064437',
    accountNumber: '3719737251',
    bvn: '87109626179',
    phoneNumber: '0808858464',
    email: 'ladisea54@gmail.com',
    password: 'Oladisea123',
    balance: 5000.45,
    logo: "assets/visa.jpg",
    cardNumber: " ••••     ••••     ••••     0678",
    title: "VISA",
    plan: "PLATINUM",
    picture: 'assets/Hazard.jpg',
    transactions: [], // Add empty transactions list or provide actual transactions
  ),
  Details(
    name: 'Oyetade Emmanuel',
    id: '8831083',
    bvn: '77478198250',
    accountNumber: '3719638628',
    phoneNumber: '07066152585',
    email: 'Emmanuel112@gmail.com',
    password: 'lover1234',
    logo: "assets/paypal.jpg",
    balance: 33435.75,
    cardNumber: " ••••     ••••     ••••     4783",
    title: "PAYPAL",
    plan: "PLATINUM",
    picture: "assets/messi.jpg",
    transactions: [], // Add empty transactions list or provide actual transactions
  ),
];
