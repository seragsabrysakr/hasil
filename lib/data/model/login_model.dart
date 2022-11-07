class LoginResponseModel {
  String? token;
  String? email;
  String? nicename;
  String? displayName;
  String? message;

  LoginResponseModel(
      {this.token, this.email, this.nicename, this.displayName, this.message});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    email = json['user_email'];
    nicename = json['user_nicename'];
    displayName = json['user_display_name'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user_email'] = this.email;
    data['user_nicename'] = this.nicename;
    data['user_display_name'] = this.displayName;
    data['message'] = this.message;

    return data;
  }
}
