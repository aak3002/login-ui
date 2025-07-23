import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/otp_input.dart';

class OtpScreen
    extends StatefulWidget {
  const OtpScreen(
      {super.key});

  @override
  State<OtpScreen> createState() =>
      _OtpScreenState();
}

class _OtpScreenState
    extends State<OtpScreen> {
  bool
      _isLoading =
      false;
  String
      _currentOTP =
      '';
  int _resendCountdown =
      95; // 1:35 in seconds
  Timer?
      _countdownTimer;

  @override
  void
      initState() {
    super.initState();
    _startCountdown();
  }

  @override
  Widget
      build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const AppHeader(),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            _buildTitleSection(),
            const SizedBox(height: AppDimensions.paddingXXLarge),

            // OTP Input
            OtpInput(
              length: 5,
              onCompleted: (otp) {
                _currentOTP = otp;
                _handleOTPComplete();
              },
              onChanged: (otp) {
                _currentOTP = otp;
              },
            ),
            const SizedBox(height: AppDimensions.paddingLarge),

            // Resend Code
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _resendCountdown == 0 ? _handleResendOTP : null,
                child: Text(
                  _resendCountdown > 0 ? 'Resend code in ${_formatCountdown(_resendCountdown)}' : 'Resend code',
                  style: GoogleFonts.poppins(
                    color: _resendCountdown > 0 ? AppColors.accentGold : AppColors.primaryBrown,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXXLarge),

            // Verify Button
            CustomButton(
              text: AppStrings.verify,
              onPressed: _currentOTP.length == 5 && !_isLoading ? _handleVerification : null,
              isLoading: _isLoading,
              type: ButtonType.primary,
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
          ],
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
          AppStrings.otpVerification,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTextColor,
              ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        Text(
          AppStrings.otpDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.secondaryTextColor,
                height: 1.4,
              ),
        ),
      ],
    );
  }

  void
      _startCountdown() {
    _countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String
      _formatCountdown(int seconds) {
    int minutes =
        seconds ~/ 60;
    int remainingSeconds =
        seconds % 60;
    return '${minutes}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void
      _handleOTPComplete() {
    // Auto-verify when OTP is complete
    if (_currentOTP.length ==
        5) {
      _handleVerification();
    }
  }

  void
      _handleVerification() async {
    String?
        validationError =
        Validators.validateOTP(_currentOTP.split(''));
    if (validationError !=
        null) {
      context.showSnackBar(validationError, isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Show success and navigate back
    if (mounted) {
      context.showSnackBar('OTP verified successfully!');
      context.pop(); // Go back to previous screen
    }
  }

  void
      _handleResendOTP() async {
    context.showSnackBar('OTP resent successfully!');

    // Reset countdown
    setState(() {
      _resendCountdown = 95;
    });

    _startCountdown();
  }

  @override
  void
      dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }
}

extension
    on Timer? {
  void
      cancel() {}
}
