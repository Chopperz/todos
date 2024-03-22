part of '../../enums/src/regexp.dart';

extension AppRegExpX on AppRegExp {
  RegExp get regExp {
    switch (this) {
      case AppRegExp.isEmail:
        const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
            r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
            r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
            r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
            r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
            r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
            r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
        return RegExp(pattern);
      case AppRegExp.hasSpecialCharacter:
        return RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' "'" ']');
      case AppRegExp.hasDigits:
        return RegExp(r'[0-9]');
      case AppRegExp.hasPhone:
        return RegExp(r'(0[689]{1})+([0-9]{8})+$');
      case AppRegExp.hasUpperCase:
        return RegExp(r'[A-Z]');
      case AppRegExp.hasLowerCase:
        return RegExp(r'[a-z]');
      case AppRegExp.hasAssignMoreOne:
        return RegExp(r"([@*~])(.*?)\1");
      case AppRegExp.hasDotMoreOne:
        return RegExp(r"([.*~])(.*?)\1");
      case AppRegExp.hasUnderscoreMoreOne:
        return RegExp(r"([_*~])(.*?)\1");
      case AppRegExp.promotionCodeNameEn:
        return RegExp(r'[a-zA-Z\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' "'" ']');
      case AppRegExp.promotionCode:
        return RegExp(r'[A-Za-z0-9!@#$%-_+=/\&*]');
      case AppRegExp.normalCase:
        return RegExp(r'[a-zA-Z0-9]');
    }
  }
}
