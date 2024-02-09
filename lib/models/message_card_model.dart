class ChatModel {
  final String name;
  final String message;
  final bool isCurrentUser;
  final int day;
  final int online;
  final bool isPhoto;
  final bool? hasBlueBorder;
  final String? photoAvatar;

  ChatModel({
    required this.name,
    required this.message,
    required this.isCurrentUser,
    required this.day,
    required this.online,
    required this.isPhoto,
    this.hasBlueBorder = false,
    this.photoAvatar = "",
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      name: json['name'],
      message: json['message'],
      isCurrentUser: json['myMessage'],
      day: json['day'],
      online: json['online'],
      isPhoto: json['isPhoto'],
      hasBlueBorder: json['hasBlueBorder'],
      photoAvatar: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "message": message,
      "myMessage": isCurrentUser,
      "day": day,
      "online": online,
      "isPhoto": isPhoto,
      "hasBlueBorder": hasBlueBorder,
      "photoUrl": photoAvatar,
    };
  }
}
