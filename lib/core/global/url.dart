class Url{
  static const String baseUrl= 'https://back-dev.hollat.net/hollat_upgrade_develop/public/';
  static const String api= '${baseUrl}api/mobile/';
  static const String reloadCaptcha= '${api}reload-captcha';
  static const String selfServiceConfig= '${api}self_service_configs';
  static const String selfService= '${api}self_service/';
  static const String allNationalTypes= '${api}all-national-types';
  static const String nafaz= '${api}nafath';
  static const String nafazStatus= '${api}nafath_status';
  static const String sendVerifyCode= '${api}sendVerifyCode';
  static const String verifyEmail= '${selfService}verify-email';
  static const String verifyOtpEmail= '${api}VerifyOtpEmail';
  static const String nafazVerifyMobile = '${api}verifyMobile';
  static const String verifyOtp = '${api}verifyOtp';
  static const String sendOtp = '${api}sendOtp';
  static const String createClient = '${api}createClient';
  static const String clientProfile = '${api}client-profile';
  static const String updateProfile = '${api}update-profile';
  static const String logout = '${api}logout';

  static const String allCountries = '${api}all_countries';
  static const String allRegions = '${api}all_regions';
  static const String allCities = '${api}all_cities';

  static const String oldTickets = '${api}old-tickets';
  static const String storeTicket = '${api}store-ticket';
  static const String searchTicket = '${api}search-ticket';
  static const String allTicketTypes = '${api}all-ticket-types';

  static const String selfServiceFields = '${api}selfService-fields';
  static const String allMainReasons = '${api}all-main-reasons';
  static const String allSubReasons = '${api}all-sub-reasons';
  static const String allOrganizations = '${api}all-organizations';
  static const String allSubSubReasons = '${api}all-sub-sub-reasons';
  static const String allSubSubSubReasons = '${api}all-sub-sub-sub-reasons';


  static const String getToCustomerReplies = '${api}getToCustomerReplies';
  static const String questions = '${api}questions';
  static const String downloadFile = '${api}downloadFile';
}