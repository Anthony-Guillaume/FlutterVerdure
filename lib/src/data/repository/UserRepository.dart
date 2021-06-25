import 'dart:async';

import 'package:uuid/uuid.dart';
import 'package:verdure/src/data/entity/User.dart';

class UserRepository {
  User? _cache;

  Future<User?> getUser() async {
    if (_cache != null) {
      return _cache;
    }
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _cache = User(id: const Uuid().v4()),
    );
  }
}
