import 'dart:math';

class Product {
  late int id;
  late String picture;
  late String title;
  late String description;
  late String price;
  late String time;


  Product(this.id,this.picture, this.title, this.description,this.price,this.time);

  Product.fromMap(Map<dynamic, dynamic> data) {
    id = data['id'];
    picture = data['picture'];
    title = data['title'];
    description = data['description'];
    price = data['price'];
    time = data['time'];

  }
}
