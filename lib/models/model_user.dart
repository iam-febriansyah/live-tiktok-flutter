class User {
  String userId;
  String email;
  String domain;
  String license;
  String expireDate;
  String? startDate;
  String? lastActivityDate;
  int? onLive;

  User({
    required this.userId,
    required this.email,
    required this.domain,
    required this.license,
    required this.expireDate,
    this.startDate,
    this.lastActivityDate,
    this.onLive,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        email: json["email"],
        domain: json["domain"],
        license: json["license"] ?? '',
        startDate: json["start_date"] ?? '',
        lastActivityDate: json["last_activity_date"] ?? '',
        expireDate: json["expire_date"] ?? '',
        onLive: json["on_live"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "domain": domain,
        "license": license,
        "start_date": startDate,
        "last_activity_date": lastActivityDate,
        "expire_date": expireDate,
        "on_live": onLive,
      };
}
