import 'package:rxdart/rxdart.dart';
import 'package:sout/base_bloc.dart';
import 'package:sout/models/models.dart';

class UserBloc implements BaseBloc {
  static final UserModel _user = UserModel();

  final BehaviorSubject<UserModel> _userController =
      BehaviorSubject<UserModel>.seeded(_user);

  Stream<UserModel> get stream => _userController.stream;

  UserModel get user => _user;

  Future login(email, password) async {
    await _user
        .login(email, password)
        .then((value) => _userController.add(value));
  }

  bool get isLogin => _user.islogin;

  Future register({
    firstName,
    lastName,
    email,
    password,
    confirmPassword,
    mobile,
    gender,
    birthDate,
  }) async {
    UserModel user = UserModel();
    user.firstName = firstName;
    user.lastName = lastName;
    user.email = email;
    user.password = password;
    user.confirmPassword = confirmPassword;
    user.mobile = mobile;
    user.gender = gender;
    user.birthDate = birthDate;
    await _user.register(user);
  }

  // Future updateProfile() async {} //TODO later

  Future resetPassword(email) async {
    await _user.resetPassword(email);
  }

  @override
  void dispose() {
    _userController.drain();
    _userController.close();
  }
}
