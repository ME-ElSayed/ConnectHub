import 'package:connect_hub/core/utils/validation_types.dart';


class AppValidator {
  static String? validate({
    required String value,
    required ValidationType type,
    int? min,
    int? max,
    String? matchWith,
  }) {
    value = value.trim();
    final RegExp nameRegex = RegExp(
      r"^\p{L}+([-'']\p{L}+)*(?: \p{L}+([-'']\p{L}+)*)*$",
      unicode: true,
    );
    if (value.trim().isEmpty) {
      return "This field is required";
    }

    // Length validation (not for email)
    if (type != ValidationType.email) {
      if (min != null && value.length < min) {
        return "Must be at least $min characters";
      }

      if (max != null && value.length > max) {
        return "Must be less than $max characters";
      }
    }

    switch (type) {
      case ValidationType.username:
        if (!_isValidUsername(value)) {
          return "Invalid username";
        }
        break;

      case ValidationType.email:
        if (!_isValidEmail(value)) {
          return "Invalid email address";
        }
        break;

      case ValidationType.phone:
        if (!_isValidPhoneNumber(value)) {
          return "Invalid phone number";
        }
        break;

      case ValidationType.password:
        if (!value.contains(RegExp(r'[A-Z]'))) {
          return "Must contain at least one capital letter";
        }
        if (!value.contains(RegExp(r'[0-9]'))) {
          return "Must contain at least one number";
        }
        break;

      case ValidationType.confirmPassword:
        if (value != matchWith) {
          return "Passwords do not match";
        }
        break;

      
      case ValidationType.fullname:
        if (!nameRegex.hasMatch(value)) {
          return 'Enter a valid name';
        }

        break;
      
    }

    return null;
  }

  static bool _isValidUsername(String value) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    return usernameRegex.hasMatch(value);
  }

  static bool _isValidEmail(String value) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(value);
  }

  static bool _isValidPhoneNumber(String value) {
    final RegExp phoneRegex = RegExp(r'^[0-9]{7,15}$');
    return phoneRegex.hasMatch(value);
  }
}
