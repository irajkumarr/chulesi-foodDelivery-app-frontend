import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:pinput/pinput.dart';

class OtpFormField extends StatelessWidget {
  const OtpFormField({super.key});

  @override
  Widget build(BuildContext context) {
    // final formProvider = Provider.of<FormProvider>(context);
    // final authRepo = Provider.of<AuthenticationRepository>(context);

    return Form(
      // key: formProvider.otpFormKey,
      child: Column(
        children: [
          //otp form field
          Pinput(
            length: 6,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter OTP';
              } else if (value.length != 6) {
                return 'OTP must be exactly 6 digits';
              }

              return null;
            },
            defaultPinTheme: PinTheme(
              width: 56.w,
              height: 56.h,
              textStyle:  TextStyle(
                  fontSize: 20.sp,
                  color: KColors.secondary,
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                color: KColors.white,
                border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
                borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
              ),
            ),
            focusedPinTheme: PinTheme(
              width: 56.w,
              height: 56.h,
              textStyle:  TextStyle(
                  fontSize: 20.sp,
                  color: KColors.primary,
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                color: KColors.white,
                border: Border.all(color: KColors.primary),
                borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
              ),
            ),
            submittedPinTheme: PinTheme(
              width: 56.w,
              height: 56.h,
              textStyle:  TextStyle(
                  fontSize: 20.sp,
                  color: KColors.black,
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                color: KColors.white,
                border: Border.all(color: KColors.secondary),
                borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
              ),
            ),
            disabledPinTheme: PinTheme(
              width: 56.w,
              height: 56.h,
              textStyle:  TextStyle(
                  fontSize: 20.sp,
                  color: KColors.black,
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                color: KColors.white,
                border: Border.all(color: KColors.secondary),
                borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
              ),
            ),
            onCompleted: (value) {
              // formProvider.setOtp(value);
              // authRepo.verifyOTP(
              //     context, verificationId, formProvider.otp.toString());
            },
          ),

          SizedBox(height: KSizes.spaceBtwSections * 2),

          //submit button
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {},
              //  !formProvider.validateOtpForm()
              //     ? null
              //     : () {
              //         if (formProvider.validateOtpForm()) {
              //           formProvider.saveOtpForm();
              //           authRepo.verifyOTP(context, verificationId,
              //               formProvider.otp.toString());
              //           // Navigator.pushNamedAndRemoveUntil(
              //           //     context, "/signup", (route) => false);
              //         } else {
              //           KLoaders.snackbar(context, title: Text('Invalid OTP'));
              //         }
              //       },
              child:
                  // authRepo.loading
                  //     ? KIndicator.circularIndicator(KColors.white)
                  //     :
                  const Text("Verify"),
            ),
          ),
          SizedBox(height: KSizes.spaceBtwSections * 1.5),
          //not getting code and resend code
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Didn't get the code?",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: KColors.textGrey)),
              TextButton(
                onPressed: () {
                  // print("+${977}${formProvider.phoneController.text.trim()}");
                },
                child: Text("Resend code",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: KColors.primary)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
