import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/phone_input_field.dart';

class CreateAccountScreen
    extends StatefulWidget {
  const CreateAccountScreen(
      {super.key});

  @override
  State<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState
    extends State<CreateAccountScreen> {
  final _formKey =
      GlobalKey<FormState>();
  final TextEditingController
      _nameController =
      TextEditingController();
  final TextEditingController
      _phoneController =
      TextEditingController();
  final TextEditingController
      _emailController =
      TextEditingController();
  final TextEditingController
      _passwordController =
      TextEditingController();
  final TextEditingController
      _confirmPasswordController =
      TextEditingController();

  bool
      _obscurePassword =
      true;
  bool
      _obscureConfirmPassword =
      true;
  bool
      _isLoading =
      false;
  String
      _selectedCountryCode =
      'AE';

  @override
  Widget
      build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              _buildTitleSection(),
              const SizedBox(height: AppDimensions.paddingXXLarge),

              // Name Field
              CustomTextField(
                label: AppStrings.name,
                hintText: AppStrings.enterName,
                controller: _nameController,
                validator: Validators.validateName,
              ),
              const SizedBox(height: AppDimensions.paddingLarge),

              // Phone Number Field
              PhoneInputField(
                controller: _phoneController,
                countryCode: _selectedCountryCode,
                validator: Validators.validatePhone,
                // onCountryTap: _showCountryPicker,
                // Removed country picker for simplicity, also not a required feature
              ),
              const SizedBox(height: AppDimensions.paddingLarge),

              // Email Field
              CustomTextField(
                label: AppStrings.email,
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
              const SizedBox(height: AppDimensions.paddingLarge),

              // Confirm Password Field
              CustomTextField(
                label: AppStrings.confirmPassword,
                hintText: AppStrings.confirmPassword,
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                validator: (value) => Validators.validateConfirmPassword(
                  value,
                  _passwordController.text,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.hintTextColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: AppDimensions.paddingXXLarge),

              // Sign Up Button
              CustomButton(
                text: AppStrings.signUp,
                onPressed: _isLoading ? null : _handleSignUp,
                isLoading: _isLoading,
                type: ButtonType.primary,
              ),
              const SizedBox(height: AppDimensions.paddingLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget
      _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.createAccount,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTextColor,
              ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        Text(
          AppStrings.signupToContinue,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.secondaryTextColor,
              ),
        ),
      ],
    );
  }

//  void _showCountryPicker() {
//    // For now, just show a snackbar
//    context.showSnackBar('Country picker not implemented yet');
//  }

  void
      _handleSignUp() async {
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
        context.showSnackBar('Account created successfully!');
        context.pop(); // Go back to previous screen
      }
    }
  }

  @override
  void
      dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
