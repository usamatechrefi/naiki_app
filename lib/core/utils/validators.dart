import 'dart:io';

class Validators {
  // Private constructor to prevent instantiation
  Validators._();

  // ==================== NAME VALIDATORS ====================

  // Validates a full name field
  // - Must not be empty
  // - Must be at least 3 characters long
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  // Validates father/husband name field
  // - Must not be empty
  // - Must be at least 3 characters long
  static String? validateFatherHusbandName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter father/husband name';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  // Generic name validator (can be used for any name field)
  // - Must not be empty
  // - Must be at least [minLength] characters long
  static String? validateName(String? value, {int minLength = 3, String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter ${fieldName ?? 'name'}';
    }
    if (value.trim().length < minLength) {
      return '${fieldName ?? 'Name'} must be at least $minLength characters';
    }
    return null;
  }

  // ==================== CNIC VALIDATORS ====================

  // Validates Pakistani CNIC number with proper format
  // - Must not be empty
  // - Must follow format: 12345-1234567-1 (5 digits - 7 digits - 1 digit)
  // - Total of 13 digits in the format xxxxx-xxxxxxx-x
  static String? validateCnic(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter CNIC number';
    }

    // CNIC Format: 12345-1234567-1 (5-7-1 digits with hyphens)
    final cnicRegex = RegExp(r'^[0-9]{5}-[0-9]{7}-[0-9]{1}$');

    if (!cnicRegex.hasMatch(value)) {
      return 'CNIC format must be 12345-1234567-1';
    }

