class ApiConstants {
  static String baseURL = 'http://10.0.2.2:3000';
  static String apiURL = '/api/v0';
  /* AUTH  */
  static String register = '/auth/register';
  static String login = '/auth/login';
  static String refresh = '/auth/refresh';
  static String logout = '/auth/logout';

  /* USER */
  static String whoAmI = '/user/whoami';
  static String isUsernameUnique = '/user/unique';

  /* ALL */
  static String post = "/post";
  static String conn = "/conn";
  static String story = "/story";
  static String event = "/event";
}
