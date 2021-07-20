class AuthHeadersModel {
  final String uid;
  final String client;
  final String accessToken;

  AuthHeadersModel(
      {required this.uid, required this.client, required this.accessToken});

  factory AuthHeadersModel.fromJson(Map<String, dynamic> json) {
    return AuthHeadersModel(
      uid: json['uid'],
      client: json['client'],
      accessToken: json['access-token'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['client'] = this.client;
    data['access-token'] = this.accessToken;
    return data;
  }
}
