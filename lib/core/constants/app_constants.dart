abstract class AppConstants {
  // Base URL for remote packages index
  static const String packagesIndexUrl = 
      'https://cdn.jsdelivr.net/gh/SkrybaOtis/strt_mstr_invests/blob/main/random_paczki/index.json';
      
  
  // Base URL for downloading packages
  static const String packagesBaseUrl = 
      'https://cdn.jsdelivr.net/gh/SkrybaOtis/strt_mstr_invests/tree/main/investigations/';
  
  // Local storage keys
  static const String downloadedPackagesKey = 'downloaded_packages';
  
  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 60);
  
  // Pagination
  static const int pageSize = 20;
}