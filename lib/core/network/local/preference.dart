import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future get({required String key});

  Future<bool?> has({required String key});

  Future<bool?> set({required String key, dynamic value});

  Future<bool?> clear({required String key});
}

class Pref extends SharedPref {
  final SharedPreferences sharedPreferences;

  Pref({required this.sharedPreferences});

  @override
  Future<bool?> has({required String key}) async {
    final bool? f = await _basicErrorHandling(() async {
      return sharedPreferences.containsKey(key) &&
          sharedPreferences.getString(key)!.isNotEmpty;
    });
    return f;
  }

  @override
  Future<bool?> clear({required String key}) async {
    final bool? f = await _basicErrorHandling(() async {
      return await sharedPreferences.remove(key);
    });
    return f;
  }

  @override
  Future<bool?> set({required String key, dynamic value}) async {
    final bool? f = await _basicErrorHandling(() async {
      return await sharedPreferences.setString(
          key,
          jsonEncode(
            value,
          ));
    });
    return f;
  }

  @override
  Future get({String? key}) async {
    final f = await _basicErrorHandling(() async {
      if (await has(key: key!) != null) {
        return sharedPreferences.getString(key) != null
            ? jsonDecode(sharedPreferences.getString(key)!)
            : null;
      }
      return null;
    });
    return f;
  }
}

extension on SharedPref {
  Future<T?> _basicErrorHandling<T>(Future<T> Function() onSuccess) async {
    try {
      final f = await onSuccess();
      return f;
    } catch (e) {
      return null;
    }
  }
}
