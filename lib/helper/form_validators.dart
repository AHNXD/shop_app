import 'dart:developer';

class FormValidators {
  String? userNameValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return "حقل اجباري";
      } else if (value.length < 3) {
        return "الاسم يجب ان يكون من 3 احرف على الاقل";
      } else if (value.length > 30) {
        return "الاسم يجب ان لا يزيد عن 30 حرف";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String? locationDetailsValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return "حقل اجباري";
      } else if (value.length < 3) {
        return "الموقع يجب ان يكون من 3 احرف على الاقل";
      } else if (value.length > 40) {
        return "الموقع يجب ان لا يزيد عن 40 حرف";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String? emailValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return "Required Field";
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
        return "Enter correct email";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String? strongPasswordValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return "Required Field";
      } else if (value.length < 8) {
        return "Password Must be At Least 8 Characters";
      } else if (RegExp(r'^-?[0-9]+$').hasMatch(value)) {
        return 'Password Should Contain Numbers & Characters';
      } else if (RegExp(r'^[a-z]+$').hasMatch(value)) {
        return 'Password Should Contain Numbers & Characters';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String? weakPasswordValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return "حقل اجباري";
      } else if (value.length < 4) {
        return "كلمة المرور يجب ان تحوي 4 خانات على الاقل";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String? phoneNumberValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return "حقل اجباري";
      } else if (int.tryParse(value) == null) {
        return "رقم الهاتف يجب ان لايحوي احرف";
      } else if (value.length != 10) {
        return "رقم الهاتف يجب ان يكون 10 ارقام";
      } else if (value.indexOf('09') != 0) {
        return "رقم الهاتف غير صالح";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String? priceValidator(String? value) {
    try {
      if (value != null) {
        if (value.isEmpty) {
          return "حقل اجباري";
        } else if (num.parse(value) < 0) {
          return "يجب ادخال مبلغ صالح";
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on Exception catch (e) {
      log('e: ${e}');
      return null;
    }
  }

  String? explainationValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return "حقل اجباري";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
