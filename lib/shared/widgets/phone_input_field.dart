import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_flags/country_flags.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';

class PhoneInputField
    extends StatelessWidget {
  final TextEditingController
      controller;
  final String? Function(String?)?
      validator;
  final String
      countryCode;
  final VoidCallback?
      onCountryTap;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.validator,
    this.countryCode =
        'AE',
    this.onCountryTap,
  });

  @override
  Widget
      build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.phoneNumberLabel,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryTextColor,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(AppDimensions.textFieldBorderRadius),
          ),
          child: Row(
            children: [
              // Country Code Dropdown
              GestureDetector(
                onTap: onCountryTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMedium,
                    vertical: AppDimensions.paddingMedium,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 0.5,
                          ),
                        ),
                        child: ClipOval(
                          child: CountryFlag.fromCountryCode(
                            countryCode,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingSmall),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.lightBrown,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              // Phone Number Input
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  validator: validator,
                  decoration: InputDecoration(
                    hintText: AppStrings.phoneHint,
                    hintStyle: GoogleFonts.poppins(
                      color: AppColors.hintTextColor,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.paddingMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
