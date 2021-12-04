import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:valo_chat_app/app/data/models/auth_model.dart';
import '../data/models/user_model.dart';

//Storage service for storing local data
class LocalStorage {
  LocalStorage._();
  static final LocalStorage _instance = LocalStorage._();
  factory LocalStorage() => _instance;
  static late SharedPreferences _pref;

  //init
  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  //save token
  static Future saveToken(LoginRespone token) async {
    await _pref.setString('token', token.toRawJson());
  }

  //get token
  static LoginRespone? getToken() {
    final raw = _pref.getString('token');
    if (raw == null) return null;
    return LoginRespone.fromRawJson(raw);
  }

  static Future removeToken() async {
    await _pref.remove('token');
  }

  //save user
  static Future saveUser(User user) async {
    await _pref.setString('user', user.toRawJson());
  }

  static Future updateUser(User user) async {
    _pref.remove('user');
    await _pref.setString('user', user.toRawJson());
  }

  static Future removeUser() async {
    await _pref.remove('user');
  }

  //get user
  static User? getUser() {
    final raw = _pref.getString('user');
    if (raw == null) return null;
    return User.fromRawJson(raw);
  }

  //check token is expired
  static bool checkTokenExpire() {
    if (getToken() != null) {
      String token = getToken()!.accessToken.toString();
      String rfToken = getToken()!.refreshToken.toString();
      bool isExpire = Jwt.isExpired(token);
      bool refresh = Jwt.isExpired(rfToken);
      if (!isExpire) {
        return true;
      }
      // else if (isExpire && !refresh) {
      //   // refreshToken(rfToken);
      // }
      // else {
      //   Get.offAllNamed('/');
      //   _pref.remove('user');
      //   _pref.remove('token');
      //   _pref.clear();
      //   return false;
      // }
    }
    return false;
  }

  //Log out
  static Future logout() async {
    await removeToken();
    await removeUser();
    await _pref.clear();
  }

  static Future saveThemeStatus(value) async {
    await _pref.setBool('theme', value);
  }

  static Future getTheme() async {
    final raw = _pref.getBool('theme');
    if (raw == null) return null;
    return raw;
  }
}
