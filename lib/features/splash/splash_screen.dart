import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/extensions.dart';

class SplashScreen
    extends StatefulWidget {
  const SplashScreen(
      {super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with
        TickerProviderStateMixin {
  late AnimationController
      _fadeController;
  late AnimationController
      _scaleController;
  late Animation<double>
      _fadeAnimation;
  late Animation<double>
      _scaleAnimation;

  @override
  void
      initState() {
    super.initState();

    _fadeController =
        AnimationController(
      duration: const Duration(milliseconds: AppDimensions.splashFadeDuration),
      vsync: this,
    );

    _scaleController =
        AnimationController(
      duration: const Duration(milliseconds: AppDimensions.splashScaleDuration),
      vsync: this,
    );

    _fadeAnimation =
        Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation =
        Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _startAnimations();

    _navigateToSignIn();
  }

  void
      _startAnimations() {
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300),
        () {
      _scaleController.forward();
    });
  }

  void
      _navigateToSignIn() {
    Future.delayed(
      const Duration(milliseconds: AppDimensions.splashNavigationDelay),
      () {
        if (mounted) {
          context.pushReplacementNamed(AppRoutes.signIn);
        }
      },
    );
  }

  @override
  Widget
      build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.splashBackground,
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: AppDimensions.splashLogoSize,
                    height: AppDimensions.splashLogoSize,
                    child: Image.asset(
                      'assets/images/OccasionLogo.png',
                      fit: BoxFit.contain,
                      //color: Colors.white.withOpacity(0.9),
                      //colorBlendMode: BlendMode.overlay,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.celebration,
                            size: 100,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void
      dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}
