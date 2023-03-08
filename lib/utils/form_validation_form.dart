class FormValidatorHelper {
  static String? checkEmpty(String? value) {
    if (value != null && value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }

  static String? validateName(String value) {
    if (value.length < 5) {
      return 'Name must not be less than 5 characters';
    }

    return null;
  }
  static String? validateTitle(String value) {
    if (value.length < 5) {
      return 'title must not be less than 5 characters';
    }

    return null;
  }

  static String? validateDescription(String value) {
    if (value.length < 10) {
      return 'description must not be less than 10 characters';
    }

    return null;
  }

  static String? isNumber(String? s) {
    if (s == null) {
      return 'Please enter number';
    }
    s = s.replaceAll("-", "");
    return double.tryParse(s) != null ? null : 'Please enter number';
  }

  static String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (value != null && !regex.hasMatch(value.trim())) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value){
    if(value == null || value.length <5){
      return "Please enter strong password!!!";
    }else{
      return null;
    }
  }
  static String? validateDateOfBirth(String? value) {
    Pattern pattern =
        r'^(0[1-9]|1[012])[-/.](0[1-9]|[12][0-9]|3[01])[-/.](19|20)\\d\\d$';
    RegExp regex = RegExp(pattern.toString());

    if (value != null && !regex.hasMatch(value.trim())) {
      return 'Enter Valid Date of Birth';
    } else {
      return null;
    }

  }


}
