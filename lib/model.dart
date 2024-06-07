class stok {
  final String laptop_id;
  final String brand;
  final String model;
  final String production_year;
  final String Gambar;
  final String price;

  stok(
      {required this.laptop_id,
        required this.brand,
        required this.model,
        required this.production_year,
        required this.Gambar,
        required this.price
      });

  Map<String, dynamic> toJson() => {
    'laptop_id': laptop_id,
    'brand': brand,
    'model': model,
    'production_year': production_year,
    'Gambar': Gambar,
    'price': price
  };

  factory stok.fromJson(Map<String, dynamic> data) => stok(
      laptop_id: data['laptop_id'].toString(),
      brand: data['brand'].toString(),
      model: data['model'].toString(),
      production_year: data['production_year'].toString(),
      Gambar: data['Gambar'].toString(),
      price: data['price'].toString());
}
