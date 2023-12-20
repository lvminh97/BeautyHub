class ValidateUtils {
  static final emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email là bắt buộc';
    } else if (!emailReg.hasMatch(value)) {
      return 'Email không đúng định dạng';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu là bắt buộc';
    }
    return null;
  }

  static String? validateEmptyData(String? value) {
    if (value == null || value.isEmpty) {
      return 'Trường dữ liệu này là bắt buộc';
    }
    return null;
  }

}
