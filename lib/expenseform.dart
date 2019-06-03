import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  TextEditingController txtexpenseaccount = TextEditingController();
  TextEditingController txtdescription = TextEditingController();
  TextEditingController txtamount = TextEditingController();

  void post() {
    var url = "http://www.reddiamond.co.ke/expenses.php";
    http.post(url, body: {
      "ExpenseAccount": txtexpenseaccount.text,
      "Description": txtdescription.text,
      "Amount": txtamount.text,
      "Date": _dateText,
      "Paymentmethod": _payment
    });
  }

  List<String> payment = ["Cash", "Mobile Pay", "Credit Card"];
  String _payment = "Cash";

  void selectPayment(String value) {
    setState(() {
      _payment = value;
    });
  }

  DateTime _date = DateTime.now();
  String _dateText = "";

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2018),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _date = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _dateText = "${_date.day}/${_date.month}/${_date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(FontAwesomeIcons.database),
        title: Text(
          'My Expenses',
          style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              letterSpacing: 3.0,
              fontFamily: 'Pacifico'),
        ),
        backgroundColor: Colors.purple[400],
        elevation: 20.0,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: txtexpenseaccount,
                  decoration: InputDecoration(
                    hintText: "expense account",
                    labelText: "Expense Account",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: txtdescription,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Description",
                      labelText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.date_range),
                      ),
                      Expanded(
                        child: Text(
                          'Select Date',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Pacifico",
                              color: Colors.black54),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text(
                          _dateText,
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        " Payment Method ",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Pacifico',
                            color: Colors.teal),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40.0),
                      ),
                      DropdownButton(
                        onChanged: (String value) {
                          selectPayment(value);
                        },
                        value: _payment,
                        items: payment.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: TextField(
                    controller: txtamount,
                    decoration: InputDecoration(
                      hintText: "Amount",
                      labelText: "Amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    height: 50.0,
                    width: 100.0,
                    child: RaisedButton(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      shape: StadiumBorder(),
                      color: Colors.purple[400],
                      textColor: Colors.white,
                      elevation: 6.0,
                      onPressed: () {
                        txtexpenseaccount.clear();
                        txtdescription.clear();
                        txtamount.clear();
                        post();

                        Fluttertoast.showToast(
                            timeInSecForIos: 2,
                            msg: 'Data Saved Successfully',
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_SHORT,
                            textColor: Colors.grey,
                            backgroundColor: Colors.transparent);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Colors.brown,
        child: Container(
          height: 30.0,
          child: Text("Powered by GsmDev.",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontFamily: "Pacifico",
              ),
              textAlign: TextAlign.right),
        ),
      ),
    );
  }
}
