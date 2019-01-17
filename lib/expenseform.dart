import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  TextEditingController txtexpenseaccount = new TextEditingController();
  TextEditingController txtdescription = new TextEditingController();

  TextEditingController txtamount = new TextEditingController();

  void post() {
    var url = "enter your website here";

    http.post(url, body: {
      "expenseaccount": txtexpenseaccount.text,
      "Description": txtdescription.text,
      "Amount": txtamount.text,
      "date": _dateText,
      "paymentmethod": _payment
    });
  }

  List<String> payment = ["Cash", "Mpesa", "Visa Card"];
  String _payment = "Cash";

  void selectPayment(String value) {
    setState(() {
      _payment = value;
    });
  }

  DateTime _date = new DateTime.now();
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
    return new Scaffold(
      appBar: new AppBar(
        leading: Icon(Icons.fastfood),
        title: Text(
          'My Expenses',
          style: new TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              letterSpacing: 3.0,
              fontFamily: 'Pacifico'),
        ),
        backgroundColor: Colors.purple[400],
        elevation: 20.0,
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
              padding: new EdgeInsets.all(16.0),
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: txtexpenseaccount,
                    decoration: InputDecoration(
                        hintText: "expense account",
                        labelText: "Expense Account",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: new TextField(
                      controller: txtdescription,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Description",
                          labelText: "Description",
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(20.0))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: new Icon(Icons.date_range),
                        ),
                        new Expanded(
                          child: new Text(
                            'Select Date',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Pacifico",
                                color: Colors.black54),
                          ),
                        ),
                        new FlatButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: new Text(
                            _dateText,
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: new Row(
                      children: <Widget>[
                        new Text(
                          " Payment Method ",
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Pacifico',
                              color: Colors.teal),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(left: 40.0),
                        ),
                        new DropdownButton(
                          onChanged: (String value) {
                            selectPayment(value);
                          },
                          value: _payment,
                          items: payment.map((String value) {
                            return new DropdownMenuItem(
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
                    child: new TextField(
                      controller: txtamount,
                      decoration: InputDecoration(
                          hintText: "Amount",
                          labelText: "Amount",
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(20.0))),
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
                              msg: 'Data Saved Successfully',
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_SHORT,
                              textColor: Colors.grey,
                              backgroundColor: Colors.transparent
                              // bgcolor: '#FFFFFF',
                              // textcolor: '#333333'
                              );
                        },
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomAppBar(
        elevation: 0.0,
        color: Colors.brown,
        child: Container(
          height: 28.0,
          child: Text("Powered by GsmDev.",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontFamily: "Pacifico",
              ),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
