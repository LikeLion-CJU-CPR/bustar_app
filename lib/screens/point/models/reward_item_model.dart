class RewardItem {
  final int id;
  final String name;
  final String description;
  final int points;
  final String icon;
  final String category;
  final String discount;
  final String expiry;
  final bool popular;

  RewardItem({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.icon,
    required this.category,
    required this.discount,
    required this.expiry,
    required this.popular,
  });
}
