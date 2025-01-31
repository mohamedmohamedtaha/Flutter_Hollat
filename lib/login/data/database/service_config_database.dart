import 'package:hive_ce/hive.dart';
part 'service_config_database.g.dart'; // Generated file

@HiveType(typeId: 0)
class ServiceConfigDatabase {
  @HiveField(0)
  int id = 0;

  @HiveField(1)
  String agentAddTicketsWithSameCriteria = "";

  @HiveField(2)
  String amplitudeEnabled = "";

  @HiveField(3)
  String beneficiaryMaxTicketsPerDay = "";

  @HiveField(4)
  String beneficiaryMaxTicketsPerDayPerOrg = "";

  @HiveField(5)
  String birthDateHijri = "";

  @HiveField(6)
  String chatBotEnabled = "";

  @HiveField(7)
  String chatBotSrcUrl = "";

  @HiveField(8)
  String mainSiteURl = "";

  @HiveField(9)
  String smallImage = "";

  @HiveField(10)
  String clientName = "";

  @HiveField(11)
  String clientNameAr = "";

  @HiveField(12)
  String email = "";

  @HiveField(13)
  String slaSolvingTime = "";

  @HiveField(14)
  String unifiedNumber = "";

  @HiveField(15)
  String workingHours = "";

  @HiveField(16)
  String uploadFilesFromSelfService = "";

  @HiveField(17)
  String feedbackExpiredTimeInDays = "";

  @HiveField(18)
  String selfServiceLoginEnabled = "";

  @HiveField(19)
  String selfServiceLoginWithMobile = "";

  @HiveField(20)
  String selfServiceLoginWithNationalId = "";

  @HiveField(21)
  String selfServiceLoginWay = "";

  @HiveField(22)
  String maintenanceMode = "";

  @HiveField(23)
  String minCharsOnDetails = "";

  @HiveField(24)
  String mobileDefaultCountry = "";

  @HiveField(25)
  String nafathEnabled = "";

  @HiveField(26)
  String rateConfigId = "";

  @HiveField(27)
  String selfServiceAddTicketWithSameCriteria = "";

  @HiveField(28)
  String selfServiceAfterFeedbackMessageAr = "";

  @HiveField(29)
  String selfServiceAfterFeedbackMessageEn = "";

  @HiveField(30)
  String selfServiceClientCanChangeStatus = "";

  @HiveField(31)
  String selfServiceOtpBy = "";

  @HiveField(32)
  String selfServiceShowTerms = "";

  @HiveField(33)
  String selfServiceSimilarTicket = "";

  @HiveField(34)
  String selfServiceTermsContent = "";

  @HiveField(35)
  String showNoCaseAtRating = "";

  @HiveField(36)
  String facebookUrl = "";

  @HiveField(37)
  String instagramUrl = "";

  @HiveField(38)
  String linkedinUrl = "";

  @HiveField(39)
  String snapChatUrl = "";

  @HiveField(40)
  String tiktokUrl = "";

  @HiveField(41)
  String twitterUrl = "";

  @HiveField(42)
  String youtubeURl = "";

  @HiveField(43)
  String selfServiceFeedbackQuestionnaire = "";

  @HiveField(44)
  String selfServiceHospitalID = "";

  @HiveField(45)
  String selfServiceOTPEnabled = "";

  @HiveField(46)
  String selfServiceOTPExpirationTimePerMin = "";

  @HiveField(47)
  String selfServiceBackgroundImage = "";

  @HiveField(48)
  String selfServiceContactUsDisplay = "";

  @HiveField(49)
  String selfServiceEnabled = "";

  @HiveField(50)
  String selfServiceKBDisplay = "";

  @HiveField(51)
  String copyRightAr = "";

  @HiveField(52)
  String copyRightEn = "";

  @HiveField(53)
  String copyRightUrl = "";

  @HiveField(54)
  String favIcon = "";

  @HiveField(55)
  String headerColor = "";

  @HiveField(56)
  String headerHoverColor = "";

  @HiveField(57)
  String largeLogo = "";

  @HiveField(58)
  String smallLogo = "";

  @HiveField(59)
  String primaryColor = "";

  @HiveField(60)
  String selfServiceDisplayFontAr = "";

  @HiveField(61)
  String selfServiceDisplayFontEn = "";

  @HiveField(62)
  String backgroundImage = "";

  @HiveField(63)
  String verifyMobileAfterLoginWithEmail = "";
  @override
  String toString() {
    return 'ServiceConfigDatabase('
        'largeLogo: $largeLogo, '
        'smallLogo: $smallLogo, '
        'primaryColor: $primaryColor, '
        'smallImage: $smallImage, '
        'nafathEnabled: $nafathEnabled, '
        'selfServiceOtpBy: $selfServiceOtpBy, '
        'verifyMobileAfterLoginWithEmail: $verifyMobileAfterLoginWithEmail'
        ')';
  }
}