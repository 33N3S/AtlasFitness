bool isValidEmail(String email) {
  // Regular expression for validating an email
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );
  return emailRegExp.hasMatch(email);
}

bool isValidPassword(String password) {
  // Password validation criteria
  // At least 8 characters long
  // Contains at least one uppercase letter
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])[A-Za-z\d@$!%*?&]{8,}$'
  );
  return password.length >= 8 && passwordRegExp.hasMatch(password);
}

bool isHeightValid(String height, String unit) {
  if (unit == "ft") {
    // Check if height is in format X.Y (feet.inches)
    final parts = height.split('.');
    if (parts.length != 2) return false;

    final feet = int.tryParse(parts[0]);
    final inches = int.tryParse(parts[1]);

    return feet != null && inches != null &&
           feet >= 0 && inches >= 0 && inches < 12;
  } else if (unit == "cm") {
    // Check if height is a valid number and positive
    final heightInCm = double.tryParse(height);
    return heightInCm != null && heightInCm > 0;
  }
  return false; // Invalid unit
}


