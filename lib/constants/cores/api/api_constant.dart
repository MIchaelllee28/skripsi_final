class ApiConstant {
  ApiConstant._();

  static const String production =
      'https://67500d8e69dc1669ec197504.mockapi.io/';

  /// URL untuk API Production
  static const String staging = 'https://67500d8e69dc1669ec197504.mockapi.io/';

  /// URL untuk API Staging
}

class ApiEndPoints {
  static String baseUrl = "https://67500d8e69dc1669ec197504.mockapi.io/";
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = '';
  final String loginEmail = 'auth/login';
}
