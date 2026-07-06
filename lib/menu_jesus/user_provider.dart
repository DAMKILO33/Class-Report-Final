import 'package:flutter/material.dart';
import '../model_diego/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners(); // Notifica a la UI que hubo cambios
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
