import 'dart:io';

import 'package:crud_sqflite_project/screens/admin/pages/all_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/Product.dart';
import '../../../utils/db.dart';
class UpdateProductPage extends StatefulWidget {
  UpdateProductPage({Key? key, required this.item}) : super(key: key);
  Product item;

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState(item: item);
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  _UpdateProductPageState({required this.item});
  Product item;
  String title = '';
  String description = '';
  String price = '';
  String date='';
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var titleC = TextEditingController();
  var descriptionC = TextEditingController();
  final datecontroller = TextEditingController();
  var priceC = TextEditingController();
  File? imageY;
  File? imageZ;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemproray = File(image.path);
      setState(() => this.imageY = imageTemproray);
    } on PlatformException catch (e) {
      print("failed to pick image:$e");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      titleC.text = item.title;
      descriptionC.text = item.description;
      priceC.text = item.price;
      imageZ=File(item.picture.toString());
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              imageY != null
                  ? Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Image.file(
                    imageY!,
                    fit: BoxFit.fill,
                  ))
                  : Image.file(imageZ!),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(children: [
                    ElevatedButton(
                      onPressed: () => pickImage(),
                      child:  Text(
                        "pick gallery",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.teal),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:  BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                              padding:
                              EdgeInsets.only(left: 15, right: 15, top: 5),
                              child: TextFormField(
                                  validator: (val) => val!.isEmpty ? "Tittle" : null,
                                  onSaved: (val) => title = val!,
                                  controller:titleC ,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Tittle',
                                      hintStyle: TextStyle(
                                          fontSize: 15, color: Colors.black))))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                              padding:
                              EdgeInsets.only(left: 15, right: 15, top: 5),
                              child: TextFormField(
                                  validator: (val) => val!.isEmpty ? 'Description' : null,
                                  onSaved: (val) => description = val!,
                                  controller: descriptionC,
                                  maxLines: 15,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Description',
                                      hintStyle: TextStyle(
                                          fontSize: 15, color: Colors.black))))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:  BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                              padding:
                              const EdgeInsets.only(left: 15, right: 15, top: 5),
                              child: TextFormField(
                                  validator: (val) => val!.isEmpty ? 'Price' : null,
                                  onSaved: (val) => price = val!,
                                  controller: priceC,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon: Container(
                                          height: 30,
                                          width: 20,
                                          child: Image.asset(
                                            "images/dollar.png",
                                            fit: BoxFit.fill,
                                          )),
                                      border: InputBorder.none,
                                      hintText: 'Price',
                                      hintStyle: const TextStyle(
                                          fontSize: 20, color: Colors.black))))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                          margin: const EdgeInsets.only(
                            right: 0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:  BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                              padding:
                              const EdgeInsets.only(left: 15, right: 15, top: 5),
                              child: TextFormField(
                                  validator: (val) => val!.isEmpty ? 'Price' : null,
                                  onSaved: (val) => date = val!,
                                  controller: datecontroller,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Date',
                                      hintStyle:TextStyle(
                                          fontSize: 20, color: Colors.black))))),
                    ),

                    ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          _submit();
                          setState(() {

                          });
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const AllProducts()));
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.teal),
                      child: const Text(
                        "Save",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _submit() {
    print("clicked");
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
    } else {
      return;
    }
    File ?imageW;
    if(imageY!=null){
      imageW=File(imageY!.path);
    }
    else{
      imageW=File(imageZ!.path);
    }
    item.title = title;
    item.description = description;
    item.price=price;
    item.time=date;
    print(" akwdhauwd ${item.id}");
    var product = Product(item.id,imageW.path, item.title, item.description,item.price,item.time);
    var dbHelper = DBHelper();
    dbHelper.updateProduct(product);
    print("Data Updated  successfully");
  }
}