    return null;
  }

  // ==================== PHONE VALIDATORS ====================

  // Validates Pakistani phone number (10 digits after +92)
  // - Required field
  // - Must be exactly 10 digits
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    // Remove any non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 10) {
      return 'Enter valid 10-digit number';
    }
    return null;
  }

  // Validates optional Pakistani phone number
  // - Optional field (can be empty)
  // - If provided, must be exactly 10 digits
  static String? validateOptionalPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field, so null/empty is valid
    }
    // Remove any non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 10) {
      return 'Enter valid 10-digit number';
    }
    return null;
  }

  // ==================== ADDRESS VALIDATORS ====================

  // Validates complete address
  // - Must not be empty
  // - Must be at least 10 characters long
  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your complete address';
    }
    if (value.trim().length < 10) {
      return 'Please enter a complete address';
    }
    return null;
  }

  // Validates city/district name
  // - Must not be empty
  // - Must be at least 3 characters long
  static String? validateCity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your city/district';
    }
    if (value.trim().length < 3) {
      return 'Please enter a valid city/district name';
    }
    return null;
  }

  // ==================== DATE VALIDATORS ====================

  // Validates date of birth
  // - Must not be empty
  static String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select date of birth';
    }
    return null;
  }

  // Generic required date validator
  static String? validateRequiredDate(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return 'Please select ${fieldName ?? 'date'}';
    }
    return null;
  }

  // ==================== STORY/TEXT VALIDATORS ====================

  // Validates story text with word count requirements
  // - Must not be empty
  // - Must be between [minWords] and [maxWords]
  static String? validateStory(String? value, int wordCount, {int minWords = 0, int maxWords = 500}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please share your story';
    }
    if (wordCount < minWords) {
      return 'Story must be at least $minWords words';
    }
    if (wordCount > maxWords) {
      return 'Story must not exceed $maxWords words';
    }
    return null;
  }

  // Generic text validator with minimum length
  static String? validateText(String? value, {int minLength = 1, String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter ${fieldName ?? 'text'}';
    }
    if (value.trim().length < minLength) {
      return '${fieldName ?? 'Text'} must be at least $minLength characters';
    }
    return null;
  }

  // ==================== EMAIL VALIDATORS ====================

  // Validates email format (for future use)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter email address';
    }
    // Basic email validation regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validates optional email format
  static String? validateOptionalEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // ==================== IMAGE/FILE VALIDATORS ====================

  // Validates selfie/image upload
  // - Must not be null (image must be selected)
  // - Optionally validates file existence
  static String? validateSelfie(File? imageFile, {String? fieldName}) {
    if (imageFile == null) {
      return 'Please upload ${fieldName ?? 'your selfie'}';
    }

    // Additional check: verify file exists
    if (!imageFile.existsSync()) {
      return 'Selected image file does not exist';
    }

    return null;
  }

  // Validates CNIC image upload
  // - Must not be null (image must be selected)
  static String? validateCnicImage(File? imageFile) {
    if (imageFile == null) {
      return 'Please upload your CNIC image';
    }

    if (!imageFile.existsSync()) {
      return 'Selected CNIC image does not exist';
    }

    return null;
  }

  // Generic image/file validator with custom message
  // - Must not be null
  // - Optionally validates file size
  static String? validateImage(
      File? imageFile, {
        String? fieldName,
        int? maxSizeInMB,
      }) {
    if (imageFile == null) {
      return 'Please upload ${fieldName ?? 'an image'}';
    }

    if (!imageFile.existsSync()) {
      return 'Selected image does not exist';
    }

    // Validate file size if specified
    if (maxSizeInMB != null) {
      final fileSizeInBytes = imageFile.lengthSync();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > maxSizeInMB) {
        return 'Image size must not exceed $maxSizeInMB MB';
      }
    }

    return null;
  }

  // ==================== BANKING VALIDATORS ====================

  // Validates Account Number
  // - Must be numeric
  // - Must be between 10 and 20 digits
  static String? validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter account number';
    }
    // Remove any spaces or dashes
    final cleanValue = value.replaceAll(RegExp(r'[\s-]'), '');

    if (!RegExp(r'^[0-9]+$').hasMatch(cleanValue)) {
      return 'Account number must contain only digits';
    }

    if (cleanValue.length < 10 || cleanValue.length > 20) {
      return 'Account number must be between 10 and 20 digits';
    }
    return null;
  }

  // Validates IBAN (Pakistan Standard)
  // - Must start with PK
  // - Must be exactly 24 digits after PK (Total 26 chars)
  static String? validateIBAN(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter IBAN';
    }

    // Remove spaces and convert to uppercase
    final cleanValue = value.replaceAll(RegExp(r'\s'), '').toUpperCase();

    if (!cleanValue.startsWith('PK')) {
      return 'IBAN must start with PK';
    }

    if (cleanValue.length != 26) {
      return 'IBAN must be exactly 26 characters (PK + 24 digits)';
    }

    // Check if the remaining 24 characters are digits
    final digits = cleanValue.substring(2);
    if (!RegExp(r'^[0-9]+$').hasMatch(digits)) {
      return 'Invalid IBAN format';
    }

    return null;
  }

  // ==================== UTILITY VALIDATORS ====================

  // Generic required field validator
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter ${fieldName ?? 'this field'}';
    }
    return null;
  }

  // Validates minimum length
  static String? validateMinLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Let required validator handle empty case
    }
    if (value.length < minLength) {
      return '${fieldName ?? 'Field'} must be at least $minLength characters';
    }
    return null;
  }

  // Validates maximum length
  static String? validateMaxLength(String? value, int maxLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Empty is valid for max length check
    }
    if (value.length > maxLength) {
      return '${fieldName ?? 'Field'} must not exceed $maxLength characters';
    }
    return null;
  }

  // Validates that value is numeric
  static String? validateNumeric(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Let required validator handle empty case
    }
    if (int.tryParse(value) == null && double.tryParse(value) == null) {
      return '${fieldName ?? 'Field'} must be a number';
    }
    return null;
  }

  // Combines multiple validators
  // Returns the first error message encountered, or null if all validations pass
  static String? combine(List<String? Function()> validators) {
    for (final validator in validators) {
      final error = validator();
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}