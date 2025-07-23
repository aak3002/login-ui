import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/phone_input_field.dart';

class ForgotPasswordScreen
    extends StatefulWidget {
  const ForgotPasswordScreen(
      {super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final _formKey =
      GlobalKey<FormState>();
  final TextEditingController
      _phoneController =
      TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              _buildTitleSection(),
              const SizedBox(height: AppDimensions.paddingXXLarge),

              // Phone Number Field
              PhoneInputField(
                controller: _phoneController,
                countryCode: _selectedCountryCode,
                validator: Validators.validatePhone,
                //  onCountryTap: _showCountryPicker, Not needed
              ),
              const SizedBox(height: AppDimensions.paddingXXLarge),

              // Send OTP Button
              CustomButton(
                text: AppStrings.sendOTP,
                onPressed: _isLoading ? null : _handleSendOTP,
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
          AppStrings.forgetPassword,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTextColor,
              ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        Text(
          AppStrings.forgotPasswordDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.secondaryTextColor,
              ),
        ),
      ],
    );
  }

  void
      _showCountryPicker() {
    context.showSnackBar('Country picker not implemented yet');
  }

  void
      _handleSendOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Navigate to OTP verification
      if (mounted) {
        context.showSnackBar('OTP sent successfully!');
        context.pushNamed(AppRoutes.otpVerification);
      }
    }
  }

  @override
  void
      dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
