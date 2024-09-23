String? emailValidator(String? value){
  if (value != null && value.isNotEmpty) {
    if (!RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+$')
        .hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
  }
  return null;

}

String? emailValidatorNotEmpty(String? value){
  if (value != null && value.isNotEmpty) {
    if (!RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+$')
        .hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
  }
  if(value == null || value.isEmpty){
    return 'Enter email address';
  }
  return null;
}

String? validatePin(String? value) {
  if (value == null || value.isEmpty) {
    return 'Pin is required';
  } else if (value.length < 4) {
    return 'Pin must be at least 4 digits long';
  }
  return null;
}
