

class Validation{

  String? validator(String? value) {
  if (value == null || value.isEmpty || value == 'null') {
  return '*required';
  }
  return null;
}

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty || value == 'null') {
      return '*required';
    }else if(!value.contains('@')){
      return 'Invalid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty || value == 'null') {
      return '*required';
    }else if(value.length < 6){
      return 'password must be at least 6';
    }
    return null;
  }


  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty || value == 'null') {
      return '*required';
    }else if(value.length != 10){
      return 'phone must have 10 numbers';
    }
    return null;
  }



}

