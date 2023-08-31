import 'package:chat/constants/values/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorageServices {
  late final SharedPreferences sharedPreferences;
  Future<AppStorageServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

//////////////////{ Get device open first time  }  /////////////////
  Future<void> setLoggedIn(bool isLoggedIn) async {
    await sharedPreferences.setBool(AppConstants.isLogIn, isLoggedIn);
  }

  bool getIsLoggedIn() {
    return sharedPreferences.getBool(AppConstants.isLogIn) ?? false;
  }

////////////////////////////////////////////////////////////////////
  Future<bool> remove(String key) {
    return sharedPreferences.remove(key);
  }
}
