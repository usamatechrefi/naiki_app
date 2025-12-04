// features/auth/state/auth_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpValidatorProvider = Provider<OtpValidator>((ref) => OtpValidator());

class OtpValidator {
  /// simple OTP validation that can be extended
  bool validate(String otp) => otp.trim().length == 4;
}
