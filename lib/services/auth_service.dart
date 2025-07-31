import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  /// ✅ Save user credentials in SharedPreferences
  Future<void> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  /// ✅ Login check (returns true if credentials match)
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    return savedEmail == email && savedPassword == password;
  }

  /// ✅ Reset Password (only if email matches)
  Future<bool> resetPassword(String email, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');

    if (savedEmail == email) {
      await prefs.setString('password', newPassword);
      return true;
    }
    return false;
  }

  /// ✅ Logout (clear stored credentials)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// ✅ Check if a user is already logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') != null;
  }

  /// ✅ Get logged in user email (optional utility)
  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
}
