import 'package:flutter/material.dart';
import 'package:final_occasions/features/splash/splash_screen.dart';
import 'package:final_occasions/features/auth/screens/sign_in_screen.dart';
import 'package:final_occasions/features/auth/screens/create_account_screen.dart';
import 'package:final_occasions/features/auth/screens/forgot_password_screen.dart';
import 'package:final_occasions/features/auth/screens/otp_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic>
      generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _createRoute(const SplashScreen());

      case AppRoutes.signIn:
        return _createRoute(const SignInScreen());

      case AppRoutes.createAccount:
        return _createRoute(const CreateAccountScreen());

      case AppRoutes.forgotPassword:
        return _createRoute(const ForgotPasswordScreen());

      case AppRoutes.otpVerification:
        return _createRoute(const OtpScreen());

      default:
        return _createRoute(const SignInScreen());
    }
  }

  static PageRoute
      _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static PageRoute
      createFadeRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: const Duration(milliseconds: 800),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
