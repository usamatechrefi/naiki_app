import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateRequestState {
  final int currentStep;
  final String? requestType;
  final String description;
  final String amount;
  final String? bankName;
  final String accountHolderName;
  final String accountNumber;
  final String iban;
  final String? voiceMessagePath;
  final List<String> additionalPhotos;
  final bool isLoading;
  final String? error;
  final bool isStep1Valid;
  final bool isStep2Valid;

  const CreateRequestState({
    this.currentStep = 0,
    this.requestType,
    this.description = '',
    this.amount = '',
    this.bankName,
    this.accountHolderName = '',
    this.accountNumber = '',
    this.iban = '',
    this.voiceMessagePath,
    this.additionalPhotos = const [],
    this.isLoading = false,
    this.error,
    this.isStep1Valid = false,
    this.isStep2Valid = false,
  });

  CreateRequestState copyWith({
    int? currentStep,
    String? requestType,
    String? description,
    String? amount,
    String? bankName,
    String? accountHolderName,
    String? accountNumber,
    String? iban,
    String? voiceMessagePath,
    List<String>? additionalPhotos,
    bool? isLoading,
    String? error,
    bool? isStep1Valid,
    bool? isStep2Valid,
  }) {
    return CreateRequestState(
      currentStep: currentStep ?? this.currentStep,
      requestType: requestType ?? this.requestType,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      bankName: bankName ?? this.bankName,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountNumber: accountNumber ?? this.accountNumber,
      iban: iban ?? this.iban,
      voiceMessagePath: voiceMessagePath ?? this.voiceMessagePath,
      additionalPhotos: additionalPhotos ?? this.additionalPhotos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isStep1Valid: isStep1Valid ?? this.isStep1Valid,
      isStep2Valid: isStep2Valid ?? this.isStep2Valid,
    );
  }
}

class CreateRequestNotifier extends StateNotifier<CreateRequestState> {
  CreateRequestNotifier() : super(const CreateRequestState());

  void setRequestType(String? type) {
    state = state.copyWith(requestType: type);
    _validateStep1();
  }

  void setDescription(String value) {
    state = state.copyWith(description: value);
    _validateStep1();
  }

  void setAmount(String value) {
    state = state.copyWith(amount: value);
    _validateStep2();
  }

  void setBankName(String? value) {
    state = state.copyWith(bankName: value);
    _validateStep2();
  }

  void setAccountNumber(String value) {
    state = state.copyWith(accountNumber: value);
    _validateStep2();
  }

  void setBankDetails({
    required String? bankName,
    required String accountHolderName,
    required String accountNumber,
    required String iban,
    required bool isValid,
  }) {
    state = state.copyWith(
      bankName: bankName,
      accountHolderName: accountHolderName,
      accountNumber: accountNumber,
      iban: iban,
      isStep2Valid: isValid && state.amount.trim().isNotEmpty,
    );
  }

  void setVoiceMessage(String? path) {
    state = state.copyWith(voiceMessagePath: path);
  }

  void addPhoto(String path) {
    state = state.copyWith(additionalPhotos: [...state.additionalPhotos, path]);
  }

  void removePhoto(int index) {
    if (index >= 0 && index < state.additionalPhotos.length) {
      final updatedPhotos = List<String>.from(state.additionalPhotos)..removeAt(index);
      state = state.copyWith(additionalPhotos: updatedPhotos);
    }
  }

  void setPhotos(List<String> paths) {
    state = state.copyWith(additionalPhotos: paths);
  }

  void nextStep() {
    if (state.currentStep == 0) {
      if (_validateStep1()) {
        state = state.copyWith(currentStep: 1, error: null);
      } else {
        state = state.copyWith(error: 'Please fill all required fields correctly.');
      }
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1, error: null);
    }
  }

  bool _validateStep1() {
    final isValid = state.requestType != null &&
        state.description.trim().isNotEmpty &&
        _validateWordCount(state.description);
    state = state.copyWith(isStep1Valid: isValid);
    return isValid;
  }

  bool _validateWordCount(String text) {
    // Basic validation, detailed validation is in UI validators
    return text.trim().isNotEmpty; 
  }

  bool _validateStep2() {
    // For the simplified step 2, we only need bank name, account number, and amount
    final isValid = state.bankName != null &&
        state.accountNumber.trim().isNotEmpty &&
        state.amount.trim().isNotEmpty;
    
    state = state.copyWith(isStep2Valid: isValid);
    return isValid;
  }

  Future<bool> submitRequest() async {
    if (!_validateStep2()) {
      state = state.copyWith(error: 'Please fill all required fields.');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to submit request. Please try again.');
      return false;
    }
  }
}

final createRequestProvider = StateNotifierProvider.autoDispose<CreateRequestNotifier, CreateRequestState>((ref) {
  return CreateRequestNotifier();
});
