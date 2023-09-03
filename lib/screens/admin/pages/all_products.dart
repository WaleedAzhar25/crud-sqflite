import 'dart:io';
import 'package:crud_sqflite_project/screens/admin/pages/update_prodcut_page.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../../utils/db.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  Future<List> getAllProducttFromDb() async {
    var dbHelper = DBHelper();
    Future<List> item = dbHelper.getProduct();
    return item;
  }

  void delete(int id) {
    var dbHelper = DBHelper();
    dbHelper.deleteProduct(id);
    print("deleted");
  }

  File? imageT;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title:const  Text('All Products'),
      ),
      body: FutureBuilder<List>(
        future: getAllProducttFromDb(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int i) {
                  imageT = File(snapshot.data![i].picture);
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              snapshot.data![i].title,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            IconButton(onPressed: (){
                              delete(snapshot.data![i].id);
                              setState((){

                              });
                            }, icon: const Icon(Icons.delete,color: Colors.red,))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdateProductPage(item: snapshot.data![i],)));
                        },

                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 1,
                            child: Image.file(
                              imageT!,
                              fit: BoxFit.fill,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReadMoreText(
                              "${snapshot.data![i].description}",
                              trimLines: 2,
                              colorClickableText:  Colors.blue,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: "...Show More",
                              trimExpandedText: " show less",
                              style: const TextStyle(fontSize: 14),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${snapshot.data![i].date}",
                                style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "\$${snapshot.data![i].price}",
                                style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                     const Padding(
                         padding:  EdgeInsets.symmetric(vertical: 10),
                         child: Divider(
                          thickness: 2,
                      ),
                       ),
                    ],
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
