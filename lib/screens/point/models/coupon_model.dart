class Coupon {
  final int id;
  final String name;
  final String description;
  final String discount;
  final String code;
  final String purchaseDate;
  final String expiryDate;
  final String status; // active, used, expired
  final String icon;
  final String category;
  final String usage;
  final String? usedDate;

  Coupon({
    required this.id,
    required this.name,
    required this.description,
    required this.discount,
    required this.code,
    required this.purchaseDate,
    required this.expiryDate,
    required this.status,
    required this.icon,
    required this.category,
    required this.usage,
    this.usedDate,
  });
}