import 'package:banking_app/allCustomers.dart';
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
      home: MyHomePage(title: 'Home Page'),
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

    await deleteDatabase(path);

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        db.execute(
          '''
          CREATE TABLE Users(          
            User_Name varchar(24),
            Email varchar(24),
            Phone_no character(13),
            Balance double
          );

          ''',
        );

        db.execute(''' 
          INSERT INTO Users(User_Name, Email, Phone_no, Balance) 
          VALUES 
          ("Max Joseph", "sam12345@gmail.com", 5587946632, 1456.789), 
          ("Jose Marcel", "marceljose@gmail.com", 8565488932, 15502.32),
          ("Rose Query", "rose1996@gmail.com", 776933156, 9502.15),
          ("Walt Greffor", "mwaltgreffor@yahoo.com", 6697553216, 42100.05),
          ("Britney Villstone", "vilstone123@gmail.com", 7769883215, 12500.5),
          ("Steve Rogers", "steve@gmail.com", 7860274874, 13446.789), 
          ("Tony Stark", "tony@gmail.com", 03928475934, 1550345.32),
          ("Clint Barton", "clint@gmail.com", 39329834134, 95556.15),
          ("Natasha Romanoff", "nat@yahoo.com", 23094798375, 43400.05),
          ("Wanda", "wanda@gmail.com", 2136383243, 12500.5);  
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
        title: Text(widget.title),
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
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
