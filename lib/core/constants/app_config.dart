/// ------------------------------------------------------------
/// AppConfig (SENIOR / OPTION 2 READY)
/// ------------------------------------------------------------
/// - Environment set from main_dev / main_prod
/// - No local storage
/// - No networking logic
/// - No UI
/// ------------------------------------------------------------

// ignore_for_file: dangling_library_doc_comments

enum Environment { dev, staging, prod }

class AppConfig {
  AppConfig._();

  // ============================================================
  // ENVIRONMENT (SET AT RUNTIME)
  // ============================================================
  static late Environment environment;

  static bool get isDev => environment == Environment.dev;
  static bool get isStaging => environment == Environment.staging;
  static bool get isProd => environment == Environment.prod;

  // ============================================================
  // APP INFO
  // ============================================================
  static const String appName = "Folder Structure";
  static const String appVersion = "1.0.0";
  static const int buildNumber = 1;

  // ============================================================
  // API CONFIGURATION
  // ============================================================
  static String get baseUrl {
    switch (environment) {
      case Environment.dev:
        return "https://dev.maxfit.cooleats.cool/api/v1";
      case Environment.staging:
        return "https://staging.maxfit.cooleats.cool/api/v1";
      case Environment.prod:
        return "https://maxfit.cooleats.cool/api/v1";
    }
  }

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  // ============================================================
  // LOGGING FLAGS
  // ============================================================
  static bool get enableLogs => isDev || isStaging;
  static bool get enableNetworkLogs => isDev;

  // ============================================================
  // FEATURE FLAGS
  // ============================================================
  static const bool enableAuth = true;
  static const bool enableBranches = true;
  static const bool enablePayments = false;
  static const bool enableExperimentalUI = false;

  // ============================================================
  // LIMITS & CONSTANTS
  // ============================================================
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int maxUploadSizeMB = 10;

  // ============================================================
  // EXTERNAL LINKS
  // ============================================================
  static const String privacyPolicyUrl = "https://maxfit.cooleats.cool/privacy";
  static const String termsUrl = "https://maxfit.cooleats.cool/terms";
  static const String supportEmail = "support@cooleats.cool";
}
