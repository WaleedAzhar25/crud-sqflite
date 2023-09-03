import 'dart:io';

import 'package:crud_sqflite_project/screens/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/Product.dart';
import '../../../utils/db.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  vali(value) {
    if (value!.isEmpty || value.length < 2) {
      return 'enter correct value';
    }
  }
  String picture = '';
  String title = '';
  String description = '';
  String price = '';
  String date = '';
  final tittlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final datecontroller = TextEditingController();
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemproray = File(image.path);
      setState(() => this.image = imageTemproray);
    } on PlatformException catch (e) {
      print("failed to pick image:$e");
    }
  }
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    print("clicked");
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      return;
    }
    var item = Product(0,image!.path,title, description, price,date);
    var dbHelper = DBHelper();
    dbHelper.saveProduct(item);
    print("Data saved successfully");
    setState(() {
      title="";
      description="";
      price="";
      date="";

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              image != null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Image.file(
                        image!,
                        fit: BoxFit.fill,
                      ))
                  : Image.asset('images/11.jpg'),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(children: [
                    ElevatedButton(
                      onPressed: () => pickImage(),
                      child: Text(
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
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 5),
                              child: TextFormField(
                                  validator: (val) => val!.isEmpty ? "Tittle" : null,
                                  onSaved: (val) => title = val!,
                                  controller: tittlecontroller,
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
                                  const EdgeInsets.only(left: 15, right: 15, top: 5),
                              child: TextFormField(
                                  validator: (val) => val!.isEmpty ? 'Description' : null,
                                  onSaved: (val) => description = val!,
                                  controller: descriptioncontroller,
                                  maxLines: 15,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Description',
                                      hintStyle: TextStyle(
                                          fontSize: 15, color: Colors.black))))),
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
                                  onSaved: (val) => price = val!,
                                  controller: pricecontroller,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon: SizedBox(
                                          height: 30,
                                          width: 20,
                                          child: Image.asset(
                                            "images/dollar.png",
                                            fit: BoxFit.fill,
                                          )),
                                      border: InputBorder.none,
                                      hintText: 'Price',
                                      hintStyle:const TextStyle(
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
                        if(_formKey.currentState!.validate()){
                          _submit();
                          setState((){

                          });
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const AdminPage()));
                        }
                      },
                      child: Text(
                        "Save",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.teal),
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

}
