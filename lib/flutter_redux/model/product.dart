class Product {
  String id;
  String title;
  String description;
  String imageUrl;
  num price;

  Product({this.id, this.title, this.description, this.imageUrl, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        imageUrl: json['image_url'],
        price: json['price']
    );
  }
}
