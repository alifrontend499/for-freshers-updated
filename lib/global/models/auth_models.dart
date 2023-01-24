class AuthUserModel {
  final String userToken;
  final String userId;
  final String userName;
  final String userEmail;
  final String userProfileImg;
  final String userPhone;

  AuthUserModel({
    required this.userToken,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userProfileImg,
    required this.userPhone,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      userToken: json['userToken'],
      userId: json['userId'],
      userName: json['userName'],
      userEmail: json['userEmail'],
      userProfileImg: json['userProfileImg'],
      userPhone: json['userPhone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userToken': userToken,
        'userId': userId,
        'userName': userName,
        'userEmail': userEmail,
        'userProfileImg': userProfileImg,
        'userPhone': userPhone,
      };
}
