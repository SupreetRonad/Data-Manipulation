import 'package:banking_app/transferMoney.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Customer extends StatefulWidget {
  final ref;
  const Customer(this.ref);

  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  bool loading = true;
  List<Map> user;
  void getData() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'banking.db';

    var database = await openDatabase(
      path,
      version: 1,
    );
    user = await database.rawQuery(
        'SELECT * FROM Users WHERE Phone_no == ${widget.ref['Phone_no']}');
    print(user[0]['User_Name']);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      getData();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Customer Info',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black87
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    user[0]['User_Name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 17,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        user[0]['Email'],
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 17,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        user[0]['Phone_no'],
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 17,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        user[0]['DOB'].toString(),
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Balance :",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Rs. " + user[0]['Balance'].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shadowColor: Colors.blue[300],
                          padding: EdgeInsets.all(13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return TransferMoney(user[0]);
                              });
                        },
                        child: Container(
                          width: 140,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Transfer Money'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
