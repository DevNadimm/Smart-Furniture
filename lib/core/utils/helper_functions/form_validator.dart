class FormValidator {
  FormValidator._();

  static String? isRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? isEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? isPassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }

  static String? confirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? isPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{10,14}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? isName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    final nameRegex = RegExp(r"^[a-zA-Z\s'.-]+$");
    if (!nameRegex.hasMatch(value.trim())) {
      return 'Enter a valid name';
    }
    return null;
  }

  static String? isNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Number is required';
    }
    final numberRegex = RegExp(r'^\d+$');
    if (!numberRegex.hasMatch(value.trim())) {
      return 'Enter a valid number';
    }
    return null;
  }

  static String? minLength(String? value, int length, {String fieldName = 'Field'}) {
    if (value == null || value.length < length) {
      return '$fieldName must be at least $length characters';
    }
    return null;
  }

  static String? isValidUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    const urlPattern = r'^(https?:\/\/)?'
        r'(([a-zA-Z0-9\-_]+\.)+[a-zA-Z]{2,})'
        r'(\/[^\s]*)?$';
    final urlRegex = RegExp(urlPattern);

    if (!urlRegex.hasMatch(value.trim())) {
      return 'Enter a valid URL';
    }
    return null;
  }

}
