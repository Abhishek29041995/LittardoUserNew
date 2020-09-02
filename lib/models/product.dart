class Product {
  final String id;
  final String name;
  final String icon;
  final double rating;
  final String price;
  final String isWishlisted;
  final String originalPrice;
  final int remainingQuantity;

  Product(
      {this.id,
      this.name,
      this.icon,
      this.rating,
      this.price,
      this.isWishlisted,
      this.originalPrice,
      this.remainingQuantity});
}
