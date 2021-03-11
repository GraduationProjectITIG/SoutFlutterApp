import 'package:rxdart/rxdart.dart';
import 'package:sout/base_bloc.dart';
import 'package:sout/models/models.dart';

class UserBloc implements BaseBloc {
  static final UserModel _user = UserModel();

  final BehaviorSubject<UserModel> _userController =
      BehaviorSubject<UserModel>.seeded(_user);

  Stream<UserModel> get stream => _userController.stream;

  Future login(email, password) async {
    // await _user.login(email, password);

    _userController.add(_user);
  }

  bool get isLogin => _user.islogin;

  @override
  void dispose() {
    _userController.drain();
    _userController.close();
  }
}
