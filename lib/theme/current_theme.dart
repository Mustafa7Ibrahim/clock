import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentTheme extends ChangeNotifier {
  bool _isLightTheme = true;

  void changeTheme() {
    _isLightTheme = !_isLightTheme;
    // _saveCurrentTheme('lightTheme', _isLightTheme);
    notifyListeners();
  }

  // _saveCurrentTheme(String key, bool value) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool(key, value);
  // }

  Future getCurrentTheme(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  // bool getTheme() {
  //   bool lightTheme;
  //   getCurrentTheme('lightTheme').then(
  //     (value) => value == false ? lightTheme = false : true,
  //   );
  //   return lightTheme;
  // }

  bool get isLightTheme => _isLightTheme;
}
