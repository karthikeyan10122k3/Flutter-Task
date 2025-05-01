class EditProductModel {
  String title;
  double price;
  String category;
  double discountPercentage;
  int stock;
  String availabilityStatus;
  int minimumOrderQuantity;

  EditProductModel({
    required this.title,
    required this.price,
    required this.category,
    required this.discountPercentage,
    required this.stock,
    required this.availabilityStatus,
    required this.minimumOrderQuantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'stock': stock,
      'availabilityStatus': availabilityStatus,
      'minimumOrderQuantity': minimumOrderQuantity,
    };
  }
}
