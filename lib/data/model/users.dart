class UsersModel {
  String? userid;
  String? username;
  String? useremail;
  String? userpassword;
  String? userphone;
  String? usercreate;
  String? userimage;

  UsersModel({
    this.userid,
    this.username,
    this.useremail,
    this.userpassword,
    this.userphone,
    this.usercreate,
    this.userimage,
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'].toString();
    username = json['username'];
    useremail = json['useremail'];
    userpassword = json['userpassword'];
    userphone = json['userphone'];
    usercreate = json['usercreate'];
    userimage = json['userimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['username'] = username;
    data['useremail'] = useremail;
    data['userpassword'] = userpassword;
    data['userphone'] = userphone;
    data['usercreate'] = usercreate;
    data['userimage'] = userimage;
    return data;
  }
}
