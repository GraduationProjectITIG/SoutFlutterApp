import 'package:rxdart/rxdart.dart';
import 'package:sout/base_bloc.dart';
import 'package:sout/models/models.dart';

import '../service_locator.dart';

class UserBloc implements BaseBloc {
  static final UserModel user = UserModel();

  final BehaviorSubject<UserModel> _userController =
      BehaviorSubject<UserModel>.seeded(user);

  Stream<UserModel> get stream => _userController.stream;

  // UserModel get userL => user;
  UserModel nUser = new UserModel();

  Future login(email, password) async {
    await user.login(email, password).then((value) => {
          print(value),
          _userController.add(value),
          nUser = value,
          print(nUser.firstName)
        });
    return nUser;
  }

  bool get isLogin => user.islogin;

  Future register(
    firstName,
    lastName,
    email,
    password,
    confirmPassword,
    mobile,
    gender,
    birthDate,
  ) async {
    UserModel user = UserModel();
    user.firstName = firstName;
    user.lastName = lastName;
    user.email = email;
    user.password = password;
    user.confirmPassword = confirmPassword;
    user.mobile = mobile;
    user.gender = gender;
    user.birthDate = birthDate;
    print("regUsBloc");
    print(email);
    await user.register(user);
  }

  // Future updateProfile() async {} //TODO later

  Future resetPassword(email) async {
    await user.resetPassword(email);
  }

  @override
  void dispose() {
    _userController.drain();
    _userController.close();
  }
}
