import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/photo_carousel.dart';

class SignInScreen
    extends StatefulWidget {
  const SignInScreen(
      {super.key});

  @override
  State<SignInScreen> createState() =>
      _SignInScreenState();
}

class _SignInScreenState
    extends State<SignInScreen> {
  final _formKey =
      GlobalKey<FormState>();
  final TextEditingController
      _emailController =
      TextEditingController();
  final TextEditingController
      _passwordController =
      TextEditingController();
  bool
      _obscurePassword =
      true;
  bool
      _isLoading =
      false;

  // Image paths for carousel images
  final List<String>
      _topRowImages =
      [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
  ];

  final List<String>
      _bottomRowImages =
      [
    'assets/images/img5.png',
    'assets/images/img6.png',
    'assets/images/img7.png',
    'assets/images/img8.png',
  ];

  @override
  Widget
      build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Animated Photo Carousel Section
              PhotoCarousel(
                topRowImages: _topRowImages,
                bottomRowImages: _bottomRowImages,
                animationDuration: const Duration(
                  milliseconds: AppDimensions.carouselAnimationDuration,
                ),
              ),

              // Main Content
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Column(
                  children: [
                    // Title Section
                    Text(
                      AppStrings.celebrateTitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTextColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingSmall),
                    Text(
                      AppStrings.appTagline,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingXXLarge),

                    // Email Field
                    CustomTextField(
                      label: AppStrings.emailAddress,
                      hintText: AppStrings.enterEmail,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),

                    // Password Field
                    CustomTextField(
                      label: AppStrings.password,
                      hintText: AppStrings.enterPassword,
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      validator: Validators.validatePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.hintTextColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingMedium),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.pushNamed(AppRoutes.forgotPassword);
                        },
                        child: Text(
                          AppStrings.forgotPassword,
                          style: GoogleFonts.poppins(
                            color: AppColors.accentGold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingXLarge),

                    // Sign In Button
                    CustomButton(
                      text: AppStrings.signIn,
                      onPressed: _isLoading ? null : _handleSignIn,
                      isLoading: _isLoading,
                      type: ButtonType.primary,
                    ),
                    const SizedBox(height: AppDimensions.paddingXLarge),

                    // Divider
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(color: AppColors.dividerColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingMedium,
                          ),
                          child: Text(
                            AppStrings.orContinueWith,
                            style: GoogleFonts.poppins(
                              color: AppColors.secondaryTextColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(color: AppColors.dividerColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),

                    // Phone Number Button
                    CustomButton(
                      text: AppStrings.phoneNumber,
                      onPressed: _handlePhoneSignIn,
                      type: ButtonType.outline,
                    ),
                    const SizedBox(height: AppDimensions.paddingXLarge),

                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.dontHaveAccount,
                          style: GoogleFonts.poppins(
                            color: AppColors.secondaryTextColor,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(AppRoutes.createAccount);
                          },
                          child: Text(
                            AppStrings.register,
                            style: GoogleFonts.poppins(
                              color: AppColors.primaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void
      _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Show success message
      if (mounted) {
        context.showSnackBar('Sign in successful!');
      }
    }
  }

  void
      _handlePhoneSignIn() {
    context.showSnackBar('Phone sign in not implemented yet');
  }

  @override
  void
      dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
