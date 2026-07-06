import '../model-diego/user_model.dart';

class AuthService {
  AuthService._internal();

  static final AuthService instance = AuthService._internal();

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;
  bool get isLogged => isLoggedIn;

  void login(String id, String name, String email, {String role = 'Usuario'}) {
    _currentUser = UserModel(id: id, name: name, email: email, role: role);
  }

  void logout() {
    _currentUser = null;
  }
}
