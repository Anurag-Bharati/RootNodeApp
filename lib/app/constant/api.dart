class ApiConstants {
  static const String baseUrl = 'http://192.168.1.71:3000';
  /* AUTH  */
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';

  /* USER */
  static const String whoAmI = '/api/v0/user/whoami';
  static const String isUsernameUnique = '/api/v0/user/unique';

  /* ALL */
  static const String auth = "/api/v0/auth";
  static const String user = "/api/v0/user";
  static const String post = "/api/v0/post";
  static const String conn = "/api/v0/conn";
  static const String story = "/api/v0/story";
  static const String event = "/api/v0/event";
}
