class Validations{
  static bool isValidUser(String user){
    return user != null && user.length>6 && user.contains("@");
  }
  static bool isValidPassword(String pass){
    return pass != null && pass.length>6;
  }
  static bool isValidPhone(String phone){
    return phone !=null &&phone.length>6;
  }
  static bool isValidName(String name){
    return name !=null &&name.length>4;
  }
  static bool isValidcity(String city){
    return city !=null &&city.length>2;
  }
  static bool isValidTime(String time)
  {
    return time != null&&time.length>2&&time.contains("AM")||time.contains("PM");
  }
}