class FieldValidate {
  static String? validateEmail(String? value) {
    if (value == null) return "Empty!!";
    if (value.isEmpty) return 'Enter Email';

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null) return "Empty!!";
    if (value.isEmpty) return 'Enter Password';
    if (value.length < 7) {
      return 'Password must be more than 6 characters';
    }
    return null;
  }

  static String? validateNumber(String? value) {
    if (value == null) return "Empty!!";
    if (value.isEmpty) return 'Enter Phone Number';

    String numPattern =
        r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';
    RegExp regex = RegExp(numPattern);
    if (value.length < 10) {
      return "Length of your phone number doesn't match";
    } else if (!regex.hasMatch(value)) {
      return "Please Enter a Valid Phone Number";
    } else {
      return null;
    }
  }

  static String? valueToken(String? value) {
    if (value == null) return "Empty field!";
    if (value.isEmpty) return 'Enter Your Confirmation Token.';
    return null;
  }
}
