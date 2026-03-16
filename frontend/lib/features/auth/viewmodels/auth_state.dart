import 'package:flutter/foundation.dart';
import '../models/login_response_model.dart';

class AuthState extends ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  bool get isProfileCompleted => _currentUser?.profileCompleted ?? false;

  void setUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }

  void updateNickname(String nickname) {
    final user = _currentUser;
    if (user == null) return;

    _currentUser = UserModel(
      id: user.id,
      nickname: nickname,
      gender: user.gender,
      ageRange: user.ageRange,
      profileCompleted: true,
    );

    notifyListeners();
  }
}
