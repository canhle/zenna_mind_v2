abstract class Validators {
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final _phoneRegex = RegExp(r'^[+]?[0-9]{9,15}$');

  static bool isValidEmail(String email) => _emailRegex.hasMatch(email.trim());

  static bool isValidPhone(String phone) =>
      _phoneRegex.hasMatch(phone.replaceAll(RegExp(r'[\s\-()]'), ''));

  static bool isNotEmpty(String? value) =>
      value != null && value.trim().isNotEmpty;

  static bool hasMinLength(String value, int minLength) =>
      value.length >= minLength;

  static bool hasMaxLength(String value, int maxLength) =>
      value.length <= maxLength;

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!isValidEmail(value)) return 'Invalid email format';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone is required';
    if (!isValidPhone(value)) return 'Invalid phone format';
    return null;
  }

  static String? validateRequired(String? value, [String fieldName = 'Field']) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  static String? validateMinLength(String? value, int minLength,
      [String fieldName = 'Field']) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
  }
}
