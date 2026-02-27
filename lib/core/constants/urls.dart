class Urls {
  static const String baseUrl = "https://fakestoreapi.com";
  static const String createUser = "$baseUrl/users";
  static const String login = "$baseUrl/auth/login";
  static const String products = "$baseUrl/products";
  static String profile(String userId) => "$baseUrl/users/$userId";
}