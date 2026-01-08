import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';

// Loading state için provider
final isLoadingProvider = StateProvider<bool>(
  (ref) => false,
  name: 'isLoadingProvider',
);

// Result state için provider
final resultProvider = StateProvider<String?>(
  (ref) => null,
  name: 'resultProvider',
);