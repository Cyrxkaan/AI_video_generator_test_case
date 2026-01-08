import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_vid_gen/views/onboarding/landing_screen.dart';
import 'package:ai_vid_gen/views/onboarding/onboarding_screen.dart';
import 'package:ai_vid_gen/views/paywall/paywall_screen.dart';
import 'package:ai_vid_gen/views/generation/generation_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'landing',
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/paywall',
      name: 'paywall',
      builder: (context, state) => const PaywallScreen(), // Paywall screen
    ),
    GoRoute(
      path: '/generation',
      name: 'generation',
      builder: (context, state) => const GenerationScreen(), // Generation screen
    ),
  ],
);