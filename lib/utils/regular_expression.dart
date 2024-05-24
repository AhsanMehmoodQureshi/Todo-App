class RegexValidation{

  static bool isEmailValid(String text) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+[a-zA-Z]").hasMatch(text);
  }

  static bool isPasswordValid(String text) {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d).{8,}$').hasMatch(text);
  }



}