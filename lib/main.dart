import 'package:expenses/expenseform.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "expenses",
      home: ExpenseForm(),
    ),
  );
}
