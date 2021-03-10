class UserModel {
  String firstName, email;
  bool islogin = false;
  UserModel({this.firstName, this.email}) {}

  Future<UserModel> login(email, password) async {
    this.islogin = true;
    return UserModel();
  }
}
