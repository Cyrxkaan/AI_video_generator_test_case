import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_vid_gen/presentation/onboarding/landing_screen.dart';
import 'package:ai_vid_gen/presentation/onboarding/onboarding_screen.dart';
import 'package:ai_vid_gen/presentation/paywall/paywall_screen.dart';
import 'package:ai_vid_gen/presentation/generation/generation_screen.dart';
import 'package:ai_vid_gen/presentation/home/home_screen.dart';
import 'package:ai_vid_gen/presentation/profile/profile_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/', // Start with landing screen
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
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(), // Home screen
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(), // Profile screen
    ),
  ],
);