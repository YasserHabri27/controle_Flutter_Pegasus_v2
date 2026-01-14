import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pegasus_app/core/app_export.dart';
import 'package:pegasus_app/core/widgets/custom_icon_widget.dart';

/// Splash screen that handles app initialization and authentication routing
/// Displays branded launch experience while loading Firebase, Hive, and user preferences
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _initializationComplete = false;
  String _statusMessage = 'Initialisation...';

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // Step 1: Initialize Firebase Authentication
      await _updateStatus('Connexion à Firebase...');
      await Future.delayed(const Duration(milliseconds: 800));

      // Step 2: Initialize Hive local storage
      await _updateStatus('Initialisation du stockage local...');
      await Future.delayed(const Duration(milliseconds: 600));

      // Step 3: Load user preferences
      await _updateStatus('Chargement des préférences...');
      await Future.delayed(const Duration(milliseconds: 500));

      // Step 4: Check authentication and determine routing
      await _updateStatus('Vérification de l\'authentification...');
      await Future.delayed(const Duration(milliseconds: 700));

      setState(() => _initializationComplete = true);

      // Navigate based on authentication status
      await Future.delayed(const Duration(milliseconds: 500));
      _navigateToNextScreen();
    } catch (e) {
      _handleInitializationError(e);
    }
  }

  Future<void> _updateStatus(String message) async {
    if (mounted) {
      setState(() => _statusMessage = message);
    }
  }

  void _navigateToNextScreen() {
    if (!mounted) return;

    // Simulate authentication check
    // In production: Check Firebase auth state and user role
    final isAuthenticated = false; // Replace with actual auth check
    final isAdmin = false; // Replace with actual role check

    if (isAuthenticated) {

      if (isAdmin) {

        // Navigate to Admin Dashboard (not implemented in this screen)

        Navigator.pushReplacementNamed(context, '/user-dashboard');

      } else {

        // Navigate to User Dashboard with bottom navigation

        Navigator.pushReplacementNamed(context, '/user-dashboard');

      }

    } else {

      // For demo purposes, we'll go straight to dashboard for now

      // In a real app, this would go to login

      Navigator.pushReplacementNamed(context, '/user-dashboard');

    }
  }

  void _handleInitializationError(dynamic error) {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Erreur d\'initialisation',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Une erreur s\'est produite lors de l\'initialisation de l\'application.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Veuillez vérifier votre connexion Internet et réessayer.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _initializeApp();
            },
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // Hide status bar on Android, match brand color on iOS
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primaryContainer,
              theme.colorScheme.secondary,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              _buildLogo(theme),
              const SizedBox(height: 48),
              _buildLoadingIndicator(theme),
              const SizedBox(height: 24),
              _buildStatusText(theme),
              const Spacer(flex: 3),
              _buildVersionInfo(theme),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(ThemeData theme) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(opacity: _fadeAnimation, child: child),
        );
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'rocket_launch',
                color: theme.colorScheme.primary,
                size: 48,
              ),
              const SizedBox(height: 8),
              Text(
                'Pegasus',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(ThemeData theme) {
    return SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.onPrimary),
        strokeWidth: 3,
      ),
    );
  }

  Widget _buildStatusText(ThemeData theme) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        _statusMessage,
        key: ValueKey(_statusMessage),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
          letterSpacing: 0.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildVersionInfo(ThemeData theme) {
    return Column(
      children: [
        Text(
          'Version 1.0.0',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '© 2026 Pegasus Workflow Manager',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.6),
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}
