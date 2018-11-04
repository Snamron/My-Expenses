import 'package:flutter/material.dart';
import './expenseform.dart';

void main() {
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "expenses",
      home: ExpenseForm(),
    ),
  );
}
