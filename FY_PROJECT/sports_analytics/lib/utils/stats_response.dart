class StatsResponse {
  final bool error;
  final String message;
  final List<StatItem> list;

  StatsResponse({
    required this.error,
    required this.message,
    required this.list,
  });

  factory StatsResponse.fromJson(Map<String, dynamic> json) {
    return StatsResponse(
      error: json['error'],
      message: json['message'],
      list: List<StatItem>.from(json['list'].map((x) => StatItem.fromJson(x))),
    );
  }
}

class StatItem {
  final int id;
  final int userId;
  final int physicals;
  final int speed;
  final int stamina;
  final int strength;
  final String createdAt;
  final String updatedAt;

  StatItem({
    required this.id,
    required this.userId,
    required this.physicals,
    required this.speed,
    required this.stamina,
    required this.strength,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StatItem.fromJson(Map<String, dynamic> json) {
    return StatItem(
      id: json['id'],
      userId: json['user_id'],
      physicals: json['physicals'],
      speed: json['speed'],
      stamina: json['stamina'],
      strength: json['strength'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
