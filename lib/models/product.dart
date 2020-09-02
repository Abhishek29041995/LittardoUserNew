class Product {
  final String id;
  final String name;
  final String icon;
  final double rating;
  final String price;
  final String isWishlisted;
  final String originalPrice;
  final String description;
  final int remainingQuantity;
  String shipping_cost;
  final String current_stock;
  final List photos;

  Product({
    this.id,
    this.name,
    this.icon,
    this.rating,
    this.price,
    this.isWishlisted,
    this.originalPrice,
    this.description,
    this.remainingQuantity,
    this.current_stock,
    this.shipping_cost,
    this.photos,
  });
}
