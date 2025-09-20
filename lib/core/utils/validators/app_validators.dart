class AppValidators {

 static String? checkUserName({required String field,required String value}){
    if(value.isEmpty || value != 'user123'){
      return 'Enter Valid UserName';
    }
    return null;
  }

  static String? checkPassword({required String field,required String value}){
    if(value.isEmpty || value != '123456'){
      return 'Enter Valid Password';
    }
    return null;
  }
}