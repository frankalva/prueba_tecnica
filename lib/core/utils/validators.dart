class Validators {
  static String? notEmpty(String? value, {String field = 'Campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field cannot be empty';
    }
    return null;
  }
}
