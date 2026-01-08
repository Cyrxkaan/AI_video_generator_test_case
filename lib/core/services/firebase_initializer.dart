import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Firebase initialization service
class FirebaseInitializer {
  /// Initialize Firebase app
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      if (kDebugMode) {
        print('Firebase initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Firebase initialization error: \$e');
      }
      rethrow;
    }
  }
}
