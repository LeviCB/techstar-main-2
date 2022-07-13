import 'package:get/get.dart';

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 6;

  bool isEmailValid(String email) =>
      GetUtils.isEmail(email.removeAllWhitespace);

  bool isPasswordSame(String password, String confirmPassword) =>
      password == confirmPassword;

  bool isPhoneNumberValid(String phone) => phone.length == 10;

  bool isUsernameValid(String username) =>
      username.removeAllWhitespace.isNotEmpty;
}
