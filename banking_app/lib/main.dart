import 'package:banking_app/allCustomers.dart';
import 'package:banking_app/allTransactions.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'The Banking App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});
  static List<Map> list;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void dbase() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'banking.db';

    // await deleteDatabase(path);

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        db.execute(
          '''
          CREATE TABLE Users(          
            User_Name varchar(24),
            Email varchar(24),
            Phone_no character(13),
            Gender character(1),
            DOB varchar(24),
            Balance double
          );

          ''',
        );

        db.execute(
          '''
          CREATE TABLE Transactions(  
            Tr_id int auto_increment,        
            Sender varchar(24),
            Recipient varchar(24),
            Date1 varchar(24),
            Date2 varchar(24),
            Amount double,
            SenderB double,
            RecipientB double,
            PRIMARY KEY (Tr_id)
          );

          ''',
        );

        db.execute(''' 
          INSERT INTO Users(User_Name, Email, Gender, DOB, Phone_no, Balance) 
          VALUES 
          ("Max Joseph", "sam12345@gmail.com", 'M', "30-06-1995",5587946632, 1456.789), 
          ("Jose Marcel", "marceljose@gmail.com", 'M', "24-12-1991", 8565488932, 15502.32),
          ("Rose Query", "rose1996@gmail.com", 'F', "15-02-1989",776933156, 9502.15),
          ("Walt Greffor", "mwaltgreffor@yahoo.com",'M', "17-11-1998", 6697553216, 42100.05),
          ("Britney Villstone", "vilstone123@gmail.com", 'F', "08-05-2000",7769883215, 12500.5),
          ("Suhana Khan", "suhana1998@gmail.com", 'F', "12-09-1998",7860274874, 13446.789), 
          ("Charlie Gonjalez", "gonjalezcharlie@gmail.com", 'M', "02-10-1997",03928475934, 1550345.32),
          ("Jay Chopra", "jay1995@gmail.com", 'M', "17-06-1995",39329834134, 95556.15),
          ("Namrata Shetty", "namratas@yahoo.com", 'F', "30-03-2000",23094798375, 43400.05),
          ("Elizebeth Olsen", "olseneliz@gmail.com", 'F', "19-01-1993",2136383243, 12500.5);  
        ''');

        print("Done..!!");
      },
    );

    MyHomePage.list = await database.rawQuery('SELECT * FROM Users');
  }

  @override
  void initState() {
    dbase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AllCustomers(),
                  ),
                );
              },
              child: Text('View All Customers'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AllTransactions(),
                  ),
                );
              },
              child: Text('View All Transactions'),
            ),
          ],
        ),
      ),
    );
  }
}
