import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';

// Subscription type enum
enum SubscriptionType { monthly, yearly }

// Provider to hold the selected subscription type
final subscriptionTypeProvider = StateProvider<SubscriptionType>(
  (ref) => SubscriptionType.monthly,
  name: 'subscriptionTypeProvider',
);

// Subscription information model
class SubscriptionPlan {
  final SubscriptionType type;
  final String title;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final bool isPopular;

  const SubscriptionPlan({
    required this.type,
    required this.title,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    this.isPopular = false,
  });
}

// Subscription plans
final subscriptionPlans = {
  SubscriptionType.monthly: const SubscriptionPlan(
    type: SubscriptionType.monthly,
    title: 'Monthly Plan',
    price: '\$9.99',
    period: 'month',
    description: 'Perfect for getting started',
    features: [
      'Unlimited AI Video Generation',
      '4K Quality Output',
      'Priority Processing',
      'Basic Support',
    ],
    isPopular: false,
  ),
  SubscriptionType.yearly: const SubscriptionPlan(
    type: SubscriptionType.yearly,
    title: 'Annual Plan',
    price: '\$99.99',
    period: 'year',
    description: 'Best value for power users',
    features: [
      'Unlimited AI Video Generation',
      '4K Quality Output',
      'Priority Processing',
      '24/7 Premium Support',
      'Exclusive Templates',
      'Early Access to New Features',
    ],
    isPopular: true,
  ),
};