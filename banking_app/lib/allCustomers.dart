import 'package:banking_app/main.dart';
import 'package:flutter/material.dart';

class AllCustomers extends StatefulWidget {
  @override
  _AllCustomersState createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Customers'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          var user = MyHomePage.list[index];
          return Card(
            child: Column(
              children: [
                Text(
                  user['User_Name'],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showInfo(user);
                      },
                      child: Text('View Info'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _transferMoney(user);
                      },
                      child: Text('Transfer Money'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showInfo(user) {
    showDialog(
      context: context,
      builder: (builder) {
        return Dialog(
          child: Column(
            children: [
              Text(user['User_Name']),
              Text(user['Email']),
              Text(user['Phone_no']),
              Text(user['Balance'].toString()),
            ],
          ),
        );
      },
    );
  }

  void _transferMoney(user) {
    showDialog(
      context: context,
      builder: (builder) {
        var amount = 0.0;
        return Dialog(
          child: Column(
            children: [
              Text(
                'Tranfer money',
              ),
              Text(
                user['User_Name'],
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  setState(() {
                    amount = double.parse(val);
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (builder) {
                      return Dialog(
                        child: Column(
                          children: [
                            ElevatedButton(
                              child: Text("Confirm"),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {

                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('Transfer'),
              )
            ],
          ),
        );
      },
    );
  }
}
