import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PaymentState {
  final String? paymentSlipPath;
  final bool isUploading;
  final bool isProcessing;
  final String? error;

  const PaymentState({
    this.paymentSlipPath,
    this.isUploading = false,
    this.isProcessing = false,
    this.error,
  });

  PaymentState copyWith({
    String? paymentSlipPath,
    bool? isUploading,
    bool? isProcessing,
    String? error,
  }) {
    return PaymentState(
      paymentSlipPath: paymentSlipPath ?? this.paymentSlipPath,
      isUploading: isUploading ?? this.isUploading,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error,
    );
  }

  bool get hasPaymentSlip => paymentSlipPath != null && paymentSlipPath!.isNotEmpty;
}

class PaymentNotifier extends StateNotifier<PaymentState> {
  final ImagePicker _imagePicker = ImagePicker();

  PaymentNotifier() : super(const PaymentState());

  Future<void> pickPaymentSlip() async {
    state = state.copyWith(isUploading: true, error: null);

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        state = state.copyWith(
          paymentSlipPath: image.path,
          isUploading: false,
        );
      } else {
        state = state.copyWith(isUploading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isUploading: false,
        error: 'Failed to pick image: ${e.toString()}',
      );
    }
  }

  void removePaymentSlip() {
    state = state.copyWith(paymentSlipPath: null);
  }

  Future<bool> submitPayment() async {
    if (!state.hasPaymentSlip) {
      state = state.copyWith(error: 'Please upload payment slip');
      return false;
    }

    state = state.copyWith(isProcessing: true, error: null);

    try {
      // Simulate API call to submit payment
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Integrate real API call here
      // Example:
      // final response = await paymentRepository.submitPayment(
      //   paymentSlipPath: state.paymentSlipPath!,
      //   donationAmount: amount,
      //   recipientId: recipientId,
      // );

      state = state.copyWith(isProcessing: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: 'Failed to submit payment: ${e.toString()}',
      );
      return false;
    }
  }

  void reset() {
    state = const PaymentState();
  }
}

final paymentProvider = StateNotifierProvider.autoDispose<PaymentNotifier, PaymentState>((ref) {
  return PaymentNotifier();
});
