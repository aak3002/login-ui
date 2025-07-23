import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/utils/helpers.dart';

class OtpInput extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;
  final Function(String)? onChanged;

  const OtpInput({
    super.key,
    this.length = 5,
    required this.onCompleted,
    this.onChanged,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  List<String> _otpValues = [];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (index) => TextEditingController());
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _otpValues = List.filled(widget.length, '');

    // Add listeners to controllers
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        setState(() {
          _otpValues[i] = _controllers[i].text;
        });

        // Call onChanged callback
        if (widget.onChanged != null) {
          widget.onChanged!(AppHelpers.getOTPString(_otpValues));
        }

        // Call onCompleted when OTP is complete
        if (AppHelpers.isOTPComplete(_otpValues)) {
          widget.onCompleted(AppHelpers.getOTPString(_otpValues));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) {
        bool hasValue = _otpValues[index].isNotEmpty;

        return Container(
          width: AppDimensions.otpInputWidth,
          height: AppDimensions.otpInputHeight,
          decoration: BoxDecoration(
            color: hasValue ? AppColors.primaryBrown : AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(AppDimensions.otpInputBorderRadius),
            border: hasValue
                ? null
                : Border.all(
                    color: AppColors.borderColor,
                    width: 1,
                  ),
          ),
          child: Center(
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: hasValue ? Colors.white : AppColors.primaryTextColor,
              ),
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                AppHelpers.moveToNextOTPField(
                  value: value,
                  currentIndex: index,
                  focusNodes: _focusNodes,
                  maxLength: widget.length,
                );
              },
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
