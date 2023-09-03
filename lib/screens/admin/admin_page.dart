import 'package:crud_sqflite_project/screens/admin/pages/add_prodcut_page.dart';
import 'package:crud_sqflite_project/screens/admin/pages/all_products.dart';
import 'package:crud_sqflite_project/utils/db.dart';
import 'package:flutter/material.dart';
class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title:
        const Text(
            "Admin Page"),),
      body: Stack(
        children: <Widget>[

          Column(
            children: <Widget>[
              const SizedBox(height: 50,),
              Expanded(
                child: GridView.count(crossAxisCount: 2,
                  children: <Widget>[

                    TextButton(
                      onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddProductPage())); },
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network("https://www.smallbizdaily.com/wp-content/uploads/2021/01/shutterstock_1746002939-1.jpg",height: 120,),
                              const Text('Add New Product'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>const AllProducts()));  },
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network("https://pngimage.net/wp-content/uploads/2018/06/homework-cartoon-png-2.png",height: 120,),
                              const Text('All Products'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
