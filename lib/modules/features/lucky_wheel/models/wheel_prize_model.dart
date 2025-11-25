class WheelPrize {
  final String id;
  final String name;
  final int value;
  final String type; // 'coin', 'item', 'multiplier'
  final String? itemId; // for shop items

  WheelPrize({
    required this.id,
    required this.name,
    required this.value,
    required this.type,
    this.itemId,
  });
}
